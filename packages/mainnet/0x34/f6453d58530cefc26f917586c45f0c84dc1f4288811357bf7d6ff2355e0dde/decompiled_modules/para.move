module 0x34f6453d58530cefc26f917586c45f0c84dc1f4288811357bf7d6ff2355e0dde::para {
    struct Output has copy, drop {
        amount: u64,
    }

    struct SwapReceipt<phantom T0, phantom T1, T2: store> {
        flash_loan_receipt: T2,
        balance_a: 0x2::balance::Balance<T0>,
        balance_b: 0x2::balance::Balance<T1>,
        repay_amount: u64,
        a2b: bool,
    }

    struct FlashLoanReceipt has store {
        amount: u64,
        fee: u64,
    }

    public fun create_flash_loan<T0>(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : SwapReceipt<T0, T0, FlashLoanReceipt> {
        let v0 = arg0 * arg1 / 10000;
        let v1 = FlashLoanReceipt{
            amount : arg0,
            fee    : v0,
        };
        SwapReceipt<T0, T0, FlashLoanReceipt>{
            flash_loan_receipt : v1,
            balance_a          : 0x2::balance::zero<T0>(),
            balance_b          : 0x2::balance::zero<T0>(),
            repay_amount       : arg0 + v0,
            a2b                : false,
        }
    }

    public fun get_sqrt_price_limit(arg0: u128, arg1: bool) : u128 {
        if (arg1) {
            arg0 * 3 / 5
        } else {
            arg0 * 5 / 3
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun merge_balance_to_coin<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg1) > 0) {
            0x2::coin::join<T0>(arg0, 0x2::coin::from_balance<T0>(arg1, arg2));
        } else {
            0x2::balance::destroy_zero<T0>(arg1);
        };
    }

    public fun move_balance_a_from_receipt<T0, T1, T2: store>(arg0: &mut SwapReceipt<T0, T1, T2>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x2::balance::withdraw_all<T0>(&mut arg0.balance_a)
    }

    public fun move_balance_b_from_receipt<T0, T1, T2: store>(arg0: &mut SwapReceipt<T0, T1, T2>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0x2::balance::withdraw_all<T1>(&mut arg0.balance_b)
    }

    public fun repay_flash_loan<T0>(arg0: 0x2::balance::Balance<T0>, arg1: SwapReceipt<T0, T0, FlashLoanReceipt>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let SwapReceipt {
            flash_loan_receipt : v0,
            balance_a          : v1,
            balance_b          : v2,
            repay_amount       : v3,
            a2b                : _,
        } = arg1;
        let FlashLoanReceipt {
            amount : _,
            fee    : _,
        } = v0;
        0x2::balance::destroy_zero<T0>(v1);
        0x2::balance::destroy_zero<T0>(v2);
        assert!(0x2::balance::value<T0>(&arg0) >= v3, 401);
        0x2::balance::destroy_zero<T0>(0x2::balance::split<T0>(&mut arg0, v3));
        arg0
    }

    public fun show_balance<T0>(arg0: 0x2::balance::Balance<T0>) : 0x2::balance::Balance<T0> {
        let v0 = Output{amount: 0x2::balance::value<T0>(&arg0)};
        0x2::event::emit<Output>(v0);
        arg0
    }

    public fun swap_template_a_to_b<T0, T1>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0x2::balance::destroy_zero<T0>(arg0);
        assert!(0x2::balance::value<T0>(&arg0) * 99 / 100 >= arg1, 100);
        0x2::balance::zero<T1>()
    }

    public fun take_balance_a_to_receipt<T0, T1, T2: store>(arg0: &mut SwapReceipt<T0, T1, T2>, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.balance_a, arg1);
    }

    public fun take_balance_b_to_receipt<T0, T1, T2: store>(arg0: &mut SwapReceipt<T0, T1, T2>, arg1: 0x2::balance::Balance<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T1>(&mut arg0.balance_b, arg1);
    }

    public fun transfer_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
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

    public fun validate_arbitrage(arg0: u64, arg1: u64, arg2: u64) {
        assert!(arg1 >= arg0 + arg0 * arg2 / 10000, 333);
    }

    // decompiled from Move bytecode v6
}

