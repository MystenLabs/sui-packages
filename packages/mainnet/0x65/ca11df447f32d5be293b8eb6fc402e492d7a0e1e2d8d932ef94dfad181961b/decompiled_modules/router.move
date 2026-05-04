module 0x65ca11df447f32d5be293b8eb6fc402e492d7a0e1e2d8d932ef94dfad181961b::router {
    public entry fun cancel_redeem_lock(arg0: &mut 0x65ca11df447f32d5be293b8eb6fc402e492d7a0e1e2d8d932ef94dfad181961b::locking::LockUpManager, arg1: &mut 0x65ca11df447f32d5be293b8eb6fc402e492d7a0e1e2d8d932ef94dfad181961b::xcetus::XcetusManager, arg2: &mut 0x65ca11df447f32d5be293b8eb6fc402e492d7a0e1e2d8d932ef94dfad181961b::xcetus::VeNFT, arg3: 0x65ca11df447f32d5be293b8eb6fc402e492d7a0e1e2d8d932ef94dfad181961b::lock_coin::LockedCoin<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>, arg4: &0x2::clock::Clock) {
        0x65ca11df447f32d5be293b8eb6fc402e492d7a0e1e2d8d932ef94dfad181961b::locking::cancel_redeem_lock(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun cancel_redeem_lock_v2(arg0: &mut 0x65ca11df447f32d5be293b8eb6fc402e492d7a0e1e2d8d932ef94dfad181961b::locking::LockUpManager, arg1: &mut 0x65ca11df447f32d5be293b8eb6fc402e492d7a0e1e2d8d932ef94dfad181961b::xcetus::XcetusManager, arg2: &mut 0x65ca11df447f32d5be293b8eb6fc402e492d7a0e1e2d8d932ef94dfad181961b::xcetus::VeNFT, arg3: 0x65ca11df447f32d5be293b8eb6fc402e492d7a0e1e2d8d932ef94dfad181961b::lock_coin_v2::LockedCoinV2<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>, arg4: &0x2::clock::Clock) {
        0x65ca11df447f32d5be293b8eb6fc402e492d7a0e1e2d8d932ef94dfad181961b::locking::cancel_redeem_lock_v2(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun convert(arg0: &mut 0x65ca11df447f32d5be293b8eb6fc402e492d7a0e1e2d8d932ef94dfad181961b::locking::LockUpManager, arg1: &mut 0x65ca11df447f32d5be293b8eb6fc402e492d7a0e1e2d8d932ef94dfad181961b::xcetus::XcetusManager, arg2: vector<0x2::coin::Coin<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>>, arg3: u64, arg4: &mut 0x65ca11df447f32d5be293b8eb6fc402e492d7a0e1e2d8d932ef94dfad181961b::xcetus::VeNFT, arg5: &mut 0x2::tx_context::TxContext) {
        0x65ca11df447f32d5be293b8eb6fc402e492d7a0e1e2d8d932ef94dfad181961b::locking::convert(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun mint_and_convert(arg0: &mut 0x65ca11df447f32d5be293b8eb6fc402e492d7a0e1e2d8d932ef94dfad181961b::locking::LockUpManager, arg1: &mut 0x65ca11df447f32d5be293b8eb6fc402e492d7a0e1e2d8d932ef94dfad181961b::xcetus::XcetusManager, arg2: vector<0x2::coin::Coin<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x65ca11df447f32d5be293b8eb6fc402e492d7a0e1e2d8d932ef94dfad181961b::locking::mint_and_convert(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun redeem(arg0: &mut 0x65ca11df447f32d5be293b8eb6fc402e492d7a0e1e2d8d932ef94dfad181961b::locking::LockUpManager, arg1: &mut 0x65ca11df447f32d5be293b8eb6fc402e492d7a0e1e2d8d932ef94dfad181961b::xcetus::XcetusManager, arg2: &mut 0x65ca11df447f32d5be293b8eb6fc402e492d7a0e1e2d8d932ef94dfad181961b::xcetus::VeNFT, arg3: 0x65ca11df447f32d5be293b8eb6fc402e492d7a0e1e2d8d932ef94dfad181961b::lock_coin::LockedCoin<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x65ca11df447f32d5be293b8eb6fc402e492d7a0e1e2d8d932ef94dfad181961b::locking::redeem(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun redeem_lock(arg0: &mut 0x65ca11df447f32d5be293b8eb6fc402e492d7a0e1e2d8d932ef94dfad181961b::locking::LockUpManager, arg1: &mut 0x65ca11df447f32d5be293b8eb6fc402e492d7a0e1e2d8d932ef94dfad181961b::xcetus::XcetusManager, arg2: &mut 0x65ca11df447f32d5be293b8eb6fc402e492d7a0e1e2d8d932ef94dfad181961b::xcetus::VeNFT, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x65ca11df447f32d5be293b8eb6fc402e492d7a0e1e2d8d932ef94dfad181961b::locking::redeem_lock(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun redeem_lock_v2(arg0: &mut 0x65ca11df447f32d5be293b8eb6fc402e492d7a0e1e2d8d932ef94dfad181961b::locking::LockUpManager, arg1: &mut 0x65ca11df447f32d5be293b8eb6fc402e492d7a0e1e2d8d932ef94dfad181961b::xcetus::XcetusManager, arg2: &mut 0x65ca11df447f32d5be293b8eb6fc402e492d7a0e1e2d8d932ef94dfad181961b::xcetus::VeNFT, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x65ca11df447f32d5be293b8eb6fc402e492d7a0e1e2d8d932ef94dfad181961b::locking::redeem_lock_v2(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun redeem_v2(arg0: &mut 0x65ca11df447f32d5be293b8eb6fc402e492d7a0e1e2d8d932ef94dfad181961b::locking::LockUpManager, arg1: &mut 0x65ca11df447f32d5be293b8eb6fc402e492d7a0e1e2d8d932ef94dfad181961b::xcetus::XcetusManager, arg2: &mut 0x65ca11df447f32d5be293b8eb6fc402e492d7a0e1e2d8d932ef94dfad181961b::xcetus::VeNFT, arg3: 0x65ca11df447f32d5be293b8eb6fc402e492d7a0e1e2d8d932ef94dfad181961b::lock_coin_v2::LockedCoinV2<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x65ca11df447f32d5be293b8eb6fc402e492d7a0e1e2d8d932ef94dfad181961b::locking::redeem_v2(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun set_convert_paused(arg0: &mut 0x65ca11df447f32d5be293b8eb6fc402e492d7a0e1e2d8d932ef94dfad181961b::locking::LockUpManager, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        0x65ca11df447f32d5be293b8eb6fc402e492d7a0e1e2d8d932ef94dfad181961b::locking::set_convert_paused(arg0, arg1, arg2);
    }

    public entry fun burn_venft(arg0: &mut 0x65ca11df447f32d5be293b8eb6fc402e492d7a0e1e2d8d932ef94dfad181961b::xcetus::XcetusManager, arg1: 0x65ca11df447f32d5be293b8eb6fc402e492d7a0e1e2d8d932ef94dfad181961b::xcetus::VeNFT, arg2: &mut 0x2::tx_context::TxContext) {
        0x65ca11df447f32d5be293b8eb6fc402e492d7a0e1e2d8d932ef94dfad181961b::xcetus::burn_venft(arg0, arg1, arg2);
    }

    public entry fun mint_venft(arg0: &mut 0x65ca11df447f32d5be293b8eb6fc402e492d7a0e1e2d8d932ef94dfad181961b::xcetus::XcetusManager, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x65ca11df447f32d5be293b8eb6fc402e492d7a0e1e2d8d932ef94dfad181961b::xcetus::mint_venft(arg0, arg1)
    }

    // decompiled from Move bytecode v7
}

