module 0xb9d5f25fb3c442eaa61742cda8b4786f23fb57c367b383ff6c3c74447cfda5dc::execution {
    public fun maybe_mint<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: &mut 0x80ca577876dec91ae6d22090e56c39bc60dce9086ab0729930c6900bc4162b4c::s_coin_converter::SCoinTreasury<T0, 0x2::sui::SUI>, arg3: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T0>> {
        if (0x1::option::is_none<0x2::coin::Coin<0x2::sui::SUI>>(&arg3)) {
            0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(arg3);
            return 0x1::option::none<0x2::coin::Coin<T0>>()
        };
        0x1::option::some<0x2::coin::Coin<T0>>(0x80ca577876dec91ae6d22090e56c39bc60dce9086ab0729930c6900bc4162b4c::s_coin_converter::mint_s_coin<T0, 0x2::sui::SUI>(arg2, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<0x2::sui::SUI>(arg0, arg1, 0x1::option::destroy_some<0x2::coin::Coin<0x2::sui::SUI>>(arg3), arg4, arg5), arg5))
    }

    public fun maybe_redeem<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: &mut 0x80ca577876dec91ae6d22090e56c39bc60dce9086ab0729930c6900bc4162b4c::s_coin_converter::SCoinTreasury<T0, 0x2::sui::SUI>, arg3: 0x1::option::Option<0x2::coin::Coin<T0>>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>> {
        if (0x1::option::is_none<0x2::coin::Coin<T0>>(&arg3)) {
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg3);
            return 0x1::option::none<0x2::coin::Coin<0x2::sui::SUI>>()
        };
        0x1::option::some<0x2::coin::Coin<0x2::sui::SUI>>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<0x2::sui::SUI>(arg0, arg1, 0x80ca577876dec91ae6d22090e56c39bc60dce9086ab0729930c6900bc4162b4c::s_coin_converter::burn_s_coin<T0, 0x2::sui::SUI>(arg2, 0x1::option::destroy_some<0x2::coin::Coin<T0>>(arg3), arg5), arg4, arg5))
    }

    // decompiled from Move bytecode v7
}

