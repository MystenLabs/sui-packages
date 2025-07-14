module 0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::setup {
    public fun setup<T0: drop>(arg0: T0, arg1: u8, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: bool, arg7: bool, arg8: bool, arg9: u64, arg10: address, arg11: u64, arg12: u16, arg13: u16, arg14: u64, arg15: u16, arg16: u16, arg17: 0x1::type_name::TypeName, arg18: &mut 0x2::tx_context::TxContext) {
        assert!(@0xf38a463604d2db4582033a09db6f8d4b846b113b3cd0a7c4f0d4690b3fe6aa37 == 0x2::tx_context::sender(arg18), 0);
        let (v0, v1, v2) = new_treasury<T0>(arg0, arg1, arg2, arg3, arg4, to_url(arg5), true, arg18);
        let v3 = 0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::auth::new_auth<T0>(arg18);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v0);
        0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::boring_vault::share<T0>(0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::boring_vault::new_vault<T0>(&mut v3, v1, v2, arg6, arg7, arg8, arg9, arg18));
        0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::auth::share<T0>(v3);
        0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::accountant::share<T0>(0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::accountant::new_accountant<T0>(arg10, arg11, arg12, arg13, arg14, arg15, arg16, 0x1::u64::pow(10, arg1), arg1, arg17, 60, 100, arg18));
        0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::manager::share<T0>(0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::manager::new_manager<T0>(arg18));
        0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::oracle::share<T0>(0x8e217f39b8282d7fcb3a87b665ea06ce457cc01f89be834547bf90cf6ed0455d::oracle::new_empty_price_feed_map<T0>(arg18));
    }

    fun new_treasury<T0: drop>(arg0: T0, arg1: u8, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: 0x1::option::Option<0x2::url::Url>, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::CoinMetadata<T0>, 0x2::coin::TreasuryCap<T0>, 0x2::coin::DenyCapV2<T0>) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        (v2, v0, v1)
    }

    fun to_url(arg0: vector<u8>) : 0x1::option::Option<0x2::url::Url> {
        if (0x1::vector::is_empty<u8>(&arg0)) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(arg0))
        }
    }

    // decompiled from Move bytecode v6
}

