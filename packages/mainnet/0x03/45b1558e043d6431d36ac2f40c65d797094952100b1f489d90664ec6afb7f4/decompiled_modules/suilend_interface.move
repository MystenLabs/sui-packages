module 0x345b1558e043d6431d36ac2f40c65d797094952100b1f489d90664ec6afb7f4::suilend_interface {
    struct LendingMarket<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    struct Reserve<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    struct CToken<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
    }

    public fun deposit_liquidity<T0, T1>(arg0: &mut LendingMarket<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        arg3
    }

    public fun get_reserve_apy<T0>(arg0: &LendingMarket<T0>, arg1: u64) : u64 {
        500
    }

    public fun get_yield_index<T0>(arg0: &LendingMarket<T0>, arg1: u64) : u128 {
        1000000000
    }

    public fun withdraw_liquidity<T0, T1>(arg0: &mut LendingMarket<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        arg3
    }

    // decompiled from Move bytecode v6
}

