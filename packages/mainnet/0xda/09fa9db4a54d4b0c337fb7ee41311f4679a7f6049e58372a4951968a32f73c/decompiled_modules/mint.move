module 0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::mint {
    public fun mint<T0>(arg0: &0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::class::ItemCap<T0>, arg1: &mut 0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::class::Class<T0>, arg2: u64, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: &mut 0x2::tx_context::TxContext) : 0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::item::Item<T0> {
        0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::class::assert_cap<T0>(arg1, arg0);
        0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::class::assert_live<T0>(arg1);
        let v0 = make<T0>(arg1, arg2, arg3, arg4, arg5);
        0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::events::item_minted(0x2::object::id<0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::item::Item<T0>>(&v0), 0x2::object::id<0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::class::Class<T0>>(arg1), arg2, 0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::item::serial<T0>(&v0), 0, 0x1::option::none<address>(), 0x1::option::none<0x2::object::ID>(), 0x1::option::none<u64>(), arg3, arg4);
        v0
    }

    public fun burn<T0>(arg0: &mut 0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::class::Class<T0>, arg1: 0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::item::Item<T0>, arg2: &0x2::tx_context::TxContext) {
        assert!(0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::item::class<T0>(&arg1) == 0x2::object::id<0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::class::Class<T0>>(arg0), 303);
        assert!(!0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::class::lock<T0>(arg0), 302);
        let (v0, v1, v2, v3) = 0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::item::destroy<T0>(arg1);
        0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::class::record_burn<T0>(arg0, v2);
        0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::events::item_burned(v0, v1, v2, v3, 0x2::tx_context::sender(arg2));
    }

    public fun claim<T0>(arg0: &mut 0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::class::Class<T0>, arg1: &0x2::transfer_policy::TransferPolicy<0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::item::Item<T0>>, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: u64, arg5: vector<0x1::string::String>, arg6: vector<0x1::string::String>, arg7: u64, arg8: u64, arg9: vector<u8>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0x2::kiosk::has_access(arg2, arg3), 301);
        claim_into<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11)
    }

    public fun claim_fresh<T0>(arg0: &mut 0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::class::Class<T0>, arg1: &0x2::transfer_policy::TransferPolicy<0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::item::Item<T0>>, arg2: u64, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: u64, arg6: u64, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let (v0, v1) = 0x2::kiosk::new(arg9);
        let v2 = v1;
        let v3 = v0;
        let v4 = &mut v3;
        let v5 = claim_into<T0>(arg0, arg1, v4, &v2, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v2, 0x2::tx_context::sender(arg9));
        v5
    }

    fun claim_into<T0>(arg0: &mut 0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::class::Class<T0>, arg1: &0x2::transfer_policy::TransferPolicy<0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::item::Item<T0>>, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: u64, arg5: vector<0x1::string::String>, arg6: vector<0x1::string::String>, arg7: u64, arg8: u64, arg9: vector<u8>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::class::assert_live<T0>(arg0);
        0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::class::assert_policy<T0>(arg0, arg1);
        let v0 = 0x2::tx_context::sender(arg11);
        let v1 = 0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::voucher::claim_message(0x2::object::id<0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::class::Class<T0>>(arg0), v0, arg4, arg5, arg6, arg7, arg8);
        0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::voucher::verify(0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::class::issuer_ref<T0>(arg0), &v1, &arg9, arg8, arg10);
        0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::class::use_nonce<T0>(arg0, v0, arg7);
        let v2 = make<T0>(arg0, arg4, arg5, arg6, arg11);
        let v3 = 0x2::object::id<0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::item::Item<T0>>(&v2);
        0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::events::item_minted(v3, 0x2::object::id<0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::class::Class<T0>>(arg0), arg4, 0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::item::serial<T0>(&v2), 1, 0x1::option::some<address>(v0), 0x1::option::some<0x2::object::ID>(0x2::object::id<0x2::kiosk::Kiosk>(arg2)), 0x1::option::some<u64>(arg7), arg5, arg6);
        if (0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::class::lock<T0>(arg0)) {
            0x2::kiosk::lock<0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::item::Item<T0>>(arg2, arg3, arg1, v2);
        } else {
            0x2::kiosk::place<0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::item::Item<T0>>(arg2, arg3, v2);
        };
        v3
    }

    fun make<T0>(arg0: &mut 0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::class::Class<T0>, arg1: u64, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: &mut 0x2::tx_context::TxContext) : 0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::item::Item<T0> {
        let (v0, v1) = 0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::class::take_serial<T0>(arg0, arg1);
        let v2 = v1;
        0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::item::new<T0>(0x2::object::id<0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::class::Class<T0>>(arg0), arg1, v0, 0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::class::kind_name(&v2), 0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::class::kind_description(&v2), 0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::class::kind_image_url(&v2), arg2, arg3, arg4)
    }

    public fun source_claim() : u8 {
        1
    }

    public fun source_mint() : u8 {
        0
    }

    // decompiled from Move bytecode v7
}

