module 0x1ab037d03714732b28429bcef258f5c5b3034949a071c41e07683b0038e0253a::resolver_state {
    struct State has store, key {
        id: 0x2::object::UID,
        package_id: address,
        module_name: 0x1::string::String,
        wormhole_state: address,
        token_bridge_state: address,
        relayer_state: address,
    }

    public(friend) fun new(arg0: address, arg1: 0x1::string::String, arg2: address, arg3: address, arg4: address, arg5: &mut 0x2::tx_context::TxContext) : State {
        State{
            id                 : 0x2::object::new(arg5),
            package_id         : arg0,
            module_name        : arg1,
            wormhole_state     : arg2,
            token_bridge_state : arg3,
            relayer_state      : arg4,
        }
    }

    public fun module_name(arg0: &State) : 0x1::string::String {
        arg0.module_name
    }

    public fun package_id(arg0: &State) : address {
        arg0.package_id
    }

    public fun relayer_state(arg0: &State) : address {
        arg0.relayer_state
    }

    public fun token_bridge_state(arg0: &State) : address {
        arg0.token_bridge_state
    }

    public fun wormhole_state(arg0: &State) : address {
        arg0.wormhole_state
    }

    // decompiled from Move bytecode v6
}

