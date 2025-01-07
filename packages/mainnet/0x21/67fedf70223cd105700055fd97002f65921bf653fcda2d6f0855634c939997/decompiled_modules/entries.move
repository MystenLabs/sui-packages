module 0x144229c18a420c77196e6b768820f34a2caeeb6571d6ccd4e590eae2e268b88c::entries {
    public entry fun claimPreyReward(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x144229c18a420c77196e6b768820f34a2caeeb6571d6ccd4e590eae2e268b88c::bird::BirdVault, arg3: &mut 0x38dba0f0cf9a80c9b9debf580c82f89bb0de4577e6fb448b3ba2ee9e05d539bc::archieve::UserArchieve, arg4: &0x144229c18a420c77196e6b768820f34a2caeeb6571d6ccd4e590eae2e268b88c::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x144229c18a420c77196e6b768820f34a2caeeb6571d6ccd4e590eae2e268b88c::bird::claimPreyReward(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun claimPreyReward2(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x144229c18a420c77196e6b768820f34a2caeeb6571d6ccd4e590eae2e268b88c::bird::BirdVault, arg3: &mut 0x38dba0f0cf9a80c9b9debf580c82f89bb0de4577e6fb448b3ba2ee9e05d539bc::archieve::Archieve<0x144229c18a420c77196e6b768820f34a2caeeb6571d6ccd4e590eae2e268b88c::bird::BIRD>, arg4: &0x144229c18a420c77196e6b768820f34a2caeeb6571d6ccd4e590eae2e268b88c::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x144229c18a420c77196e6b768820f34a2caeeb6571d6ccd4e590eae2e268b88c::bird::claimPreyReward2(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun feedWorm(arg0: vector<u8>, arg1: vector<u8>, arg2: 0x356d0c33487d727fa31198d1ac9e082a5b57a89c6b56dd37fdf9d54db9d9f98d::nft::BirdNFT, arg3: &mut 0x144229c18a420c77196e6b768820f34a2caeeb6571d6ccd4e590eae2e268b88c::bird::BirdVault, arg4: &mut 0x38dba0f0cf9a80c9b9debf580c82f89bb0de4577e6fb448b3ba2ee9e05d539bc::archieve::UserArchieve, arg5: &0x144229c18a420c77196e6b768820f34a2caeeb6571d6ccd4e590eae2e268b88c::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x144229c18a420c77196e6b768820f34a2caeeb6571d6ccd4e590eae2e268b88c::bird::feedWorm(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun feedWorm2(arg0: vector<u8>, arg1: vector<u8>, arg2: 0x356d0c33487d727fa31198d1ac9e082a5b57a89c6b56dd37fdf9d54db9d9f98d::nft::BirdNFT, arg3: &mut 0x144229c18a420c77196e6b768820f34a2caeeb6571d6ccd4e590eae2e268b88c::bird::BirdVault, arg4: &mut 0x38dba0f0cf9a80c9b9debf580c82f89bb0de4577e6fb448b3ba2ee9e05d539bc::archieve::Archieve<0x144229c18a420c77196e6b768820f34a2caeeb6571d6ccd4e590eae2e268b88c::bird::BIRD>, arg5: &0x144229c18a420c77196e6b768820f34a2caeeb6571d6ccd4e590eae2e268b88c::version::Version, arg6: &0x38dba0f0cf9a80c9b9debf580c82f89bb0de4577e6fb448b3ba2ee9e05d539bc::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0x144229c18a420c77196e6b768820f34a2caeeb6571d6ccd4e590eae2e268b88c::bird::feedWorm2(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun preyBird(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x144229c18a420c77196e6b768820f34a2caeeb6571d6ccd4e590eae2e268b88c::bird::BirdVault, arg3: &mut 0x38dba0f0cf9a80c9b9debf580c82f89bb0de4577e6fb448b3ba2ee9e05d539bc::archieve::UserArchieve, arg4: &0x144229c18a420c77196e6b768820f34a2caeeb6571d6ccd4e590eae2e268b88c::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x144229c18a420c77196e6b768820f34a2caeeb6571d6ccd4e590eae2e268b88c::bird::preyBird(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun preyBird2(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x144229c18a420c77196e6b768820f34a2caeeb6571d6ccd4e590eae2e268b88c::bird::BirdVault, arg3: &mut 0x38dba0f0cf9a80c9b9debf580c82f89bb0de4577e6fb448b3ba2ee9e05d539bc::archieve::Archieve<0x144229c18a420c77196e6b768820f34a2caeeb6571d6ccd4e590eae2e268b88c::bird::BIRD>, arg4: &0x144229c18a420c77196e6b768820f34a2caeeb6571d6ccd4e590eae2e268b88c::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x144229c18a420c77196e6b768820f34a2caeeb6571d6ccd4e590eae2e268b88c::bird::preyBird2(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun updateValidator(arg0: &0x144229c18a420c77196e6b768820f34a2caeeb6571d6ccd4e590eae2e268b88c::bird::AdminCap, arg1: vector<u8>, arg2: &mut 0x144229c18a420c77196e6b768820f34a2caeeb6571d6ccd4e590eae2e268b88c::bird::BirdVault, arg3: &0x144229c18a420c77196e6b768820f34a2caeeb6571d6ccd4e590eae2e268b88c::version::Version) {
        0x144229c18a420c77196e6b768820f34a2caeeb6571d6ccd4e590eae2e268b88c::bird::updateValidator(arg0, arg1, arg2, arg3);
    }

    public entry fun updateValidator2(arg0: &0x144229c18a420c77196e6b768820f34a2caeeb6571d6ccd4e590eae2e268b88c::bird::AdminCap, arg1: vector<u8>, arg2: &mut 0x144229c18a420c77196e6b768820f34a2caeeb6571d6ccd4e590eae2e268b88c::bird::BirdVault, arg3: &0x144229c18a420c77196e6b768820f34a2caeeb6571d6ccd4e590eae2e268b88c::version::Version) {
        0x144229c18a420c77196e6b768820f34a2caeeb6571d6ccd4e590eae2e268b88c::bird::updateValidator2(arg0, arg1, arg2, arg3);
    }

    public entry fun migrateVersion(arg0: &0x144229c18a420c77196e6b768820f34a2caeeb6571d6ccd4e590eae2e268b88c::version::VerAdminCap, arg1: &mut 0x144229c18a420c77196e6b768820f34a2caeeb6571d6ccd4e590eae2e268b88c::version::Version, arg2: u64) {
        0x144229c18a420c77196e6b768820f34a2caeeb6571d6ccd4e590eae2e268b88c::version::migrate(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

