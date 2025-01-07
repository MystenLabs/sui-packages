module 0x4aa653953d362d75ae1fe9d47b61ce2997ceb6896da9ff0c9f3eb6ca5bc95d0e::router {
    public entry fun cancel_redeem_lock(arg0: &mut 0x4aa653953d362d75ae1fe9d47b61ce2997ceb6896da9ff0c9f3eb6ca5bc95d0e::locking::LockUpManager, arg1: &mut 0x4aa653953d362d75ae1fe9d47b61ce2997ceb6896da9ff0c9f3eb6ca5bc95d0e::xcetus::XcetusManager, arg2: &mut 0x4aa653953d362d75ae1fe9d47b61ce2997ceb6896da9ff0c9f3eb6ca5bc95d0e::xcetus::VeNFT, arg3: 0x4aa653953d362d75ae1fe9d47b61ce2997ceb6896da9ff0c9f3eb6ca5bc95d0e::lock_coin::LockedCoin<0xcc8aa71adcc99cb87790b6d25383a1ce0da8ac641a57b158748c55f3273350f1::cetus::CETUS>, arg4: &0x2::clock::Clock) {
        0x4aa653953d362d75ae1fe9d47b61ce2997ceb6896da9ff0c9f3eb6ca5bc95d0e::locking::cancel_redeem_lock(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun convert(arg0: &mut 0x4aa653953d362d75ae1fe9d47b61ce2997ceb6896da9ff0c9f3eb6ca5bc95d0e::locking::LockUpManager, arg1: &mut 0x4aa653953d362d75ae1fe9d47b61ce2997ceb6896da9ff0c9f3eb6ca5bc95d0e::xcetus::XcetusManager, arg2: vector<0x2::coin::Coin<0xcc8aa71adcc99cb87790b6d25383a1ce0da8ac641a57b158748c55f3273350f1::cetus::CETUS>>, arg3: u64, arg4: &mut 0x4aa653953d362d75ae1fe9d47b61ce2997ceb6896da9ff0c9f3eb6ca5bc95d0e::xcetus::VeNFT, arg5: &mut 0x2::tx_context::TxContext) {
        0x4aa653953d362d75ae1fe9d47b61ce2997ceb6896da9ff0c9f3eb6ca5bc95d0e::locking::convert(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun mint_and_convert(arg0: &mut 0x4aa653953d362d75ae1fe9d47b61ce2997ceb6896da9ff0c9f3eb6ca5bc95d0e::locking::LockUpManager, arg1: &mut 0x4aa653953d362d75ae1fe9d47b61ce2997ceb6896da9ff0c9f3eb6ca5bc95d0e::xcetus::XcetusManager, arg2: vector<0x2::coin::Coin<0xcc8aa71adcc99cb87790b6d25383a1ce0da8ac641a57b158748c55f3273350f1::cetus::CETUS>>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x4aa653953d362d75ae1fe9d47b61ce2997ceb6896da9ff0c9f3eb6ca5bc95d0e::locking::mint_and_convert(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun redeem(arg0: &mut 0x4aa653953d362d75ae1fe9d47b61ce2997ceb6896da9ff0c9f3eb6ca5bc95d0e::locking::LockUpManager, arg1: &mut 0x4aa653953d362d75ae1fe9d47b61ce2997ceb6896da9ff0c9f3eb6ca5bc95d0e::xcetus::XcetusManager, arg2: &mut 0x4aa653953d362d75ae1fe9d47b61ce2997ceb6896da9ff0c9f3eb6ca5bc95d0e::xcetus::VeNFT, arg3: 0x4aa653953d362d75ae1fe9d47b61ce2997ceb6896da9ff0c9f3eb6ca5bc95d0e::lock_coin::LockedCoin<0xcc8aa71adcc99cb87790b6d25383a1ce0da8ac641a57b158748c55f3273350f1::cetus::CETUS>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x4aa653953d362d75ae1fe9d47b61ce2997ceb6896da9ff0c9f3eb6ca5bc95d0e::locking::redeem(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun redeem_lock(arg0: &mut 0x4aa653953d362d75ae1fe9d47b61ce2997ceb6896da9ff0c9f3eb6ca5bc95d0e::locking::LockUpManager, arg1: &mut 0x4aa653953d362d75ae1fe9d47b61ce2997ceb6896da9ff0c9f3eb6ca5bc95d0e::xcetus::XcetusManager, arg2: &mut 0x4aa653953d362d75ae1fe9d47b61ce2997ceb6896da9ff0c9f3eb6ca5bc95d0e::xcetus::VeNFT, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x4aa653953d362d75ae1fe9d47b61ce2997ceb6896da9ff0c9f3eb6ca5bc95d0e::locking::redeem_lock(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun burn_venft(arg0: &mut 0x4aa653953d362d75ae1fe9d47b61ce2997ceb6896da9ff0c9f3eb6ca5bc95d0e::xcetus::XcetusManager, arg1: 0x4aa653953d362d75ae1fe9d47b61ce2997ceb6896da9ff0c9f3eb6ca5bc95d0e::xcetus::VeNFT, arg2: &mut 0x2::tx_context::TxContext) {
        0x4aa653953d362d75ae1fe9d47b61ce2997ceb6896da9ff0c9f3eb6ca5bc95d0e::xcetus::burn_venft(arg0, arg1, arg2);
    }

    public entry fun mint_venft(arg0: &mut 0x4aa653953d362d75ae1fe9d47b61ce2997ceb6896da9ff0c9f3eb6ca5bc95d0e::xcetus::XcetusManager, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x4aa653953d362d75ae1fe9d47b61ce2997ceb6896da9ff0c9f3eb6ca5bc95d0e::xcetus::mint_venft(arg0, arg1)
    }

    // decompiled from Move bytecode v6
}

