module 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::pool_registry {
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

    public(friend) fun borrow_mut_pool<T0, T1>(arg0: &mut PoolRegistry, arg1: u64) : &mut 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::pool::Pool<T0, T1> {
        assert_registered(arg0, arg1);
        0x2::dynamic_field::borrow_mut<u64, 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::pool::Pool<T0, T1>>(&mut arg0.id, arg1)
    }

    public fun borrow_pool<T0, T1>(arg0: &PoolRegistry, arg1: u64) : &0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::pool::Pool<T0, T1> {
        assert_registered(arg0, arg1);
        0x2::dynamic_field::borrow<u64, 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::pool::Pool<T0, T1>>(&arg0.id, arg1)
    }

    public fun num_pools(arg0: &PoolRegistry) : u64 {
        arg0.num_pools
    }

    public(friend) fun register<T0, T1>(arg0: &mut PoolRegistry, arg1: 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::pool::Pool<T0, T1>) {
        0x2::dynamic_field::add<u64, 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::pool::Pool<T0, T1>>(&mut arg0.id, num_pools(arg0), arg1);
        arg0.num_pools = arg0.num_pools + 1;
    }

    // decompiled from Move bytecode v6
}

