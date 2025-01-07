module 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::state {
    struct State has store, key {
        id: 0x2::object::UID,
        pool_registry: 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::pool_registry::PoolRegistry,
        fee_collector_registry: 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::fee_collector_registry::FeeCollectorRegistry,
        fee_collector_active_key: 0x2::object::ID,
    }

    public(friend) fun new(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : State {
        let v0 = 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::fee_collector_registry::new(arg1);
        let v1 = 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::fee_collector::new<0x2::sui::SUI>(arg0, arg1);
        0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::fee_collector_registry::register<0x2::sui::SUI>(&mut v0, v1);
        State{
            id                       : 0x2::object::new(arg1),
            pool_registry            : 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::pool_registry::new(arg1),
            fee_collector_registry   : v0,
            fee_collector_active_key : 0x2::object::id<0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::fee_collector::FeeCollector<0x2::sui::SUI>>(&v1),
        }
    }

    public fun borrow_active_fee_collector<T0>(arg0: &State) : &0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::fee_collector::FeeCollector<T0> {
        0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::fee_collector_registry::borrow_fee_collector<T0>(&arg0.fee_collector_registry, arg0.fee_collector_active_key)
    }

    public(friend) fun borrow_mut_active_fee_collector<T0>(arg0: &mut State) : &mut 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::fee_collector::FeeCollector<T0> {
        0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::fee_collector_registry::borrow_mut_fee_collector<T0>(&mut arg0.fee_collector_registry, arg0.fee_collector_active_key)
    }

    public(friend) fun borrow_mut_pool_registry(arg0: &mut State) : &mut 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::pool_registry::PoolRegistry {
        &mut arg0.pool_registry
    }

    public fun borrow_pool_registry(arg0: &State) : &0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::pool_registry::PoolRegistry {
        &arg0.pool_registry
    }

    public(friend) fun register_active_fee_collector<T0>(arg0: &mut State, arg1: 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::fee_collector::FeeCollector<T0>) {
        0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::fee_collector_registry::register<T0>(&mut arg0.fee_collector_registry, arg1);
        arg0.fee_collector_active_key = 0x2::object::id<0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::fee_collector::FeeCollector<T0>>(&arg1);
    }

    // decompiled from Move bytecode v6
}

