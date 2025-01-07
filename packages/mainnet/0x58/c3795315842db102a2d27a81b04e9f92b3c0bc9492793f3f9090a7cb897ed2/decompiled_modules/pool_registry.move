module 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::pool_registry {
    struct PoolDfKey has copy, drop, store {
        index: u64,
    }

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

    public(friend) fun borrow_mut_pool(arg0: &mut PoolRegistry, arg1: u64) : &mut 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::pool::Pool {
        assert_registered(arg0, arg1);
        let v0 = PoolDfKey{index: arg1};
        0x2::dynamic_field::borrow_mut<PoolDfKey, 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::pool::Pool>(&mut arg0.id, v0)
    }

    public fun borrow_pool(arg0: &PoolRegistry, arg1: u64) : &0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::pool::Pool {
        assert_registered(arg0, arg1);
        let v0 = PoolDfKey{index: arg1};
        0x2::dynamic_field::borrow<PoolDfKey, 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::pool::Pool>(&arg0.id, v0)
    }

    public fun num_pools(arg0: &PoolRegistry) : u64 {
        arg0.num_pools
    }

    public(friend) fun register(arg0: &mut PoolRegistry, arg1: 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::pool::Pool) {
        let v0 = PoolDfKey{index: num_pools(arg0)};
        0x2::dynamic_field::add<PoolDfKey, 0x58c3795315842db102a2d27a81b04e9f92b3c0bc9492793f3f9090a7cb897ed2::pool::Pool>(&mut arg0.id, v0, arg1);
        arg0.num_pools = arg0.num_pools + 1;
    }

    // decompiled from Move bytecode v6
}

