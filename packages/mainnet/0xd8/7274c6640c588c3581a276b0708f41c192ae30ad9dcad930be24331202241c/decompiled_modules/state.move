module 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::state {
    struct State has store, key {
        id: 0x2::object::UID,
        pool_registry: 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::pool_registry::PoolRegistry,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : State {
        State{
            id            : 0x2::object::new(arg0),
            pool_registry : 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::pool_registry::new(arg0),
        }
    }

    public(friend) fun borrow_mut_pool_registry(arg0: &mut State) : &mut 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::pool_registry::PoolRegistry {
        &mut arg0.pool_registry
    }

    public fun borrow_pool_registry(arg0: &State) : &0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::pool_registry::PoolRegistry {
        &arg0.pool_registry
    }

    // decompiled from Move bytecode v6
}

