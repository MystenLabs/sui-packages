module 0xa2b0cea68ded8ac9dd3321999c4bce21153181af7f3e3b47fd6789f23892f6cb::state {
    struct State has store, key {
        id: 0x2::object::UID,
        started_at_sec: u64,
        ended_at_sec: u64,
        reward_per_sec: u64,
        total_alloc_point: u64,
        pool_registry: 0xa2b0cea68ded8ac9dd3321999c4bce21153181af7f3e3b47fd6789f23892f6cb::pool_registry::PoolRegistry,
        position_registry: 0xa2b0cea68ded8ac9dd3321999c4bce21153181af7f3e3b47fd6789f23892f6cb::position_registry::PositionRegistry,
        pdo_minter: 0x163b0554f3a4574f4ff0910de5e8622ac12713cc73f2abadf0a7ebcdfea30284::access_control::Member<0x4fc3949a4a8fe3ad9c75cec9724ff2b2d8520506b6129c9d8f0fcc2a1e4a8880::pdo_minter_role::PDO_MINTER_ROLE>,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext, arg1: u64, arg2: u64) : State {
        State{
            id                : 0x2::object::new(arg0),
            started_at_sec    : arg1,
            ended_at_sec      : arg2,
            reward_per_sec    : 0,
            total_alloc_point : 0,
            pool_registry     : 0xa2b0cea68ded8ac9dd3321999c4bce21153181af7f3e3b47fd6789f23892f6cb::pool_registry::new(arg0),
            position_registry : 0xa2b0cea68ded8ac9dd3321999c4bce21153181af7f3e3b47fd6789f23892f6cb::position_registry::new(arg0),
            pdo_minter        : 0x163b0554f3a4574f4ff0910de5e8622ac12713cc73f2abadf0a7ebcdfea30284::access_control::create_member<0x4fc3949a4a8fe3ad9c75cec9724ff2b2d8520506b6129c9d8f0fcc2a1e4a8880::pdo_minter_role::PDO_MINTER_ROLE>(arg0),
        }
    }

    public(friend) fun borrow_mut_pool_registry(arg0: &mut State) : &mut 0xa2b0cea68ded8ac9dd3321999c4bce21153181af7f3e3b47fd6789f23892f6cb::pool_registry::PoolRegistry {
        &mut arg0.pool_registry
    }

    public(friend) fun borrow_mut_pool_registry_and_position_registry_and_pdo_minter(arg0: &mut State) : (&mut 0xa2b0cea68ded8ac9dd3321999c4bce21153181af7f3e3b47fd6789f23892f6cb::pool_registry::PoolRegistry, &mut 0xa2b0cea68ded8ac9dd3321999c4bce21153181af7f3e3b47fd6789f23892f6cb::position_registry::PositionRegistry, &0x163b0554f3a4574f4ff0910de5e8622ac12713cc73f2abadf0a7ebcdfea30284::access_control::Member<0x4fc3949a4a8fe3ad9c75cec9724ff2b2d8520506b6129c9d8f0fcc2a1e4a8880::pdo_minter_role::PDO_MINTER_ROLE>) {
        (&mut arg0.pool_registry, &mut arg0.position_registry, &arg0.pdo_minter)
    }

    public(friend) fun borrow_mut_position_registry(arg0: &mut State) : &mut 0xa2b0cea68ded8ac9dd3321999c4bce21153181af7f3e3b47fd6789f23892f6cb::position_registry::PositionRegistry {
        &mut arg0.position_registry
    }

    public fun borrow_pool_registry(arg0: &State) : &0xa2b0cea68ded8ac9dd3321999c4bce21153181af7f3e3b47fd6789f23892f6cb::pool_registry::PoolRegistry {
        &arg0.pool_registry
    }

    public fun borrow_position_registry(arg0: &State) : &0xa2b0cea68ded8ac9dd3321999c4bce21153181af7f3e3b47fd6789f23892f6cb::position_registry::PositionRegistry {
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

