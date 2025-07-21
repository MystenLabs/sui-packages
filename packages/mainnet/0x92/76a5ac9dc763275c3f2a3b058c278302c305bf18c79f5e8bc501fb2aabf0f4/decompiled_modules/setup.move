module 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::setup {
    public fun setup<T0: drop>(arg0: T0, arg1: u8, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: bool, arg7: bool, arg8: bool, arg9: u64, arg10: address, arg11: u64, arg12: u16, arg13: u16, arg14: u64, arg15: u16, arg16: u16, arg17: 0x1::type_name::TypeName, arg18: &mut 0x2::tx_context::TxContext) {
        assert!(@0xc0ebe2d09024f5bc3ec087739fae39ae7b7141d572b92fb2d9b20803c375241e == 0x2::tx_context::sender(arg18), 0);
        let (v0, v1, v2) = new_treasury<T0>(arg0, arg1, arg2, arg3, arg4, to_url(arg5), true, arg18);
        let v3 = 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::new_auth<T0>(arg18);
        let v4 = 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::boring_vault::new_vault<T0>(&mut v3, v1, v2, arg6, arg7, arg8, arg9, arg18);
        0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::boring_vault::set_withdraw_queue<T0, 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::withdraw_queue::WithdrawQueue<T0>>(&mut v4, 0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::withdraw_queue::new_withdraw_queue<T0>(arg18));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v0);
        0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::boring_vault::share<T0>(v4);
        0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::auth::share<T0>(v3);
        0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::accountant::share<T0>(0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::accountant::new_accountant<T0>(arg10, arg11, arg12, arg13, arg14, arg15, arg16, 0x1::u64::pow(10, arg1), arg1, arg17, 60, 100, arg18));
        0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::manager::share<T0>(0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::manager::new_manager<T0>(arg18));
        0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::oracle::share<T0>(0x9276a5ac9dc763275c3f2a3b058c278302c305bf18c79f5e8bc501fb2aabf0f4::oracle::new_empty_price_feed_map<T0>(arg18));
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

