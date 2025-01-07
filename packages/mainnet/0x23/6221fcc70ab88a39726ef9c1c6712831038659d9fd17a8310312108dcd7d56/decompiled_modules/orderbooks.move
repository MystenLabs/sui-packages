module 0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::orderbooks {
    public entry fun create_equipment_orderbook<T0: copy + drop>(arg0: &0x2::package::Publisher, arg1: &0x2::transfer_policy::TransferPolicy<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog_equipment::Equipment<T0>>, arg2: &mut 0x2::tx_context::TxContext) {
        create_orderbook<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog_equipment::Equipment<T0>>(arg0, arg1, arg2);
    }

    public entry fun create_orderbook<T0: store + key>(arg0: &0x2::package::Publisher, arg1: &0x2::transfer_policy::TransferPolicy<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::share<T0, 0x2::sui::SUI>(0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::new_with_protected_actions<T0, 0x2::sui::SUI>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_publisher<T0>(arg0), arg1, 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::custom_protection(true, true, true), arg2));
    }

    public entry fun create_part_orderbook<T0: copy + drop>(arg0: &0x2::package::Publisher, arg1: &0x2::transfer_policy::TransferPolicy<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Part<T0>>, arg2: &mut 0x2::tx_context::TxContext) {
        create_orderbook<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Part<T0>>(arg0, arg1, arg2);
    }

    public entry fun disable_equipment_orderbook<T0: copy + drop>(arg0: &0x2::package::Publisher, arg1: &mut 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::Orderbook<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog_equipment::Equipment<T0>, 0x2::sui::SUI>) {
        disable_orderbook<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog_equipment::Equipment<T0>>(arg0, arg1);
    }

    public entry fun disable_orderbook<T0: store + key>(arg0: &0x2::package::Publisher, arg1: &mut 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::Orderbook<T0, 0x2::sui::SUI>) {
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::set_protection<T0, 0x2::sui::SUI>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_publisher<T0>(arg0), arg1, 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::custom_protection(true, true, true));
    }

    public entry fun disable_part_orderbook<T0: copy + drop>(arg0: &0x2::package::Publisher, arg1: &mut 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::Orderbook<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Part<T0>, 0x2::sui::SUI>) {
        disable_orderbook<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Part<T0>>(arg0, arg1);
    }

    public entry fun enable_equipment_orderbook<T0: copy + drop>(arg0: &0x2::package::Publisher, arg1: &mut 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::Orderbook<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog_equipment::Equipment<T0>, 0x2::sui::SUI>) {
        enable_orderbook<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzerdog_equipment::Equipment<T0>>(arg0, arg1);
    }

    public entry fun enable_orderbook<T0: store + key>(arg0: &0x2::package::Publisher, arg1: &mut 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::Orderbook<T0, 0x2::sui::SUI>) {
        0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::set_protection<T0, 0x2::sui::SUI>(0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::from_publisher<T0>(arg0), arg1, 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::custom_protection(false, false, false));
    }

    public entry fun enable_part_orderbook<T0: copy + drop>(arg0: &0x2::package::Publisher, arg1: &mut 0x4e0629fa51a62b0c1d7c7b9fc89237ec5b6f630d7798ad3f06d820afb93a995a::orderbook::Orderbook<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Part<T0>, 0x2::sui::SUI>) {
        enable_orderbook<0x41c06da395bc3f0ee621a66082f8f30f376da41a2db7bcce7c087444de200e41::panzertanks_parts::Part<T0>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

