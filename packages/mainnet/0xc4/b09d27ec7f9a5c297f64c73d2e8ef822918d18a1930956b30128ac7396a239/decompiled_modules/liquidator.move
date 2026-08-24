module 0xc4b09d27ec7f9a5c297f64c73d2e8ef822918d18a1930956b30128ac7396a239::liquidator {
    fun keep<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        };
    }

    public fun keep_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        keep<T0>(0x2::coin::from_balance<T0>(arg0, arg1), arg1);
    }

    public fun settle_flash<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::from_balance<T0>(arg0, arg2);
        0xc4b09d27ec7f9a5c297f64c73d2e8ef822918d18a1930956b30128ac7396a239::guard::assert_coin_at_least<T0>(&v0, arg1);
        keep<T0>(v0, arg2);
    }

    public fun settle_navi<T0, T1>(arg0: 0x2::balance::Balance<T1>, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::from_balance<T1>(arg0, arg3);
        0xc4b09d27ec7f9a5c297f64c73d2e8ef822918d18a1930956b30128ac7396a239::guard::assert_coin_at_least<T1>(&v0, arg2);
        keep<T1>(v0, arg3);
        keep<T0>(0x2::coin::from_balance<T0>(arg1, arg3), arg3);
    }

    public fun settle_scallop<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xc4b09d27ec7f9a5c297f64c73d2e8ef822918d18a1930956b30128ac7396a239::guard::assert_coin_at_least<T1>(&arg1, arg2);
        keep<T1>(arg1, arg3);
        keep<T0>(arg0, arg3);
    }

    public fun settle_suilend<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0xc4b09d27ec7f9a5c297f64c73d2e8ef822918d18a1930956b30128ac7396a239::guard::assert_coin_at_least<T0>(&arg0, arg1);
        keep<T0>(arg0, arg2);
    }

    // decompiled from Move bytecode v7
}

