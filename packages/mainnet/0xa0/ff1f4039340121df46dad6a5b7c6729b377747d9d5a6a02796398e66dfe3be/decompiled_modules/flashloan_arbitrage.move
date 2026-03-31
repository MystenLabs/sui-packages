module 0xa0ff1f4039340121df46dad6a5b7c6729b377747d9d5a6a02796398e66dfe3be::flashloan_arbitrage {
    struct ArbitrageBot has key {
        id: 0x2::object::UID,
        owner: address,
        min_profit_threshold: u64,
        total_executed: u64,
        total_profit: u64,
    }

    struct FlashloanReceipt<phantom T0> {
        amount: u64,
        fee: u64,
    }

    struct ArbitrageExecuted has copy, drop {
        bot_id: address,
        token_in: address,
        token_out: address,
        amount_in: u64,
        amount_out: u64,
        profit: u64,
        buy_dex: u8,
        sell_dex: u8,
    }

    public fun create_bot(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ArbitrageBot{
            id                   : 0x2::object::new(arg1),
            owner                : 0x2::tx_context::sender(arg1),
            min_profit_threshold : arg0,
            total_executed       : 0,
            total_profit         : 0,
        };
        0x2::transfer::share_object<ArbitrageBot>(v0);
    }

    public fun execute_arbitrage<T0, T1>(arg0: &mut ArbitrageBot, arg1: u64, arg2: u8, arg3: u8, arg4: address, arg5: address, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        0x2::tx_context::sender(arg7);
        let (v0, v1) = flashloan_borrow<T0>(arg1, arg7);
        let v2 = if (arg2 == 1) {
            swap_cetus<T0, T1>(v0, arg4, arg7)
        } else if (arg2 == 2) {
            swap_turbos<T0, T1>(v0, arg5, arg7)
        } else {
            swap_deepbook<T0, T1>(v0, arg6, arg7)
        };
        let v3 = if (arg3 == 1) {
            swap_cetus<T1, T0>(v2, arg4, arg7)
        } else if (arg3 == 2) {
            swap_turbos<T1, T0>(v2, arg5, arg7)
        } else {
            swap_deepbook<T1, T0>(v2, arg6, arg7)
        };
        let v4 = 0x2::coin::value<T0>(&v3);
        let v5 = arg1 + arg1 / 10000;
        assert!(v4 > v5, 1);
        flashloan_repay<T0>(v1, 0x2::coin::split<T0>(&mut v3, v5, arg7));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, arg0.owner);
        arg0.total_executed = arg0.total_executed + 1;
        arg0.total_profit = arg0.total_profit + v4 - v5;
    }

    public fun flashloan_borrow<T0>(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, FlashloanReceipt<T0>) {
        let v0 = FlashloanReceipt<T0>{
            amount : arg0,
            fee    : arg0 / 10000,
        };
        (0x2::coin::zero<T0>(arg1), v0)
    }

    public fun flashloan_repay<T0>(arg0: FlashloanReceipt<T0>, arg1: 0x2::coin::Coin<T0>) {
        let FlashloanReceipt {
            amount : v0,
            fee    : v1,
        } = arg0;
        assert!(0x2::coin::value<T0>(&arg1) >= v0 + v1, 1);
        0x2::coin::destroy_zero<T0>(arg1);
    }

    public fun get_stats(arg0: &ArbitrageBot) : (u64, u64, u64) {
        (arg0.total_executed, arg0.total_profit, arg0.min_profit_threshold)
    }

    public entry fun run_arbitrage<T0, T1>(arg0: &mut ArbitrageBot, arg1: u64, arg2: u8, arg3: u8, arg4: address, arg5: address, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        execute_arbitrage<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    fun swap_cetus<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2::coin::destroy_zero<T0>(arg0);
        0x2::coin::zero<T1>(arg2)
    }

    fun swap_deepbook<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2::coin::destroy_zero<T0>(arg0);
        0x2::coin::zero<T1>(arg2)
    }

    fun swap_turbos<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2::coin::destroy_zero<T0>(arg0);
        0x2::coin::zero<T1>(arg2)
    }

    public fun update_threshold(arg0: &mut ArbitrageBot, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        arg0.min_profit_threshold = arg1;
    }

    // decompiled from Move bytecode v6
}

