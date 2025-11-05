module 0x4e734666d09127a4004133257711c55dea1c1e6e264a8b6da570480080483d0c::para {
    struct Output has copy, drop {
        amount: u64,
    }

    struct SwapReceipt<phantom T0, phantom T1, T2> {
        flash_loan_receipt: T2,
        balance_a: 0x2::balance::Balance<T0>,
        balance_b: 0x2::balance::Balance<T1>,
        repay_amount: u64,
        a2b: bool,
    }

    public fun get_sqrt_price_limit(arg0: u128, arg1: bool) : u128 {
        if (arg1) {
            return arg0 * 3 / 5
        };
        arg0 * 5 / 3
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun me<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg1) > 0) {
            0x2::coin::join<T0>(arg0, 0x2::coin::from_balance<T0>(arg1, arg2));
        } else {
            0x2::balance::destroy_zero<T0>(arg1);
        };
    }

    public fun show_balance<T0>(arg0: 0x2::balance::Balance<T0>) : 0x2::balance::Balance<T0> {
        let v0 = Output{amount: 0x2::balance::value<T0>(&arg0)};
        0x2::event::emit<Output>(v0);
        arg0
    }

    public fun tr<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    public fun transfer_or_destroy_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    public fun transfer_or_destroy_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    // decompiled from Move bytecode v6
}

