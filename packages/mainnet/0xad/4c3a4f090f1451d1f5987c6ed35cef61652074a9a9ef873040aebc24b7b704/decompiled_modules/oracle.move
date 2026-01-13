module 0xad4c3a4f090f1451d1f5987c6ed35cef61652074a9a9ef873040aebc24b7b704::oracle {
    struct Oracle has store, key {
        id: 0x2::object::UID,
        aui_price: u64,
        bui_price: u64,
        cui_price: u64,
        usdg_price: u64,
    }

    fun err_invalid_coin_type() {
        abort 0
    }

    public fun get_price<T0>(arg0: &Oracle) : u64 {
        if (0x1::type_name::with_defining_ids<T0>() == 0x1::type_name::with_defining_ids<0xad4c3a4f090f1451d1f5987c6ed35cef61652074a9a9ef873040aebc24b7b704::aui::AUI>()) {
            return arg0.aui_price
        };
        if (0x1::type_name::with_defining_ids<T0>() == 0x1::type_name::with_defining_ids<0xad4c3a4f090f1451d1f5987c6ed35cef61652074a9a9ef873040aebc24b7b704::bui::BUI>()) {
            return arg0.bui_price
        };
        if (0x1::type_name::with_defining_ids<T0>() == 0x1::type_name::with_defining_ids<0xad4c3a4f090f1451d1f5987c6ed35cef61652074a9a9ef873040aebc24b7b704::cui::CUI>()) {
            return arg0.cui_price
        };
        if (0x1::type_name::with_defining_ids<T0>() == 0x1::type_name::with_defining_ids<0xad4c3a4f090f1451d1f5987c6ed35cef61652074a9a9ef873040aebc24b7b704::usdg::USDG>()) {
            return arg0.usdg_price
        };
        err_invalid_coin_type();
        0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Oracle{
            id         : 0x2::object::new(arg0),
            aui_price  : 1000000000,
            bui_price  : 1000000000,
            cui_price  : 1000000000,
            usdg_price : 1000000000,
        };
        0x2::transfer::public_share_object<Oracle>(v0);
    }

    public fun price_decimal() : u8 {
        9
    }

    fun update_price(arg0: u64, arg1: u8) : u64 {
        arg0 * (arg1 as u64) / 100
    }

    public(friend) fun update_prices(arg0: &mut Oracle, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg1, arg2);
        arg0.aui_price = update_price(arg0.aui_price, 0x2::random::generate_u8_in_range(&mut v0, 20, 200));
        arg0.bui_price = update_price(arg0.bui_price, 0x2::random::generate_u8_in_range(&mut v0, 20, 200));
        arg0.cui_price = update_price(arg0.cui_price, 0x2::random::generate_u8_in_range(&mut v0, 20, 200));
    }

    // decompiled from Move bytecode v6
}

