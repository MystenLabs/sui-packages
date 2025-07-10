module 0x9e7868b48674a4705afb6241f60dc63560ba529753b461c0a92dc7277a8ff804::owner_friendly_executor {
    struct Config has key {
        id: 0x2::object::UID,
        owner: address,
        fee_percentage: u64,
        total_fees_collected: u64,
        total_executions: u64,
        owner_executions: u64,
        is_enabled: bool,
    }

    struct ExecutionCompleted has copy, drop {
        executor: address,
        is_owner: bool,
        profit: u64,
        fee_paid: u64,
    }

    public entry fun example_backrun_with_fees(arg0: &mut Config, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
    }

    public fun execute_with_fee_check(arg0: &mut Config, arg1: address, arg2: u64) : u64 {
        assert!(arg0.is_enabled, 0);
        arg0.total_executions = arg0.total_executions + 1;
        let v0 = if (arg1 == arg0.owner) {
            arg0.owner_executions = arg0.owner_executions + 1;
            0
        } else {
            let v1 = arg2 * arg0.fee_percentage / 10000;
            arg0.total_fees_collected = arg0.total_fees_collected + v1;
            v1
        };
        let v2 = ExecutionCompleted{
            executor : arg1,
            is_owner : arg1 == arg0.owner,
            profit   : arg2,
            fee_paid : v0,
        };
        0x2::event::emit<ExecutionCompleted>(v2);
        v0
    }

    public fun get_stats(arg0: &Config) : (u64, u64, u64, u64) {
        (arg0.total_executions, arg0.owner_executions, arg0.total_executions - arg0.owner_executions, arg0.total_fees_collected)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id                   : 0x2::object::new(arg0),
            owner                : 0x2::tx_context::sender(arg0),
            fee_percentage       : 3000,
            total_fees_collected : 0,
            total_executions     : 0,
            owner_executions     : 0,
            is_enabled           : true,
        };
        0x2::transfer::share_object<Config>(v0);
    }

    public fun is_owner(arg0: &Config, arg1: address) : bool {
        arg1 == arg0.owner
    }

    public entry fun toggle_enabled(arg0: &mut Config, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 1);
        arg0.is_enabled = !arg0.is_enabled;
    }

    public entry fun transfer_ownership(arg0: &mut Config, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        arg0.owner = arg1;
    }

    public entry fun update_fee(arg0: &mut Config, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        assert!(arg1 <= 9000, 2);
        arg0.fee_percentage = arg1;
    }

    // decompiled from Move bytecode v6
}

