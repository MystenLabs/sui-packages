module 0xfc0e04c6047ca3683456fffc0af93a76c7404df293f186e91feeae13e9e37159::bluefin_bridge {
    struct BridgeState has key {
        id: 0x2::object::UID,
        position_cap: 0xfa55bddbae1f8fed6fb30c6113e2d45e9907ef4b6f052a673bb28e734f497b2a::position::PositionCap,
    }

    public fun create_bridge_state(arg0: 0xfa55bddbae1f8fed6fb30c6113e2d45e9907ef4b6f052a673bb28e734f497b2a::position::PositionCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = BridgeState{
            id           : 0x2::object::new(arg1),
            position_cap : arg0,
        };
        0x2::transfer::share_object<BridgeState>(v0);
    }

    public fun deposit_to_bluefin<T0>(arg0: &mut 0xfa55bddbae1f8fed6fb30c6113e2d45e9907ef4b6f052a673bb28e734f497b2a::bluefin_lending::LendingProtocol, arg1: &mut 0xfa55bddbae1f8fed6fb30c6113e2d45e9907ef4b6f052a673bb28e734f497b2a::position::PositionCap, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0xfa55bddbae1f8fed6fb30c6113e2d45e9907ef4b6f052a673bb28e734f497b2a::bluefin_lending::add_collateral<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun withdraw_from_bluefin<T0>(arg0: &mut 0xfa55bddbae1f8fed6fb30c6113e2d45e9907ef4b6f052a673bb28e734f497b2a::bluefin_lending::LendingProtocol, arg1: &mut 0xfa55bddbae1f8fed6fb30c6113e2d45e9907ef4b6f052a673bb28e734f497b2a::position::PositionCap, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0xfa55bddbae1f8fed6fb30c6113e2d45e9907ef4b6f052a673bb28e734f497b2a::bluefin_lending::Promise) {
        (0xfa55bddbae1f8fed6fb30c6113e2d45e9907ef4b6f052a673bb28e734f497b2a::bluefin_lending::fulfill_promise<T0>(arg0, 0xfa55bddbae1f8fed6fb30c6113e2d45e9907ef4b6f052a673bb28e734f497b2a::bluefin_lending::remove_collateral<T0>(arg0, arg1, arg2, arg3, arg4), arg4), 0xfa55bddbae1f8fed6fb30c6113e2d45e9907ef4b6f052a673bb28e734f497b2a::bluefin_lending::create_dummy_promise())
    }

    // decompiled from Move bytecode v6
}

