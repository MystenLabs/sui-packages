module 0xf602b30137be816e840e5147d988de83b035ad2e96472f9768707dc4f00b325c::m4223abaa9944d60a3f5045cd {
    public fun f6a29c897e19a7215022e8f40(arg0: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg1: &0x378b2a104e8bcd7ed0317f5e6a0ec4fd271d4d12e2fe6c99bcd1f12be725cf4f::oracle::PriceInfo) {
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::update_price(arg0, arg1);
    }

    public fun fc95bf7bb87ad105bf61586f7(arg0: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg1: 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::LiquidityPromise<0x2::sui::SUI>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise_SUI(arg0, arg1, arg2, arg3, arg4)
    }

    public fun fd34e370e9b4b5f7d21369006<T0, T1>(arg0: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::LiquidityPromise<T1>, 0x2::coin::Coin<T0>) {
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::liquidate<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun ff72d6e20806e8c4505764c68<T0>(arg0: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg1: 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::LiquidityPromise<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg0, arg1, arg2, arg3)
    }

    // decompiled from Move bytecode v7
}

