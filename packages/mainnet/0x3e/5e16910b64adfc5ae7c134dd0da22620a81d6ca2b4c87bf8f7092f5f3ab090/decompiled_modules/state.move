module 0x3e5e16910b64adfc5ae7c134dd0da22620a81d6ca2b4c87bf8f7092f5f3ab090::state {
    struct State has store, key {
        id: 0x2::object::UID,
        core_bridge_state: address,
        token_bridge_state: address,
    }

    public(friend) fun new(arg0: &0x2::package::Publisher, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : State {
        0x2::package::from_package<0x3e5e16910b64adfc5ae7c134dd0da22620a81d6ca2b4c87bf8f7092f5f3ab090::wormhole_token_bridge_resolver::WORMHOLE_TOKEN_BRIDGE_RESOLVER>(arg0);
        State{
            id                 : 0x2::object::new(arg3),
            core_bridge_state  : arg1,
            token_bridge_state : arg2,
        }
    }

    public fun core_bridge_state(arg0: &State) : address {
        arg0.core_bridge_state
    }

    public fun token_bridge_state(arg0: &State) : address {
        arg0.token_bridge_state
    }

    // decompiled from Move bytecode v6
}

