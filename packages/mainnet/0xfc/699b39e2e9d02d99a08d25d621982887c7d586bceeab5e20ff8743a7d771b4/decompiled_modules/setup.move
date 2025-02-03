module 0xfc699b39e2e9d02d99a08d25d621982887c7d586bceeab5e20ff8743a7d771b4::setup {
    public fun setup<T0: drop>(arg0: T0, arg1: u8, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: 0x1::option::Option<0x2::url::Url>, arg6: address, arg7: vector<vector<u8>>, arg8: vector<u8>, arg9: u16, arg10: address, arg11: vector<vector<u8>>, arg12: vector<u8>, arg13: u16, arg14: address, arg15: &mut 0x2::tx_context::TxContext) : 0x2::coin::CoinMetadata<T0> {
        let (v0, v1, v2) = 0xfc699b39e2e9d02d99a08d25d621982887c7d586bceeab5e20ff8743a7d771b4::controlled_treasury::new<T0, 0xfc699b39e2e9d02d99a08d25d621982887c7d586bceeab5e20ff8743a7d771b4::roles::Admin, 0xfc699b39e2e9d02d99a08d25d621982887c7d586bceeab5e20ff8743a7d771b4::roles::Manager, 0xfc699b39e2e9d02d99a08d25d621982887c7d586bceeab5e20ff8743a7d771b4::roles::ContractManager>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
        let v3 = v2;
        let v4 = v1;
        0xfc699b39e2e9d02d99a08d25d621982887c7d586bceeab5e20ff8743a7d771b4::roles::setup_roles<T0>(&mut v3, arg15);
        let v5 = 0xfc699b39e2e9d02d99a08d25d621982887c7d586bceeab5e20ff8743a7d771b4::controlled_treasury::borrow_caps<T0, 0xfc699b39e2e9d02d99a08d25d621982887c7d586bceeab5e20ff8743a7d771b4::roles::Admin>(&mut v3, arg15);
        0xfc699b39e2e9d02d99a08d25d621982887c7d586bceeab5e20ff8743a7d771b4::rules::add_default_rules<T0>(&v5, &mut v4, arg15);
        0xfc699b39e2e9d02d99a08d25d621982887c7d586bceeab5e20ff8743a7d771b4::controlled_treasury::return_caps<T0>(&mut v3, v5);
        0x2::token::share_policy<T0>(v4);
        0xfc699b39e2e9d02d99a08d25d621982887c7d586bceeab5e20ff8743a7d771b4::controlled_treasury::share<T0>(v3);
        v0
    }

    // decompiled from Move bytecode v6
}

