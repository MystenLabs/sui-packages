module 0x7c884688fbe4e9d67579a50361f09ebcf59a55c3f589b20f207cfa555c0ba019::executor {
    public entry fun create_token_and_pool<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: u64, arg3: u8, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: 0x1::ascii::String, arg8: vector<u8>, arg9: 0x2::coin::Coin<T0>, arg10: vector<u8>, arg11: u8, arg12: u32, arg13: u64, arg14: u128, arg15: 0x2::coin::Coin<0x2::sui::SUI>, arg16: u64, arg17: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x7c884688fbe4e9d67579a50361f09ebcf59a55c3f589b20f207cfa555c0ba019::token_factory::create_token_internal(arg2, arg3, arg4, arg5, arg6, arg7, arg17);
        let (_, v4, _, _, v7, v8) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::create_pool_with_liquidity<0x7c884688fbe4e9d67579a50361f09ebcf59a55c3f589b20f207cfa555c0ba019::token_factory::MANAGED_TOKEN, T0, 0x2::sui::SUI>(arg0, arg1, arg5, arg8, arg4, arg3, 0x1::ascii::into_bytes(arg7), arg10, arg11, 0x1::vector::empty<u8>(), arg12, arg13, arg14, 0x2::coin::into_balance<0x2::sui::SUI>(arg15), 2146983648, 2147983648, 0x2::coin::into_balance<0x7c884688fbe4e9d67579a50361f09ebcf59a55c3f589b20f207cfa555c0ba019::token_factory::MANAGED_TOKEN>(v2), 0x2::coin::into_balance<T0>(arg9), arg16, true, arg17);
        let v9 = 0x2::tx_context::sender(arg17);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<0x7c884688fbe4e9d67579a50361f09ebcf59a55c3f589b20f207cfa555c0ba019::token_factory::MANAGED_TOKEN>>(v0, v9);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<0x7c884688fbe4e9d67579a50361f09ebcf59a55c3f589b20f207cfa555c0ba019::token_factory::MANAGED_TOKEN>>(v1, v9);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x7c884688fbe4e9d67579a50361f09ebcf59a55c3f589b20f207cfa555c0ba019::token_factory::MANAGED_TOKEN>>(0x2::coin::from_balance<0x7c884688fbe4e9d67579a50361f09ebcf59a55c3f589b20f207cfa555c0ba019::token_factory::MANAGED_TOKEN>(v7, arg17), v9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v8, arg17), v9);
        0x2::transfer::public_transfer<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v4, v9);
    }

    // decompiled from Move bytecode v6
}

