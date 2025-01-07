module 0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::bird_entries {
    public entry fun catchWorm(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::bird::BirdStore, arg3: &mut 0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::bird::BirdArchieve, arg4: &0x2::clock::Clock, arg5: &0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::bird::catchWorm(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun claimPreyReward(arg0: &mut 0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::bird::BirdArchieve, arg1: &0x2::clock::Clock, arg2: &0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::bird::claimPreyReward(arg0, arg1, arg2, arg3);
    }

    public entry fun claimPreyRewardV2(arg0: &mut 0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::bird::BirdArchieve, arg1: &0x2::clock::Clock, arg2: &0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::bird::claimPreyRewardV2(arg0, arg1, arg2, arg3);
    }

    public entry fun claimReferallReward(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::bird::BirdStore, arg3: &mut 0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::bird::BirdArchieve, arg4: &0x2::clock::Clock, arg5: &0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::bird::claimReferallReward(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun claimReward<T0>(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::bird::RewardPool<T0>, arg3: &mut 0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::bird::BirdStore, arg4: &mut 0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::bird::BirdArchieve, arg5: &0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::version::Version, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::bird::claimReward<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun configRewardPool<T0>(arg0: &0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::bird::AdminCap, arg1: &mut 0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::bird::RewardPool<T0>, arg2: bool, arg3: u64, arg4: &0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::version::Version) {
        0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::bird::configRewardPool<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun createRewardPool<T0>(arg0: &0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::bird::AdminCap, arg1: &0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::version::Version, arg2: &mut 0x2::tx_context::TxContext) {
        0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::bird::createRewardPool<T0>(arg0, arg1, arg2);
    }

    public entry fun deposit<T0>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::bird::deposit<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun depositReward<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::bird::RewardPool<T0>, arg2: &0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::version::Version, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::bird::depositReward<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun emergencyRewardWithdraw<T0>(arg0: &0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::bird::TreasureCap, arg1: &mut 0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::bird::RewardPool<T0>, arg2: &0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::version::Version, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::bird::emergencyRewardWithdraw<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun feedWorm(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::bird::BirdStore, arg3: &mut 0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::bird::BirdArchieve, arg4: &0x2::clock::Clock, arg5: &0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::bird::feedWorm(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun feedWormV2(arg0: vector<u8>, arg1: vector<u8>, arg2: 0x3b30888198bdd9a30c723533c0af82647931f852d393d627a961dbb55aa95b40::nft::BirdNFT, arg3: &mut 0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::bird::BirdStore, arg4: &mut 0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::bird::BirdArchieve, arg5: &0x2::clock::Clock, arg6: &0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::bird::feedWormV2(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun infoBirdGhost(arg0: &0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::bird::BirdArchieve) : (address, u64, u128) {
        0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::bird::infoBirdGhost(arg0)
    }

    public entry fun mineBird(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::bird::BirdStore, arg3: &mut 0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::bird::BirdArchieve, arg4: &0x2::clock::Clock, arg5: &0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::bird::mineBird(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun preyBird(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::bird::BirdStore, arg3: &mut 0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::bird::BirdArchieve, arg4: &0x2::clock::Clock, arg5: &0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::bird::preyBird(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun register(arg0: &mut 0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::bird::BirdReg, arg1: &0x2::clock::Clock, arg2: &0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::bird::register(arg0, arg1, arg2, arg3);
    }

    public entry fun skip(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::bird::BirdStore, arg3: &mut 0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::bird::BirdArchieve, arg4: &0x2::clock::Clock, arg5: &0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::bird::skip(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun sponsor_gas(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: vector<address>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::bird::sponsor_gas(arg0, arg1, arg2, arg3);
    }

    public entry fun updateValidator(arg0: &0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::bird::AdminCap, arg1: vector<u8>, arg2: &mut 0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::bird::BirdStore, arg3: &mut 0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::version::Version) {
        0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::bird::updateValidator(arg0, arg1, arg2, arg3);
    }

    public entry fun upgrade(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::bird::BirdStore, arg3: &mut 0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::bird::BirdArchieve, arg4: &0x2::clock::Clock, arg5: &0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::bird::upgrade(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun claim_cap<T0: store + key>(arg0: &mut 0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::cap_vault::CapVault<T0>, arg1: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::cap_vault::claim_cap<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun preyBirdV2(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::bird::BirdStore, arg3: &mut 0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::bird::BirdArchieve, arg4: &0x2::clock::Clock, arg5: &0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::bird::preyBirdV3(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun revoke_cap<T0: store + key>(arg0: &mut 0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::cap_vault::CapVault<T0>, arg1: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::cap_vault::revoke_cap<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun transfer_cap<T0: store + key>(arg0: T0, arg1: address, arg2: &mut 0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::cap_vault::CapVault<T0>, arg3: &0x2::tx_context::TxContext) {
        0x59f4fd9b3928b8358ce60335d15b6b6848f094d0deb64238b0535a99e4e13e4a::cap_vault::transfer_cap<T0>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

