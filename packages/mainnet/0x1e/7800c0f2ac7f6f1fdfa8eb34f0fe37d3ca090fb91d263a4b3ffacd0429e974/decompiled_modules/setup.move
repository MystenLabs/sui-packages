module 0x1e7800c0f2ac7f6f1fdfa8eb34f0fe37d3ca090fb91d263a4b3ffacd0429e974::setup {
    public fun setup<T0: drop>(arg0: T0, arg1: u8, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: bool, arg7: bool, arg8: bool, arg9: address, arg10: u64, arg11: u16, arg12: u16, arg13: u64, arg14: u16, arg15: u16, arg16: &mut 0x2::tx_context::TxContext) {
        assert!(@0xc0ebe2d09024f5bc3ec087739fae39ae7b7141d572b92fb2d9b20803c375241e == 0x2::tx_context::sender(arg16), 0);
        let (v0, v1, v2) = new_treasury<T0>(arg0, arg1, arg2, arg3, arg4, to_url(arg5), true, arg16);
        let v3 = 0x1e7800c0f2ac7f6f1fdfa8eb34f0fe37d3ca090fb91d263a4b3ffacd0429e974::auth::new_auth<T0>(arg16);
        0x1e7800c0f2ac7f6f1fdfa8eb34f0fe37d3ca090fb91d263a4b3ffacd0429e974::manager::new_manager<T0>(arg16);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v0);
        0x1e7800c0f2ac7f6f1fdfa8eb34f0fe37d3ca090fb91d263a4b3ffacd0429e974::boring_vault::share<T0>(0x1e7800c0f2ac7f6f1fdfa8eb34f0fe37d3ca090fb91d263a4b3ffacd0429e974::boring_vault::new_vault<T0>(&mut v3, v1, v2, arg6, arg7, arg8, arg16));
        0x2::transfer::public_share_object<0x1e7800c0f2ac7f6f1fdfa8eb34f0fe37d3ca090fb91d263a4b3ffacd0429e974::auth::Auth<T0>>(v3);
        0x2::transfer::public_share_object<0x1e7800c0f2ac7f6f1fdfa8eb34f0fe37d3ca090fb91d263a4b3ffacd0429e974::accountant::Accountant<T0>>(0x1e7800c0f2ac7f6f1fdfa8eb34f0fe37d3ca090fb91d263a4b3ffacd0429e974::accountant::new_accountant<T0>(arg9, arg10, arg11, arg12, arg13, arg14, arg15, 0x1::u64::pow(10, arg1), arg16));
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

