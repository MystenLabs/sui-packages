module 0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::trader {
    entry fun trade_borrow_x<T0, T1>(arg0: address, arg1: &0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::TraderList, arg2: u64, arg3: &mut 0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::TradingPair<T0, T1>, arg4: u64, arg5: u64, arg6: u64, arg7: 0x2::coin::Coin<T1>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::trader_borrow<T0, T1>(arg1, arg2, arg3, true, arg6, arg9);
        0x1::option::destroy_none<0x2::coin::Coin<T1>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x1::option::destroy_some<0x2::coin::Coin<T0>>(v0), arg0);
        0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::trader_swap_and_repay<T0, T1>(arg3, arg4, arg5, v2, 0x1::option::none<0x2::coin::Coin<T0>>(), 0x1::option::some<0x2::coin::Coin<T1>>(arg7), arg8);
    }

    entry fun trade_borrow_y<T0, T1>(arg0: address, arg1: &0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::TraderList, arg2: u64, arg3: &mut 0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::TradingPair<T0, T1>, arg4: u64, arg5: u64, arg6: u64, arg7: 0x2::coin::Coin<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::trader_borrow<T0, T1>(arg1, arg2, arg3, false, arg6, arg9);
        0x1::option::destroy_none<0x2::coin::Coin<T0>>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x1::option::destroy_some<0x2::coin::Coin<T1>>(v1), arg0);
        0xb84e63d22ea4822a0a333c250e790f69bf5c2ef0c63f4e120e05a6415991368f::v2::trader_swap_and_repay<T0, T1>(arg3, arg4, arg5, v2, 0x1::option::some<0x2::coin::Coin<T0>>(arg7), 0x1::option::none<0x2::coin::Coin<T1>>(), arg8);
    }

    // decompiled from Move bytecode v6
}

