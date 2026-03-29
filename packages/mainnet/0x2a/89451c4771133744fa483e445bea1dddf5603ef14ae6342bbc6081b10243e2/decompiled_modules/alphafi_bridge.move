module 0x2a89451c4771133744fa483e445bea1dddf5603ef14ae6342bbc6081b10243e2::alphafi_bridge {
    struct BridgeState has key {
        id: 0x2::object::UID,
        position_cap: 0x1e814c2d024d5f7f521b2ef1efbc7947d695af10934ec324d89a87ac655f948d::position::PositionCap,
    }

    public fun create_bridge_state(arg0: 0x1e814c2d024d5f7f521b2ef1efbc7947d695af10934ec324d89a87ac655f948d::position::PositionCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = BridgeState{
            id           : 0x2::object::new(arg1),
            position_cap : arg0,
        };
        0x2::transfer::share_object<BridgeState>(v0);
    }

    public fun deposit_to_alphafi<T0>(arg0: &mut 0x1e814c2d024d5f7f521b2ef1efbc7947d695af10934ec324d89a87ac655f948d::alpha_lending::LendingProtocol, arg1: &mut 0x1e814c2d024d5f7f521b2ef1efbc7947d695af10934ec324d89a87ac655f948d::position::PositionCap, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0x1e814c2d024d5f7f521b2ef1efbc7947d695af10934ec324d89a87ac655f948d::alpha_lending::add_collateral<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun withdraw_from_alphafi<T0>(arg0: &mut 0x1e814c2d024d5f7f521b2ef1efbc7947d695af10934ec324d89a87ac655f948d::alpha_lending::LendingProtocol, arg1: &mut 0x1e814c2d024d5f7f521b2ef1efbc7947d695af10934ec324d89a87ac655f948d::position::PositionCap, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x1e814c2d024d5f7f521b2ef1efbc7947d695af10934ec324d89a87ac655f948d::alpha_lending::Promise) {
        (0x1e814c2d024d5f7f521b2ef1efbc7947d695af10934ec324d89a87ac655f948d::alpha_lending::fulfill_promise<T0>(arg0, 0x1e814c2d024d5f7f521b2ef1efbc7947d695af10934ec324d89a87ac655f948d::alpha_lending::remove_collateral<T0>(arg0, arg1, arg2, arg3, arg4), arg4), 0x1e814c2d024d5f7f521b2ef1efbc7947d695af10934ec324d89a87ac655f948d::alpha_lending::create_dummy_promise())
    }

    // decompiled from Move bytecode v6
}

