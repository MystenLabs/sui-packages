module 0x6d03a3e2bc05b5789b0c0efbef44009c4644a7af4d74bcca59fcf7f7a25d8d1f::flash_loan_arbitrage {
    struct FlashLoanReceipt<phantom T0> {
        amount: u64,
        fee: u64,
    }

    struct ArbitrageConfig has store, key {
        id: 0x2::object::UID,
        min_amount: u64,
        max_amount: u64,
        fee_rate: u64,
        deepbook_pool: address,
        turbos_pool: address,
        is_active: bool,
    }

    struct ArbitrageExecuted has copy, drop {
        borrower: address,
        amount: u64,
        profit: u64,
        timestamp: u64,
    }

    public fun execute_deepbook_to_turbos<T0>(arg0: &ArbitrageConfig, arg1: 0x2::coin::Coin<T0>, arg2: FlashLoanReceipt<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = swap_on_deepbook<T0>(arg1, arg0.deepbook_pool, arg3);
        let v1 = swap_on_turbos<T0>(v0, arg0.turbos_pool, arg3);
        let v2 = repay_flash_loan<T0>(v1, arg2, arg3);
        let v3 = ArbitrageExecuted{
            borrower  : 0x2::tx_context::sender(arg3),
            amount    : arg2.amount,
            profit    : 0x2::coin::value<T0>(&v2),
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<ArbitrageExecuted>(v3);
        v2
    }

    public fun execute_turbos_to_deepbook<T0>(arg0: &ArbitrageConfig, arg1: 0x2::coin::Coin<T0>, arg2: FlashLoanReceipt<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = swap_on_turbos<T0>(arg1, arg0.turbos_pool, arg3);
        let v1 = swap_on_deepbook<T0>(v0, arg0.deepbook_pool, arg3);
        let v2 = repay_flash_loan<T0>(v1, arg2, arg3);
        let v3 = ArbitrageExecuted{
            borrower  : 0x2::tx_context::sender(arg3),
            amount    : arg2.amount,
            profit    : 0x2::coin::value<T0>(&v2),
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<ArbitrageExecuted>(v3);
        v2
    }

    public fun flash_loan<T0>(arg0: &ArbitrageConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, FlashLoanReceipt<T0>) {
        assert!(arg0.is_active, 1);
        assert!(arg1 >= arg0.min_amount && arg1 <= arg0.max_amount, 1);
        let v0 = FlashLoanReceipt<T0>{
            amount : arg1,
            fee    : arg1 * arg0.fee_rate / 10000,
        };
        (0x2::coin::zero<T0>(arg2), v0)
    }

    public fun initialize_config(arg0: u64, arg1: u64, arg2: u64, arg3: address, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = ArbitrageConfig{
            id            : 0x2::object::new(arg5),
            min_amount    : arg0,
            max_amount    : arg1,
            fee_rate      : arg2,
            deepbook_pool : arg3,
            turbos_pool   : arg4,
            is_active     : true,
        };
        0x2::transfer::share_object<ArbitrageConfig>(v0);
    }

    public fun pause_arbitrage(arg0: &mut ArbitrageConfig, arg1: &mut 0x2::tx_context::TxContext) {
        arg0.is_active = false;
    }

    fun repay_flash_loan<T0>(arg0: 0x2::coin::Coin<T0>, arg1: FlashLoanReceipt<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let FlashLoanReceipt {
            amount : v0,
            fee    : v1,
        } = arg1;
        let v2 = v0 + v1;
        assert!(0x2::coin::value<T0>(&arg0) >= v2, 2);
        0x2::coin::destroy_zero<T0>(0x2::coin::split<T0>(&mut arg0, v2, arg2));
        arg0
    }

    public fun resume_arbitrage(arg0: &mut ArbitrageConfig, arg1: &mut 0x2::tx_context::TxContext) {
        arg0.is_active = true;
    }

    fun swap_on_deepbook<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        arg0
    }

    fun swap_on_turbos<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        arg0
    }

    public fun update_config(arg0: &mut ArbitrageConfig, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        arg0.min_amount = arg1;
        arg0.max_amount = arg2;
        arg0.fee_rate = arg3;
    }

    // decompiled from Move bytecode v6
}

