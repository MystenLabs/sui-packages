module 0x3a56f433ac9a0d9a1d0d41f8695aa40fcc8a9c4160dbe8fe480d17a5b10402b3::executor {
    struct ArbReceipt {
        initiator: address,
        initial_amount: u64,
        min_profit: u64,
    }

    struct ArbExecuted has copy, drop {
        initiator: address,
        initial_amount: u64,
        final_amount: u64,
        profit: u64,
    }

    fun assert_profit(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg1 <= 18446744073709551615 - arg0, 2);
        assert!(arg2 >= arg0 + arg1, 1);
        arg2 - arg0
    }

    public fun begin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, ArbReceipt) {
        let v0 = ArbReceipt{
            initiator      : 0x2::tx_context::sender(arg2),
            initial_amount : 0x2::coin::value<T0>(&arg0),
            min_profit     : arg1,
        };
        (arg0, v0)
    }

    public fun initial_amount(arg0: &ArbReceipt) : u64 {
        arg0.initial_amount
    }

    public fun initiator(arg0: &ArbReceipt) : address {
        arg0.initiator
    }

    public fun min_profit(arg0: &ArbReceipt) : u64 {
        arg0.min_profit
    }

    public fun settle<T0>(arg0: ArbReceipt, arg1: 0x2::coin::Coin<T0>) {
        let ArbReceipt {
            initiator      : v0,
            initial_amount : v1,
            min_profit     : v2,
        } = arg0;
        let v3 = 0x2::coin::value<T0>(&arg1);
        let v4 = ArbExecuted{
            initiator      : v0,
            initial_amount : v1,
            final_amount   : v3,
            profit         : assert_profit(v1, v2, v3),
        };
        0x2::event::emit<ArbExecuted>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
    }

    public fun settle_and_return<T0>(arg0: ArbReceipt, arg1: 0x2::coin::Coin<T0>) : 0x2::coin::Coin<T0> {
        let ArbReceipt {
            initiator      : v0,
            initial_amount : v1,
            min_profit     : v2,
        } = arg0;
        let v3 = 0x2::coin::value<T0>(&arg1);
        let v4 = ArbExecuted{
            initiator      : v0,
            initial_amount : v1,
            final_amount   : v3,
            profit         : assert_profit(v1, v2, v3),
        };
        0x2::event::emit<ArbExecuted>(v4);
        arg1
    }

    // decompiled from Move bytecode v7
}

