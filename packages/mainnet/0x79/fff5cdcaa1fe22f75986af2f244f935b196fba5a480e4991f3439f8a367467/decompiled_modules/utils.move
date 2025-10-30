module 0x79fff5cdcaa1fe22f75986af2f244f935b196fba5a480e4991f3439f8a367467::utils {
    public fun split_balance_by_pips<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(arg0, 0x79fff5cdcaa1fe22f75986af2f244f935b196fba5a480e4991f3439f8a367467::safe_math::mul_div_u64(0x2::balance::value<T0>(arg0), arg1, 0x79fff5cdcaa1fe22f75986af2f244f935b196fba5a480e4991f3439f8a367467::constants::scaling_pips()))
    }

    public fun split_coin_by_pips<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::split<T0>(arg0, 0x79fff5cdcaa1fe22f75986af2f244f935b196fba5a480e4991f3439f8a367467::safe_math::mul_div_u64(0x2::coin::value<T0>(arg0), arg1, 0x79fff5cdcaa1fe22f75986af2f244f935b196fba5a480e4991f3439f8a367467::constants::scaling_pips()), arg2)
    }

    public fun transfer_or_destroy<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        };
    }

    // decompiled from Move bytecode v6
}

