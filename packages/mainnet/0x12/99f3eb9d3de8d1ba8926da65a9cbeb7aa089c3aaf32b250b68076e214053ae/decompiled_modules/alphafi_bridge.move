module 0x1299f3eb9d3de8d1ba8926da65a9cbeb7aa089c3aaf32b250b68076e214053ae::alphafi_bridge {
    struct BridgeState has key {
        id: 0x2::object::UID,
        position_cap: 0x174f8732ffd2ffc97a38afbf4c19d94f398cec4dec1543f709b3d33748147685::position::PositionCap,
    }

    public fun create_bridge_state(arg0: 0x174f8732ffd2ffc97a38afbf4c19d94f398cec4dec1543f709b3d33748147685::position::PositionCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = BridgeState{
            id           : 0x2::object::new(arg1),
            position_cap : arg0,
        };
        0x2::transfer::share_object<BridgeState>(v0);
    }

    public fun deposit_to_alphafi<T0>(arg0: &mut 0x174f8732ffd2ffc97a38afbf4c19d94f398cec4dec1543f709b3d33748147685::alpha_lending::LendingProtocol, arg1: &mut 0x174f8732ffd2ffc97a38afbf4c19d94f398cec4dec1543f709b3d33748147685::position::PositionCap, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0x174f8732ffd2ffc97a38afbf4c19d94f398cec4dec1543f709b3d33748147685::alpha_lending::add_collateral<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun withdraw_from_alphafi<T0>(arg0: &mut 0x174f8732ffd2ffc97a38afbf4c19d94f398cec4dec1543f709b3d33748147685::alpha_lending::LendingProtocol, arg1: &mut 0x174f8732ffd2ffc97a38afbf4c19d94f398cec4dec1543f709b3d33748147685::position::PositionCap, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x174f8732ffd2ffc97a38afbf4c19d94f398cec4dec1543f709b3d33748147685::alpha_lending::Promise) {
        (0x174f8732ffd2ffc97a38afbf4c19d94f398cec4dec1543f709b3d33748147685::alpha_lending::fulfill_promise<T0>(arg0, 0x174f8732ffd2ffc97a38afbf4c19d94f398cec4dec1543f709b3d33748147685::alpha_lending::remove_collateral<T0>(arg0, arg1, arg2, arg3, arg4), arg4), 0x174f8732ffd2ffc97a38afbf4c19d94f398cec4dec1543f709b3d33748147685::alpha_lending::create_dummy_promise())
    }

    // decompiled from Move bytecode v6
}

