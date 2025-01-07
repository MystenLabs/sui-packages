module 0x35d169010fabeea9271101904f03bc0b443f8747276646f6d5388132307f709f::state {
    struct State has store, key {
        id: 0x2::object::UID,
        started_at_sec: u64,
        ended_at_sec: u64,
        reward_per_sec: u64,
        total_alloc_point: u64,
        pool_registry: 0x35d169010fabeea9271101904f03bc0b443f8747276646f6d5388132307f709f::pool_registry::PoolRegistry,
        position_registry: 0x35d169010fabeea9271101904f03bc0b443f8747276646f6d5388132307f709f::position_registry::PositionRegistry,
        pdo_minter: 0xebad3c52b3bab9fd1a6c5e1d52449b7fffae0087f97361317d5e853a67127a65::access_control::Member<0x360ab891d029ab125284d73748bf4989e3989b3b02e67a4e02502881e1b42cd4::pdo_minter_role::PDO_MINTER_ROLE>,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext, arg1: u64, arg2: u64) : State {
        State{
            id                : 0x2::object::new(arg0),
            started_at_sec    : arg1,
            ended_at_sec      : arg2,
            reward_per_sec    : 0,
            total_alloc_point : 0,
            pool_registry     : 0x35d169010fabeea9271101904f03bc0b443f8747276646f6d5388132307f709f::pool_registry::new(arg0),
            position_registry : 0x35d169010fabeea9271101904f03bc0b443f8747276646f6d5388132307f709f::position_registry::new(arg0),
            pdo_minter        : 0xebad3c52b3bab9fd1a6c5e1d52449b7fffae0087f97361317d5e853a67127a65::access_control::create_member<0x360ab891d029ab125284d73748bf4989e3989b3b02e67a4e02502881e1b42cd4::pdo_minter_role::PDO_MINTER_ROLE>(arg0),
        }
    }

    public(friend) fun borrow_mut_pool_registry(arg0: &mut State) : &mut 0x35d169010fabeea9271101904f03bc0b443f8747276646f6d5388132307f709f::pool_registry::PoolRegistry {
        &mut arg0.pool_registry
    }

    public(friend) fun borrow_mut_pool_registry_and_position_registry_and_pdo_minter(arg0: &mut State) : (&mut 0x35d169010fabeea9271101904f03bc0b443f8747276646f6d5388132307f709f::pool_registry::PoolRegistry, &mut 0x35d169010fabeea9271101904f03bc0b443f8747276646f6d5388132307f709f::position_registry::PositionRegistry, &0xebad3c52b3bab9fd1a6c5e1d52449b7fffae0087f97361317d5e853a67127a65::access_control::Member<0x360ab891d029ab125284d73748bf4989e3989b3b02e67a4e02502881e1b42cd4::pdo_minter_role::PDO_MINTER_ROLE>) {
        (&mut arg0.pool_registry, &mut arg0.position_registry, &arg0.pdo_minter)
    }

    public(friend) fun borrow_mut_position_registry(arg0: &mut State) : &mut 0x35d169010fabeea9271101904f03bc0b443f8747276646f6d5388132307f709f::position_registry::PositionRegistry {
        &mut arg0.position_registry
    }

    public fun borrow_pool_registry(arg0: &State) : &0x35d169010fabeea9271101904f03bc0b443f8747276646f6d5388132307f709f::pool_registry::PoolRegistry {
        &arg0.pool_registry
    }

    public fun borrow_position_registry(arg0: &State) : &0x35d169010fabeea9271101904f03bc0b443f8747276646f6d5388132307f709f::position_registry::PositionRegistry {
        &arg0.position_registry
    }

    public(friend) fun decrease_alloc_point(arg0: &mut State, arg1: u64) {
        arg0.total_alloc_point = arg0.total_alloc_point - arg1;
    }

    public fun ended_at(arg0: &State) : u64 {
        arg0.ended_at_sec
    }

    public(friend) fun increase_alloc_point(arg0: &mut State, arg1: u64) {
        arg0.total_alloc_point = arg0.total_alloc_point + arg1;
    }

    public fun reward_per_sec(arg0: &State) : u64 {
        arg0.reward_per_sec
    }

    public(friend) fun set_reward_per_sec(arg0: &mut State, arg1: u64) {
        arg0.reward_per_sec = arg1;
    }

    public fun started_at(arg0: &State) : u64 {
        arg0.started_at_sec
    }

    public fun total_alloc_point(arg0: &State) : u64 {
        arg0.total_alloc_point
    }

    public(friend) fun uid_mut(arg0: &mut State) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    // decompiled from Move bytecode v6
}

