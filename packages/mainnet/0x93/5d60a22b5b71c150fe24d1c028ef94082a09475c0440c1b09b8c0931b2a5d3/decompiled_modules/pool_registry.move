module 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::pool_registry {
    struct PoolRegistry has store, key {
        id: 0x2::object::UID,
        num_pools: u64,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : PoolRegistry {
        PoolRegistry{
            id        : 0x2::object::new(arg0),
            num_pools : 0,
        }
    }

    public fun assert_registered(arg0: &PoolRegistry, arg1: u64) {
        assert!(num_pools(arg0) > arg1, 0);
    }

    public(friend) fun borrow_mut_pool<T0, T1, T2>(arg0: &mut PoolRegistry, arg1: u64) : &mut 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::pool::Pool<T0, T1, T2> {
        assert_registered(arg0, arg1);
        0x2::dynamic_field::borrow_mut<u64, 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::pool::Pool<T0, T1, T2>>(&mut arg0.id, arg1)
    }

    public fun borrow_pool<T0, T1, T2>(arg0: &PoolRegistry, arg1: u64) : &0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::pool::Pool<T0, T1, T2> {
        assert_registered(arg0, arg1);
        0x2::dynamic_field::borrow<u64, 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::pool::Pool<T0, T1, T2>>(&arg0.id, arg1)
    }

    public fun num_pools(arg0: &PoolRegistry) : u64 {
        arg0.num_pools
    }

    public(friend) fun register<T0, T1, T2>(arg0: &mut PoolRegistry, arg1: 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::pool::Pool<T0, T1, T2>) {
        0x2::dynamic_field::add<u64, 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::pool::Pool<T0, T1, T2>>(&mut arg0.id, num_pools(arg0), arg1);
        arg0.num_pools = arg0.num_pools + 1;
    }

    // decompiled from Move bytecode v6
}

