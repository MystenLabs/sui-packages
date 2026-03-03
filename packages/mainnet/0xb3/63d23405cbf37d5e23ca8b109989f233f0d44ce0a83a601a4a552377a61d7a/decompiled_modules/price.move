module 0xb363d23405cbf37d5e23ca8b109989f233f0d44ce0a83a601a4a552377a61d7a::price {
    struct PriceConfig has key {
        id: 0x2::object::UID,
        table: 0x2::table::Table<0x1::string::String, 0xb363d23405cbf37d5e23ca8b109989f233f0d44ce0a83a601a4a552377a61d7a::share::SharedObjectRef>,
    }

    public fun modify_price_config(arg0: &mut PriceConfig, arg1: &0xb363d23405cbf37d5e23ca8b109989f233f0d44ce0a83a601a4a552377a61d7a::admin::AdminCap, arg2: 0x1::string::String, arg3: 0xb363d23405cbf37d5e23ca8b109989f233f0d44ce0a83a601a4a552377a61d7a::share::SharedObjectRef) {
        if (0x2::table::contains<0x1::string::String, 0xb363d23405cbf37d5e23ca8b109989f233f0d44ce0a83a601a4a552377a61d7a::share::SharedObjectRef>(&arg0.table, arg2)) {
            0x2::table::remove<0x1::string::String, 0xb363d23405cbf37d5e23ca8b109989f233f0d44ce0a83a601a4a552377a61d7a::share::SharedObjectRef>(&mut arg0.table, arg2);
        };
        0x2::table::add<0x1::string::String, 0xb363d23405cbf37d5e23ca8b109989f233f0d44ce0a83a601a4a552377a61d7a::share::SharedObjectRef>(&mut arg0.table, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

