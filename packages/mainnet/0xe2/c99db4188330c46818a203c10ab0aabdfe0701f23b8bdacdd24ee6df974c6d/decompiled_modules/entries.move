module 0xe2c99db4188330c46818a203c10ab0aabdfe0701f23b8bdacdd24ee6df974c6d::entries {
    public entry fun claimPreyReward(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0xe2c99db4188330c46818a203c10ab0aabdfe0701f23b8bdacdd24ee6df974c6d::bird::BirdVault, arg3: &mut 0x38dba0f0cf9a80c9b9debf580c82f89bb0de4577e6fb448b3ba2ee9e05d539bc::archieve::UserArchieve, arg4: &0xe2c99db4188330c46818a203c10ab0aabdfe0701f23b8bdacdd24ee6df974c6d::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xe2c99db4188330c46818a203c10ab0aabdfe0701f23b8bdacdd24ee6df974c6d::bird::claimPreyReward(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun feedWorm(arg0: vector<u8>, arg1: vector<u8>, arg2: 0x356d0c33487d727fa31198d1ac9e082a5b57a89c6b56dd37fdf9d54db9d9f98d::nft::BirdNFT, arg3: &mut 0xe2c99db4188330c46818a203c10ab0aabdfe0701f23b8bdacdd24ee6df974c6d::bird::BirdVault, arg4: &mut 0x38dba0f0cf9a80c9b9debf580c82f89bb0de4577e6fb448b3ba2ee9e05d539bc::archieve::UserArchieve, arg5: &0xe2c99db4188330c46818a203c10ab0aabdfe0701f23b8bdacdd24ee6df974c6d::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0xe2c99db4188330c46818a203c10ab0aabdfe0701f23b8bdacdd24ee6df974c6d::bird::feedWorm(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun preyBird(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0xe2c99db4188330c46818a203c10ab0aabdfe0701f23b8bdacdd24ee6df974c6d::bird::BirdVault, arg3: &mut 0x38dba0f0cf9a80c9b9debf580c82f89bb0de4577e6fb448b3ba2ee9e05d539bc::archieve::UserArchieve, arg4: &0xe2c99db4188330c46818a203c10ab0aabdfe0701f23b8bdacdd24ee6df974c6d::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xe2c99db4188330c46818a203c10ab0aabdfe0701f23b8bdacdd24ee6df974c6d::bird::preyBird(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun updateValidator(arg0: &0xe2c99db4188330c46818a203c10ab0aabdfe0701f23b8bdacdd24ee6df974c6d::bird::AdminCap, arg1: vector<u8>, arg2: &mut 0xe2c99db4188330c46818a203c10ab0aabdfe0701f23b8bdacdd24ee6df974c6d::bird::BirdVault, arg3: &0xe2c99db4188330c46818a203c10ab0aabdfe0701f23b8bdacdd24ee6df974c6d::version::Version) {
        0xe2c99db4188330c46818a203c10ab0aabdfe0701f23b8bdacdd24ee6df974c6d::bird::updateValidator(arg0, arg1, arg2, arg3);
    }

    public entry fun migrateVersion(arg0: &0xe2c99db4188330c46818a203c10ab0aabdfe0701f23b8bdacdd24ee6df974c6d::version::VerAdminCap, arg1: &mut 0xe2c99db4188330c46818a203c10ab0aabdfe0701f23b8bdacdd24ee6df974c6d::version::Version, arg2: u64) {
        0xe2c99db4188330c46818a203c10ab0aabdfe0701f23b8bdacdd24ee6df974c6d::version::migrate(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

