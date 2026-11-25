module 0x74179250c06278a110deaf9b05fc2ef9e9212c629677c7a39eba648185d93c72::kiosk_market {
    struct KioskMarket has drop {
        dummy_field: bool,
    }

    public fun buy<T0: store + key>(arg0: &0x74179250c06278a110deaf9b05fc2ef9e9212c629677c7a39eba648185d93c72::platform::Platform, arg1: &mut 0x74179250c06278a110deaf9b05fc2ef9e9212c629677c7a39eba648185d93c72::pool::Pool<0x2::sui::SUI>, arg2: &mut 0x2::kiosk::Kiosk, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg7: 0x1::string::String, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule>(arg6)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<T0>(arg6, arg4)
        } else {
            0
        };
        let v1 = arg4 + v0;
        assert!(v1 + 0x74179250c06278a110deaf9b05fc2ef9e9212c629677c7a39eba648185d93c72::nft::purchase_fee(arg0, v1) <= arg5, 351);
        let v2 = 0x2::object::id<0x2::kiosk::Kiosk>(arg2);
        let v3 = KioskMarket{dummy_field: false};
        let (v4, v5, v6, v7) = 0x74179250c06278a110deaf9b05fc2ef9e9212c629677c7a39eba648185d93c72::nft::begin_purchase<0x2::sui::SUI, T0, KioskMarket>(v3, arg0, arg1, 0x2::object::id_to_address(&v2), arg3, v1, arg7, arg8, arg9);
        let v8 = v7;
        let v9 = v6;
        let v10 = v4;
        let (v11, v12) = 0x2::kiosk::purchase<T0>(arg2, arg3, 0x2::coin::split<0x2::sui::SUI>(&mut v10, arg4, arg9));
        let v13 = v12;
        let v14 = 0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::Rule>(arg6);
        if (v14) {
            0x2::kiosk::lock<T0>(&mut v9, &v8, arg6, v11);
        } else {
            0x2::kiosk::place<T0>(&mut v9, &v8, v11);
        };
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule>(arg6)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg6, &mut v13, 0x2::coin::split<0x2::sui::SUI>(&mut v10, v0, arg9));
        };
        if (v14) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v13, &v9);
        };
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::floor_price_rule::Rule>(arg6)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::floor_price_rule::prove<T0>(arg6, &mut v13);
        };
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg6, v13);
        0x74179250c06278a110deaf9b05fc2ef9e9212c629677c7a39eba648185d93c72::nft::finish_purchase<0x2::sui::SUI, T0>(v5, arg0, arg1, v9, v8, v10, arg9);
    }

    // decompiled from Move bytecode v7
}

