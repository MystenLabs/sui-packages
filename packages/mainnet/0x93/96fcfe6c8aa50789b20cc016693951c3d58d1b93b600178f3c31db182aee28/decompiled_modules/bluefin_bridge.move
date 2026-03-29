module 0x9396fcfe6c8aa50789b20cc016693951c3d58d1b93b600178f3c31db182aee28::bluefin_bridge {
    struct BridgeState has key {
        id: 0x2::object::UID,
        position_cap: 0xef7f696f92b867b24c5f0aff8dbc38c9a19a7212af537fa1c5ed6506727acf33::position::PositionCap,
    }

    public fun create_bridge_state(arg0: 0xef7f696f92b867b24c5f0aff8dbc38c9a19a7212af537fa1c5ed6506727acf33::position::PositionCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = BridgeState{
            id           : 0x2::object::new(arg1),
            position_cap : arg0,
        };
        0x2::transfer::share_object<BridgeState>(v0);
    }

    public fun deposit_to_bluefin<T0>(arg0: &mut 0xef7f696f92b867b24c5f0aff8dbc38c9a19a7212af537fa1c5ed6506727acf33::bluefin_lending::LendingProtocol, arg1: &mut 0xef7f696f92b867b24c5f0aff8dbc38c9a19a7212af537fa1c5ed6506727acf33::position::PositionCap, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0xef7f696f92b867b24c5f0aff8dbc38c9a19a7212af537fa1c5ed6506727acf33::bluefin_lending::add_collateral<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun withdraw_from_bluefin<T0>(arg0: &mut 0xef7f696f92b867b24c5f0aff8dbc38c9a19a7212af537fa1c5ed6506727acf33::bluefin_lending::LendingProtocol, arg1: &mut 0xef7f696f92b867b24c5f0aff8dbc38c9a19a7212af537fa1c5ed6506727acf33::position::PositionCap, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0xef7f696f92b867b24c5f0aff8dbc38c9a19a7212af537fa1c5ed6506727acf33::bluefin_lending::Promise) {
        (0xef7f696f92b867b24c5f0aff8dbc38c9a19a7212af537fa1c5ed6506727acf33::bluefin_lending::fulfill_promise<T0>(arg0, 0xef7f696f92b867b24c5f0aff8dbc38c9a19a7212af537fa1c5ed6506727acf33::bluefin_lending::remove_collateral<T0>(arg0, arg1, arg2, arg3, arg4), arg4), 0xef7f696f92b867b24c5f0aff8dbc38c9a19a7212af537fa1c5ed6506727acf33::bluefin_lending::create_dummy_promise())
    }

    // decompiled from Move bytecode v6
}

