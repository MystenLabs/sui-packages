module 0x2f6793863dd2caa00cc47440e8ded57e3a44138755dfacfe1ff6befd90aeeb21::entries {
    public entry fun claimPreyReward(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x2f6793863dd2caa00cc47440e8ded57e3a44138755dfacfe1ff6befd90aeeb21::bird::BirdVault, arg3: &mut 0x66480b1f97df37924597b20b4906b0bd0010be43e4f1e40738d86067d8cfec9c::archieve::UserArchieve, arg4: &0x2f6793863dd2caa00cc47440e8ded57e3a44138755dfacfe1ff6befd90aeeb21::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x2f6793863dd2caa00cc47440e8ded57e3a44138755dfacfe1ff6befd90aeeb21::bird::claimPreyReward(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun feedWorm(arg0: vector<u8>, arg1: vector<u8>, arg2: 0x3b6db5899ebc9d7f1dfe69e2fee3cab25f4bd129cb38edd47d82931ad5afd6d0::nft::BirdNFT, arg3: &mut 0x2f6793863dd2caa00cc47440e8ded57e3a44138755dfacfe1ff6befd90aeeb21::bird::BirdVault, arg4: &mut 0x66480b1f97df37924597b20b4906b0bd0010be43e4f1e40738d86067d8cfec9c::archieve::UserArchieve, arg5: &0x2f6793863dd2caa00cc47440e8ded57e3a44138755dfacfe1ff6befd90aeeb21::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x2f6793863dd2caa00cc47440e8ded57e3a44138755dfacfe1ff6befd90aeeb21::bird::feedWorm(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun preyBird(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x2f6793863dd2caa00cc47440e8ded57e3a44138755dfacfe1ff6befd90aeeb21::bird::BirdVault, arg3: &mut 0x66480b1f97df37924597b20b4906b0bd0010be43e4f1e40738d86067d8cfec9c::archieve::UserArchieve, arg4: &0x2f6793863dd2caa00cc47440e8ded57e3a44138755dfacfe1ff6befd90aeeb21::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x2f6793863dd2caa00cc47440e8ded57e3a44138755dfacfe1ff6befd90aeeb21::bird::preyBird(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun updateValidator(arg0: &0x2f6793863dd2caa00cc47440e8ded57e3a44138755dfacfe1ff6befd90aeeb21::bird::AdminCap, arg1: vector<u8>, arg2: &mut 0x2f6793863dd2caa00cc47440e8ded57e3a44138755dfacfe1ff6befd90aeeb21::bird::BirdVault, arg3: &0x2f6793863dd2caa00cc47440e8ded57e3a44138755dfacfe1ff6befd90aeeb21::version::Version) {
        0x2f6793863dd2caa00cc47440e8ded57e3a44138755dfacfe1ff6befd90aeeb21::bird::updateValidator(arg0, arg1, arg2, arg3);
    }

    public entry fun migrateVersion(arg0: &0x2f6793863dd2caa00cc47440e8ded57e3a44138755dfacfe1ff6befd90aeeb21::version::VerAdminCap, arg1: &mut 0x2f6793863dd2caa00cc47440e8ded57e3a44138755dfacfe1ff6befd90aeeb21::version::Version, arg2: u64) {
        0x2f6793863dd2caa00cc47440e8ded57e3a44138755dfacfe1ff6befd90aeeb21::version::migrate(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

