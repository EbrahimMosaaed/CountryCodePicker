import 'package:country_code_picker/country_code.dart';
import 'package:country_code_picker/country_localizations.dart';
import 'package:flutter/material.dart';

/// selection dialog used for selection of the country code
class SelectionDialog extends StatefulWidget {
  final List<CountryCode> elements;
  final bool? showCountryOnly;
  final InputDecoration? searchDecoration;
  final TextStyle? searchStyle;
  final TextStyle? textStyle;
  final BoxDecoration? boxDecoration;
  final WidgetBuilder? emptySearchBuilder;
  final bool? showFlag;
  final double flagWidth;
  final double flagHieght;
  final Decoration? flagDecoration;
  final Size? size;
  final bool hideSearch;
  final Icon? closeIcon;
  final String? cancelText;
  final String? titleText;
  final Color? cancelTextColor;
  final Color? titleTextColor;
  final String? notFoundText;
  final Color? topDragColor;

  /// Background color of SelectionDialog
  final Color? backgroundColor;

  /// Boxshaow color of SelectionDialog that matches CountryCodePicker barrier color
  final Color? barrierColor;

  /// elements passed as favorite
  final List<CountryCode> favoriteElements;

  SelectionDialog(this.elements, this.favoriteElements,
      {Key? key,
      this.showCountryOnly,
      this.emptySearchBuilder,
      this.searchDecoration,
      this.searchStyle,
      this.textStyle,
      this.boxDecoration,
      this.showFlag,
      this.flagDecoration,
      this.flagWidth = 32,
      this.flagHieght = 32,
      this.size,
      this.backgroundColor,
      this.barrierColor,
      this.hideSearch = false,
      this.closeIcon,
      this.cancelText,
      this.titleText,
      this.cancelTextColor,
      this.titleTextColor,
      this.notFoundText,
      this.topDragColor})
      :
        //  this.searchDecoration = searchDecoration.prefixIcon == null
        //       ? searchDecoration.copyWith(prefixIcon: Icon(Icons.search))
        //       : searchDecoration,
        super(key: key);

  @override
  State<StatefulWidget> createState() => _SelectionDialogState();
}

class _SelectionDialogState extends State<SelectionDialog> {
  /// this is useful for filtering purpose
  late List<CountryCode> filteredElements;

  @override
  Widget build(BuildContext context) => Container(
        clipBehavior: Clip.hardEdge,
        width: widget.size?.width ?? MediaQuery.of(context).size.width,
        height:
            widget.size?.height ?? MediaQuery.of(context).size.height * 0.70,
        decoration: widget.boxDecoration ??
            BoxDecoration(
              color: widget.backgroundColor ?? Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              boxShadow: [
                BoxShadow(
                  color: widget.barrierColor ?? Colors.grey.withOpacity(1),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(height: 5),
            Center(
              child: Container(
                height: 5,
                width: 55,
                decoration: BoxDecoration(
                    color: widget.topDragColor ?? Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(12))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                children: [
                  Text(widget.titleText ?? 'Contry Code',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: widget.titleTextColor)),
                  Spacer(),
                  TextButton(
                    child: Text(widget.cancelText ?? 'Cancel',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: widget.cancelTextColor)),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            if (!widget.hideSearch)
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  style: widget.searchStyle,
                  decoration: widget.searchDecoration,
                  onChanged: _filterElements,
                ),
              ),
            Expanded(
              child: Container(
                // decoration: BoxDecoration(border: Border.all()),
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    widget.favoriteElements.isEmpty
                        ? const DecoratedBox(decoration: BoxDecoration())
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ...widget.favoriteElements.map(
                                (f) => SimpleDialogOption(
                                  child: Column(
                                    children: [
                                      _buildOption(f),
                                      Divider(thickness: 1, color: Colors.red)
                                    ],
                                  ),
                                  onPressed: () {
                                    _selectItem(f);
                                  },
                                ),
                              ),
                              const Divider(),
                            ],
                          ),
                    if (filteredElements.isEmpty)
                      _buildEmptySearchWidget(context)
                    else
                      ...filteredElements.map(
                        (e) => SimpleDialogOption(
                          padding: EdgeInsets.zero,
                          child: _buildOption(e),
                          onPressed: () {
                            _selectItem(e);
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  Widget _buildOption(CountryCode e) {
    return Container(
      // decoration: BoxDecoration(border: Border.all()),
      child: Column(
        children: [
          Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              if (widget.showFlag!)
                Flexible(
                  flex: 0,
                  child: Container(
                    // margin: const EdgeInsets.only(right: 10.0, left: 10),
                    decoration: widget.flagDecoration,
                    clipBehavior: widget.flagDecoration == null
                        ? Clip.none
                        : Clip.hardEdge,
                    child: Image.asset(
                      e.flagUri!,
                      package: 'country_code_picker',
                      width: widget.flagWidth,
                      height: widget.flagHieght,
                    ),
                  ),
                ),
              SizedBox(width: 10),
              Text(
                  widget.showCountryOnly!
                      ? e.toCountryStringOnly()
                      : e.toLongString(),
                  overflow: TextOverflow.fade,
                  style: widget.textStyle),
              Spacer(),
              Text(e.dialCode.toString(),
                  textDirection: TextDirection.ltr, style: widget.textStyle)
            ],
          ),
          Divider(
            thickness: 1,
            color: Colors.grey.withOpacity(0.16),
          )
        ],
      ),
    );
  }

  Widget _buildEmptySearchWidget(BuildContext context) {
    if (widget.emptySearchBuilder != null) {
      return widget.emptySearchBuilder!(context);
    }

    return Center(
      child: Text(widget.notFoundText ?? ''),
    );
  }

  @override
  void initState() {
    filteredElements = widget.elements;
    super.initState();
  }

  void _filterElements(String s) {
    s = s.toUpperCase();
    setState(() {
      filteredElements = widget.elements
          .where((e) =>
              e.code!.contains(s) ||
              e.dialCode!.contains(s) ||
              e.name!.toUpperCase().contains(s))
          .toList();
    });
  }

  void _selectItem(CountryCode e) {
    Navigator.pop(context, e);
  }
}
