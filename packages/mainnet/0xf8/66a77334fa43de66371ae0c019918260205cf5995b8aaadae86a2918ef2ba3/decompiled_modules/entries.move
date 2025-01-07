module 0xf866a77334fa43de66371ae0c019918260205cf5995b8aaadae86a2918ef2ba3::entries {
    public entry fun claimPreyReward(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0xf866a77334fa43de66371ae0c019918260205cf5995b8aaadae86a2918ef2ba3::bird::BirdVault, arg3: &mut 0xf44ef9b87dd2bbeff1905dc35f41f607bf43e0811f1753b874a0e0f4c0ec705c::archieve::UserArchieve, arg4: &0xf866a77334fa43de66371ae0c019918260205cf5995b8aaadae86a2918ef2ba3::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xf866a77334fa43de66371ae0c019918260205cf5995b8aaadae86a2918ef2ba3::bird::claimPreyReward(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun feedWorm(arg0: vector<u8>, arg1: vector<u8>, arg2: 0x523e1172f88696b89adba7768fefaaad118ec8b4c41707a04793487e556cbf74::nft::BirdNFT, arg3: &mut 0xf866a77334fa43de66371ae0c019918260205cf5995b8aaadae86a2918ef2ba3::bird::BirdVault, arg4: &mut 0xf44ef9b87dd2bbeff1905dc35f41f607bf43e0811f1753b874a0e0f4c0ec705c::archieve::UserArchieve, arg5: &0xf866a77334fa43de66371ae0c019918260205cf5995b8aaadae86a2918ef2ba3::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0xf866a77334fa43de66371ae0c019918260205cf5995b8aaadae86a2918ef2ba3::bird::feedWorm(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun preyBird(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0xf866a77334fa43de66371ae0c019918260205cf5995b8aaadae86a2918ef2ba3::bird::BirdVault, arg3: &mut 0xf44ef9b87dd2bbeff1905dc35f41f607bf43e0811f1753b874a0e0f4c0ec705c::archieve::UserArchieve, arg4: &0xf866a77334fa43de66371ae0c019918260205cf5995b8aaadae86a2918ef2ba3::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xf866a77334fa43de66371ae0c019918260205cf5995b8aaadae86a2918ef2ba3::bird::preyBird(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun updateValidator(arg0: &0xf866a77334fa43de66371ae0c019918260205cf5995b8aaadae86a2918ef2ba3::bird::AdminCap, arg1: vector<u8>, arg2: &mut 0xf866a77334fa43de66371ae0c019918260205cf5995b8aaadae86a2918ef2ba3::bird::BirdVault, arg3: &0xf866a77334fa43de66371ae0c019918260205cf5995b8aaadae86a2918ef2ba3::version::Version) {
        0xf866a77334fa43de66371ae0c019918260205cf5995b8aaadae86a2918ef2ba3::bird::updateValidator(arg0, arg1, arg2, arg3);
    }

    public entry fun migrateVersion(arg0: &0xf866a77334fa43de66371ae0c019918260205cf5995b8aaadae86a2918ef2ba3::version::VerAdminCap, arg1: &mut 0xf866a77334fa43de66371ae0c019918260205cf5995b8aaadae86a2918ef2ba3::version::Version, arg2: u64) {
        0xf866a77334fa43de66371ae0c019918260205cf5995b8aaadae86a2918ef2ba3::version::migrate(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

