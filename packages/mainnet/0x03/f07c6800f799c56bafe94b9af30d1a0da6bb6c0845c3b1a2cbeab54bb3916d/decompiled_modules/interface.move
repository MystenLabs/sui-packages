module 0x3f07c6800f799c56bafe94b9af30d1a0da6bb6c0845c3b1a2cbeab54bb3916d::interface {
    public entry fun buy_token(arg0: &mut 0x3f07c6800f799c56bafe94b9af30d1a0da6bb6c0845c3b1a2cbeab54bb3916d::vesting::VestingStorage, arg1: &mut 0x3f07c6800f799c56bafe94b9af30d1a0da6bb6c0845c3b1a2cbeab54bb3916d::vesting::ReferenceStorage, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        0x3f07c6800f799c56bafe94b9af30d1a0da6bb6c0845c3b1a2cbeab54bb3916d::vesting::buy_csc(arg6, arg0, arg1, arg4, arg2, arg3, arg5);
    }

    public entry fun claim_commission(arg0: &mut 0x3f07c6800f799c56bafe94b9af30d1a0da6bb6c0845c3b1a2cbeab54bb3916d::vesting::ReferenceStorage, arg1: &mut 0x2::tx_context::TxContext) {
        0x3f07c6800f799c56bafe94b9af30d1a0da6bb6c0845c3b1a2cbeab54bb3916d::vesting::claim_commission(arg1, arg0);
    }

    public entry fun release(arg0: &mut 0x3f07c6800f799c56bafe94b9af30d1a0da6bb6c0845c3b1a2cbeab54bb3916d::vesting::VestingStorage, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        0x3f07c6800f799c56bafe94b9af30d1a0da6bb6c0845c3b1a2cbeab54bb3916d::vesting::release(arg2, arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

