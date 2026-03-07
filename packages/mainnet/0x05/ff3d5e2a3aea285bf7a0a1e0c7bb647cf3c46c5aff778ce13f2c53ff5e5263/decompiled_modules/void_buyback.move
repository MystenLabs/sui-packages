module 0x5ff3d5e2a3aea285bf7a0a1e0c7bb647cf3c46c5aff778ce13f2c53ff5e5263::void_buyback {
    struct BuybackConfig has store, key {
        id: 0x2::object::UID,
        admin: address,
        pumpkin_treasury: address,
        total_pumpkin_bought: u64,
        total_void_fees_collected: u64,
        total_buybacks: u64,
        min_buyback_amount: u64,
        is_paused: bool,
    }

    struct BuybackEvent has copy, drop {
        amount_sol_in: u64,
        amount_pumpkin_out: u64,
        timestamp: u64,
        executor: address,
    }

    public fun admin(arg0: &BuybackConfig) : address {
        arg0.admin
    }

    public fun execute_buyback(arg0: &mut BuybackConfig, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 1);
        assert!(arg1 >= arg0.min_buyback_amount, 2);
        let v0 = 0;
        arg0.total_void_fees_collected = arg0.total_void_fees_collected + arg1;
        arg0.total_pumpkin_bought = arg0.total_pumpkin_bought + v0;
        arg0.total_buybacks = arg0.total_buybacks + 1;
        let v1 = BuybackEvent{
            amount_sol_in      : arg1,
            amount_pumpkin_out : v0,
            timestamp          : 0x2::clock::timestamp_ms(arg2),
            executor           : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<BuybackEvent>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BuybackConfig{
            id                        : 0x2::object::new(arg0),
            admin                     : 0x2::tx_context::sender(arg0),
            pumpkin_treasury          : 0x2::tx_context::sender(arg0),
            total_pumpkin_bought      : 0,
            total_void_fees_collected : 0,
            total_buybacks            : 0,
            min_buyback_amount        : 1000000,
            is_paused                 : false,
        };
        0x2::transfer::share_object<BuybackConfig>(v0);
    }

    public fun is_paused(arg0: &BuybackConfig) : bool {
        arg0.is_paused
    }

    public fun min_buyback_amount(arg0: &BuybackConfig) : u64 {
        arg0.min_buyback_amount
    }

    public fun total_buybacks(arg0: &BuybackConfig) : u64 {
        arg0.total_buybacks
    }

    public fun total_pumpkin_bought(arg0: &BuybackConfig) : u64 {
        arg0.total_pumpkin_bought
    }

    public fun total_void_fees_collected(arg0: &BuybackConfig) : u64 {
        arg0.total_void_fees_collected
    }

    public fun update_config(arg0: &mut BuybackConfig, arg1: u64, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0);
        arg0.min_buyback_amount = arg1;
        arg0.is_paused = arg2;
    }

    public fun update_treasury(arg0: &mut BuybackConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        arg0.pumpkin_treasury = arg1;
    }

    // decompiled from Move bytecode v6
}

