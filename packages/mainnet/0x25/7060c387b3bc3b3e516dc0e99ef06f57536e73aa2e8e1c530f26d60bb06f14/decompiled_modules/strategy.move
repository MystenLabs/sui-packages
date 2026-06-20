module 0x257060c387b3bc3b3e516dc0e99ef06f57536e73aa2e8e1c530f26d60bb06f14::strategy {
    struct StrategyCreatedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        strategy_config_id: 0x2::object::ID,
    }

    struct StrategyUpdatedEvent has copy, drop {
        vault_id: 0x2::object::ID,
        max_position_bps: u64,
        stop_loss_bps: u64,
        min_trade_interval_sec: u64,
        max_open_positions: u64,
    }

    struct StrategyConfig has key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        creator: address,
        allowed_pools: vector<address>,
        max_position_bps: u64,
        stop_loss_bps: u64,
        min_trade_interval_sec: u64,
        max_open_positions: u64,
        active: bool,
    }

    public fun add_allowed_pool(arg0: &mut StrategyConfig, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 200);
        0x1::vector::push_back<address>(&mut arg0.allowed_pools, arg1);
    }

    public fun allowed_pools(arg0: &StrategyConfig) : &vector<address> {
        &arg0.allowed_pools
    }

    public fun create_strategy(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 <= 10000, 201);
        assert!(arg2 <= 10000, 201);
        let v0 = StrategyConfig{
            id                     : 0x2::object::new(arg5),
            vault_id               : arg0,
            creator                : 0x2::tx_context::sender(arg5),
            allowed_pools          : vector[],
            max_position_bps       : arg1,
            stop_loss_bps          : arg2,
            min_trade_interval_sec : arg3,
            max_open_positions     : arg4,
            active                 : true,
        };
        let v1 = StrategyCreatedEvent{
            vault_id           : arg0,
            strategy_config_id : 0x2::object::id<StrategyConfig>(&v0),
        };
        0x2::event::emit<StrategyCreatedEvent>(v1);
        0x2::transfer::share_object<StrategyConfig>(v0);
    }

    public fun is_active(arg0: &StrategyConfig) : bool {
        arg0.active
    }

    public fun is_pool_allowed(arg0: &StrategyConfig, arg1: address) : bool {
        let v0 = &arg0.allowed_pools;
        if (0x1::vector::length<address>(v0) == 0) {
            return true
        };
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(v0)) {
            if (*0x1::vector::borrow<address>(v0, v1) == arg1) {
                return true
            };
            v1 = v1 + 1;
        };
        false
    }

    public fun max_open_positions(arg0: &StrategyConfig) : u64 {
        arg0.max_open_positions
    }

    public fun max_position_bps(arg0: &StrategyConfig) : u64 {
        arg0.max_position_bps
    }

    public fun min_trade_interval_sec(arg0: &StrategyConfig) : u64 {
        arg0.min_trade_interval_sec
    }

    public fun set_active(arg0: &mut StrategyConfig, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 200);
        arg0.active = arg1;
    }

    public fun stop_loss_bps(arg0: &StrategyConfig) : u64 {
        arg0.stop_loss_bps
    }

    public fun update_params(arg0: &mut StrategyConfig, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.creator, 200);
        assert!(arg1 <= 10000, 201);
        assert!(arg2 <= 10000, 201);
        arg0.max_position_bps = arg1;
        arg0.stop_loss_bps = arg2;
        arg0.min_trade_interval_sec = arg3;
        arg0.max_open_positions = arg4;
        let v0 = StrategyUpdatedEvent{
            vault_id               : arg0.vault_id,
            max_position_bps       : arg1,
            stop_loss_bps          : arg2,
            min_trade_interval_sec : arg3,
            max_open_positions     : arg4,
        };
        0x2::event::emit<StrategyUpdatedEvent>(v0);
    }

    public fun vault_id(arg0: &StrategyConfig) : 0x2::object::ID {
        arg0.vault_id
    }

    // decompiled from Move bytecode v6
}

