module 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::router {
    public entry fun cancel_redeem_lock(arg0: &mut 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::locking::LockUpManager, arg1: &mut 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::XcetusManager, arg2: &mut 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::VeNFT, arg3: 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::lock_coin::LockedCoin<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>, arg4: &0x2::clock::Clock) {
        0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::locking::cancel_redeem_lock(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun convert(arg0: &mut 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::locking::LockUpManager, arg1: &mut 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::XcetusManager, arg2: vector<0x2::coin::Coin<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>>, arg3: u64, arg4: &mut 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::VeNFT, arg5: &mut 0x2::tx_context::TxContext) {
        0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::locking::convert(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun mint_and_convert(arg0: &mut 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::locking::LockUpManager, arg1: &mut 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::XcetusManager, arg2: vector<0x2::coin::Coin<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::locking::mint_and_convert(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun redeem(arg0: &mut 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::locking::LockUpManager, arg1: &mut 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::XcetusManager, arg2: &mut 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::VeNFT, arg3: 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::lock_coin::LockedCoin<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::locking::redeem(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun redeem_lock(arg0: &mut 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::locking::LockUpManager, arg1: &mut 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::XcetusManager, arg2: &mut 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::VeNFT, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::locking::redeem_lock(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun burn_venft(arg0: &mut 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::XcetusManager, arg1: 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::VeNFT, arg2: &mut 0x2::tx_context::TxContext) {
        0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::burn_venft(arg0, arg1, arg2);
    }

    public entry fun mint_venft(arg0: &mut 0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::XcetusManager, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x9e69acc50ca03bc943c4f7c5304c2a6002d507b51c11913b247159c60422c606::xcetus::mint_venft(arg0, arg1)
    }

    // decompiled from Move bytecode v6
}

