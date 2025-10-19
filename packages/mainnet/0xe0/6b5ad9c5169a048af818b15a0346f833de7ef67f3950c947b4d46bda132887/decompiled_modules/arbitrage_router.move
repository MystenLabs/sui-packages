module 0xe06b5ad9c5169a048af818b15a0346f833de7ef67f3950c947b4d46bda132887::arbitrage_router {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ArbitrageConfig has key {
        id: 0x2::object::UID,
        owner: address,
        min_profit_bps: u64,
        max_slippage_bps: u64,
        enabled: bool,
    }

    struct SwapContext has drop, store {
        initial_amount: u64,
        current_amount: u64,
        min_output_amount: u64,
        swap_count: u8,
    }

    struct ArbitrageExecuted has copy, drop {
        sender: address,
        amount_in: u64,
        amount_out: u64,
        profit: u64,
        swap_count: u8,
        timestamp: u64,
    }

    struct SwapExecuted has copy, drop {
        step: u8,
        amount_in: u64,
        amount_out: u64,
    }

    public fun finalize_arbitrage(arg0: &ArbitrageConfig, arg1: SwapContext, arg2: &0x2::tx_context::TxContext) : u64 {
        assert!(arg0.enabled, 3);
        let SwapContext {
            initial_amount    : v0,
            current_amount    : v1,
            min_output_amount : v2,
            swap_count        : v3,
        } = arg1;
        assert!(v1 >= v2, 2);
        assert!(v1 > v0, 1);
        let v4 = v1 - v0;
        assert!(v4 * 10000 / v0 >= arg0.min_profit_bps, 1);
        let v5 = ArbitrageExecuted{
            sender     : 0x2::tx_context::sender(arg2),
            amount_in  : v0,
            amount_out : v1,
            profit     : v4,
            swap_count : v3,
            timestamp  : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<ArbitrageExecuted>(v5);
        v1
    }

    public fun get_current_amount(arg0: &SwapContext) : u64 {
        arg0.current_amount
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = ArbitrageConfig{
            id               : 0x2::object::new(arg0),
            owner            : 0x2::tx_context::sender(arg0),
            min_profit_bps   : 10,
            max_slippage_bps : 50,
            enabled          : true,
        };
        0x2::transfer::share_object<ArbitrageConfig>(v1);
    }

    public fun is_enabled(arg0: &ArbitrageConfig) : bool {
        arg0.enabled
    }

    public fun new_swap_context(arg0: u64, arg1: u64) : SwapContext {
        SwapContext{
            initial_amount    : arg0,
            current_amount    : arg0,
            min_output_amount : arg1,
            swap_count        : 0,
        }
    }

    public fun set_enabled(arg0: &mut ArbitrageConfig, arg1: &AdminCap, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 3);
        arg0.enabled = arg2;
    }

    public fun update_context(arg0: &mut SwapContext, arg1: u64) {
        arg0.current_amount = arg1;
        arg0.swap_count = arg0.swap_count + 1;
        let v0 = SwapExecuted{
            step       : arg0.swap_count,
            amount_in  : arg0.current_amount,
            amount_out : arg1,
        };
        0x2::event::emit<SwapExecuted>(v0);
    }

    public fun update_min_profit(arg0: &mut ArbitrageConfig, arg1: &AdminCap, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 3);
        arg0.min_profit_bps = arg2;
    }

    // decompiled from Move bytecode v6
}

