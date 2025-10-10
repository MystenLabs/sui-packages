module 0x4dae80280a095d9319646896ff655d46b62f16781e81528baa48734d91b9dce5::state {
    struct State has store, key {
        id: 0x2::object::UID,
        package_id: address,
        module_name: 0x1::string::String,
        core_bridge_state: address,
        token_bridge_state: address,
    }

    public(friend) fun new(arg0: &0x2::package::Publisher, arg1: address, arg2: 0x1::string::String, arg3: address, arg4: address, arg5: &mut 0x2::tx_context::TxContext) : State {
        0x2::package::from_package<0x4dae80280a095d9319646896ff655d46b62f16781e81528baa48734d91b9dce5::wormhole_token_bridge_resolver::WORMHOLE_TOKEN_BRIDGE_RESOLVER>(arg0);
        State{
            id                 : 0x2::object::new(arg5),
            package_id         : arg1,
            module_name        : arg2,
            core_bridge_state  : arg3,
            token_bridge_state : arg4,
        }
    }

    public fun core_bridge_state(arg0: &State) : address {
        arg0.core_bridge_state
    }

    public fun module_name(arg0: &State) : 0x1::string::String {
        arg0.module_name
    }

    public fun package_id(arg0: &State) : address {
        arg0.package_id
    }

    public fun token_bridge_state(arg0: &State) : address {
        arg0.token_bridge_state
    }

    // decompiled from Move bytecode v6
}

