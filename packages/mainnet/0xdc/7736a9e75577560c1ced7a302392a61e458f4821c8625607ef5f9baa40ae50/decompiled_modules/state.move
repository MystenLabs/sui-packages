module 0xdc7736a9e75577560c1ced7a302392a61e458f4821c8625607ef5f9baa40ae50::state {
    struct State has store, key {
        id: 0x2::object::UID,
        admin: address,
        current_package: address,
        core_bridge_state: address,
        token_bridge_state: address,
    }

    public(friend) fun new(arg0: address, arg1: address, arg2: address, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : State {
        State{
            id                 : 0x2::object::new(arg4),
            admin              : arg0,
            current_package    : arg1,
            core_bridge_state  : arg2,
            token_bridge_state : arg3,
        }
    }

    public fun core_bridge_state(arg0: &State) : address {
        arg0.core_bridge_state
    }

    public fun current_package(arg0: &State) : address {
        arg0.current_package
    }

    public fun token_bridge_state(arg0: &State) : address {
        arg0.token_bridge_state
    }

    public fun update_package(arg0: &mut State, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        arg0.current_package = arg1;
    }

    // decompiled from Move bytecode v6
}

