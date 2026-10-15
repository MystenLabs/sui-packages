module 0x7f285a6e9468e9e970ba4db033bf2056f05099f3731c3a66b4397c51d77b9770::m6efc2abd78717fbe969ea0f6 {
    public fun f1615e36540b088ee6d599644<T0, T1>(arg0: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::LiquidityPromise<T1>, 0x2::coin::Coin<T0>) {
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::liquidate<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun f8136bba385ecb9c45cc868a5(arg0: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg1: &0x378b2a104e8bcd7ed0317f5e6a0ec4fd271d4d12e2fe6c99bcd1f12be725cf4f::oracle::PriceInfo) {
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::update_price(arg0, arg1);
    }

    public fun f94c3d030a827510172e00dbf<T0>(arg0: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg1: 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::LiquidityPromise<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg0, arg1, arg2, arg3)
    }

    public fun fd9ceeac6107abcd59bb0fba6(arg0: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg1: 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::LiquidityPromise<0x2::sui::SUI>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise_SUI(arg0, arg1, arg2, arg3, arg4)
    }

    // decompiled from Move bytecode v7
}

