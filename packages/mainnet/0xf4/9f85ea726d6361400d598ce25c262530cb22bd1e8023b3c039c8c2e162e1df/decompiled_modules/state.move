module 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::state {
    struct State has store, key {
        id: 0x2::object::UID,
        started_at_sec: u64,
        ended_at_sec: u64,
        reward_per_sec: u64,
        total_alloc_point: u64,
        pool_registry: 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::pool_registry::PoolRegistry,
        psh_minter: 0x163b0554f3a4574f4ff0910de5e8622ac12713cc73f2abadf0a7ebcdfea30284::access_control::Member<0x3c1227010835ecf9cb8f2bf9993aa9378bb951f0b3a098de6f0ee20385e01c4a::psh_minter_role::PSH_MINTER_ROLE>,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext, arg1: u64, arg2: u64) : State {
        State{
            id                : 0x2::object::new(arg0),
            started_at_sec    : arg1,
            ended_at_sec      : arg2,
            reward_per_sec    : 0,
            total_alloc_point : 0,
            pool_registry     : 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::pool_registry::new(arg0),
            psh_minter        : 0x163b0554f3a4574f4ff0910de5e8622ac12713cc73f2abadf0a7ebcdfea30284::access_control::create_member<0x3c1227010835ecf9cb8f2bf9993aa9378bb951f0b3a098de6f0ee20385e01c4a::psh_minter_role::PSH_MINTER_ROLE>(arg0),
        }
    }

    public(friend) fun borrow_mut_pool_registry(arg0: &mut State) : &mut 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::pool_registry::PoolRegistry {
        &mut arg0.pool_registry
    }

    public(friend) fun borrow_mut_pool_registry_and_psh_minter(arg0: &mut State) : (&mut 0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::pool_registry::PoolRegistry, &0x163b0554f3a4574f4ff0910de5e8622ac12713cc73f2abadf0a7ebcdfea30284::access_control::Member<0x3c1227010835ecf9cb8f2bf9993aa9378bb951f0b3a098de6f0ee20385e01c4a::psh_minter_role::PSH_MINTER_ROLE>) {
        (&mut arg0.pool_registry, &arg0.psh_minter)
    }

    public fun borrow_pool_registry(arg0: &State) : &0xf49f85ea726d6361400d598ce25c262530cb22bd1e8023b3c039c8c2e162e1df::pool_registry::PoolRegistry {
        &arg0.pool_registry
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

