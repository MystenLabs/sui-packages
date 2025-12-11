module 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::state {
    struct State has store, key {
        id: 0x2::object::UID,
        started_at_sec: u64,
        ended_at_sec: u64,
        reward_per_sec: u64,
        total_alloc_point: u64,
        pool_registry: 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::pool_registry::PoolRegistry,
        position_registry: 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::position_registry::PositionRegistry,
        reward_token_custodian: 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::custodian::Custodian<0x2::sui::SUI>,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext, arg1: u64, arg2: u64) : State {
        State{
            id                     : 0x2::object::new(arg0),
            started_at_sec         : arg1,
            ended_at_sec           : arg2,
            reward_per_sec         : 0,
            total_alloc_point      : 0,
            pool_registry          : 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::pool_registry::new(arg0),
            position_registry      : 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::position_registry::new(arg0),
            reward_token_custodian : 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::custodian::new<0x2::sui::SUI>(),
        }
    }

    public(friend) fun borrow_mut_pool_registry(arg0: &mut State) : &mut 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::pool_registry::PoolRegistry {
        &mut arg0.pool_registry
    }

    public(friend) fun borrow_mut_pool_registry_and_position_registry_and_reward_token_custodian(arg0: &mut State) : (&mut 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::pool_registry::PoolRegistry, &mut 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::position_registry::PositionRegistry, &mut 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::custodian::Custodian<0x2::sui::SUI>) {
        (&mut arg0.pool_registry, &mut arg0.position_registry, &mut arg0.reward_token_custodian)
    }

    public(friend) fun borrow_mut_position_registry(arg0: &mut State) : &mut 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::position_registry::PositionRegistry {
        &mut arg0.position_registry
    }

    public(friend) fun borrow_mut_reward_token_custodian(arg0: &mut State) : &mut 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::custodian::Custodian<0x2::sui::SUI> {
        &mut arg0.reward_token_custodian
    }

    public fun borrow_pool_registry(arg0: &State) : &0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::pool_registry::PoolRegistry {
        &arg0.pool_registry
    }

    public fun borrow_position_registry(arg0: &State) : &0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::position_registry::PositionRegistry {
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

    public(friend) fun set_ended_at_sec(arg0: &mut State, arg1: u64) {
        arg0.ended_at_sec = arg1;
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

