module 0xeb33097dcf180007cc5f8ebea2403600a7b3e7b166a141c3f41d596062eab5ae::router {
    public entry fun cancel_redeem_lock(arg0: &mut 0xeb33097dcf180007cc5f8ebea2403600a7b3e7b166a141c3f41d596062eab5ae::locking::LockUpManager, arg1: &mut 0xeb33097dcf180007cc5f8ebea2403600a7b3e7b166a141c3f41d596062eab5ae::xcetus::XcetusManager, arg2: &mut 0xeb33097dcf180007cc5f8ebea2403600a7b3e7b166a141c3f41d596062eab5ae::xcetus::VeNFT, arg3: 0xeb33097dcf180007cc5f8ebea2403600a7b3e7b166a141c3f41d596062eab5ae::lock_coin::LockedCoin<0xcc8aa71adcc99cb87790b6d25383a1ce0da8ac641a57b158748c55f3273350f1::cetus::CETUS>, arg4: &0x2::clock::Clock) {
        0xeb33097dcf180007cc5f8ebea2403600a7b3e7b166a141c3f41d596062eab5ae::locking::cancel_redeem_lock(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun convert(arg0: &mut 0xeb33097dcf180007cc5f8ebea2403600a7b3e7b166a141c3f41d596062eab5ae::locking::LockUpManager, arg1: &mut 0xeb33097dcf180007cc5f8ebea2403600a7b3e7b166a141c3f41d596062eab5ae::xcetus::XcetusManager, arg2: vector<0x2::coin::Coin<0xcc8aa71adcc99cb87790b6d25383a1ce0da8ac641a57b158748c55f3273350f1::cetus::CETUS>>, arg3: u64, arg4: &mut 0xeb33097dcf180007cc5f8ebea2403600a7b3e7b166a141c3f41d596062eab5ae::xcetus::VeNFT, arg5: &mut 0x2::tx_context::TxContext) {
        0xeb33097dcf180007cc5f8ebea2403600a7b3e7b166a141c3f41d596062eab5ae::locking::convert(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun mint_and_convert(arg0: &mut 0xeb33097dcf180007cc5f8ebea2403600a7b3e7b166a141c3f41d596062eab5ae::locking::LockUpManager, arg1: &mut 0xeb33097dcf180007cc5f8ebea2403600a7b3e7b166a141c3f41d596062eab5ae::xcetus::XcetusManager, arg2: vector<0x2::coin::Coin<0xcc8aa71adcc99cb87790b6d25383a1ce0da8ac641a57b158748c55f3273350f1::cetus::CETUS>>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0xeb33097dcf180007cc5f8ebea2403600a7b3e7b166a141c3f41d596062eab5ae::locking::mint_and_convert(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun redeem(arg0: &mut 0xeb33097dcf180007cc5f8ebea2403600a7b3e7b166a141c3f41d596062eab5ae::locking::LockUpManager, arg1: &mut 0xeb33097dcf180007cc5f8ebea2403600a7b3e7b166a141c3f41d596062eab5ae::xcetus::XcetusManager, arg2: &mut 0xeb33097dcf180007cc5f8ebea2403600a7b3e7b166a141c3f41d596062eab5ae::xcetus::VeNFT, arg3: 0xeb33097dcf180007cc5f8ebea2403600a7b3e7b166a141c3f41d596062eab5ae::lock_coin::LockedCoin<0xcc8aa71adcc99cb87790b6d25383a1ce0da8ac641a57b158748c55f3273350f1::cetus::CETUS>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xeb33097dcf180007cc5f8ebea2403600a7b3e7b166a141c3f41d596062eab5ae::locking::redeem(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun redeem_lock(arg0: &mut 0xeb33097dcf180007cc5f8ebea2403600a7b3e7b166a141c3f41d596062eab5ae::locking::LockUpManager, arg1: &mut 0xeb33097dcf180007cc5f8ebea2403600a7b3e7b166a141c3f41d596062eab5ae::xcetus::XcetusManager, arg2: &mut 0xeb33097dcf180007cc5f8ebea2403600a7b3e7b166a141c3f41d596062eab5ae::xcetus::VeNFT, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xeb33097dcf180007cc5f8ebea2403600a7b3e7b166a141c3f41d596062eab5ae::locking::redeem_lock(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun burn_venft(arg0: &mut 0xeb33097dcf180007cc5f8ebea2403600a7b3e7b166a141c3f41d596062eab5ae::xcetus::XcetusManager, arg1: 0xeb33097dcf180007cc5f8ebea2403600a7b3e7b166a141c3f41d596062eab5ae::xcetus::VeNFT, arg2: &mut 0x2::tx_context::TxContext) {
        0xeb33097dcf180007cc5f8ebea2403600a7b3e7b166a141c3f41d596062eab5ae::xcetus::burn_venft(arg0, arg1, arg2);
    }

    public entry fun mint_venft(arg0: &mut 0xeb33097dcf180007cc5f8ebea2403600a7b3e7b166a141c3f41d596062eab5ae::xcetus::XcetusManager, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xeb33097dcf180007cc5f8ebea2403600a7b3e7b166a141c3f41d596062eab5ae::xcetus::mint_venft(arg0, arg1)
    }

    // decompiled from Move bytecode v6
}

