module 0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::bird_entries {
    public entry fun claimPreyReward(arg0: &mut 0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::bird::NFTGhost, arg1: &mut 0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::bird::BirdArchieve, arg2: &0x2::clock::Clock, arg3: &0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::bird::claimPreyReward(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun claimReferallReward(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::bird::BirdStore, arg3: &mut 0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::bird::BirdArchieve, arg4: &0x2::clock::Clock, arg5: &0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::bird::claimReferallReward(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun claimReward<T0>(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::bird::RewardPool<T0>, arg3: &mut 0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::bird::BirdStore, arg4: &mut 0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::bird::BirdArchieve, arg5: &0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::version::Version, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::bird::claimReward<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun configRewardPool<T0>(arg0: &0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::bird::AdminCap, arg1: &mut 0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::bird::RewardPool<T0>, arg2: bool, arg3: u64, arg4: &0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::version::Version) {
        0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::bird::configRewardPool<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun createRewardPool<T0>(arg0: &0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::bird::AdminCap, arg1: &0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::version::Version, arg2: &mut 0x2::tx_context::TxContext) {
        0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::bird::createRewardPool<T0>(arg0, arg1, arg2);
    }

    public entry fun depositReward<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::bird::RewardPool<T0>, arg2: &0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::version::Version, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::bird::depositReward<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun emergencyRewardWithdraw<T0>(arg0: &0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::bird::TreasureCap, arg1: &mut 0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::bird::RewardPool<T0>, arg2: &0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::version::Version, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::bird::emergencyRewardWithdraw<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun feedBird(arg0: 0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::bird::NFTGhost, arg1: &mut 0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::bird::NFTGhost, arg2: &0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::version::Version, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::bird::feedBird(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun infoBirdGhost(arg0: &0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::bird::BirdArchieve) : (address, u64, u128) {
        0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::bird::infoBirdGhost(arg0)
    }

    public entry fun infoNftGhost(arg0: &0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::bird::NFTGhost) : (u8, vector<u8>, u64, u8, u64) {
        0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::bird::infoNftGhost(arg0)
    }

    public entry fun mineBird(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::bird::BirdStore, arg3: &mut 0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::bird::BirdArchieve, arg4: &0x2::clock::Clock, arg5: &0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::bird::mineBird(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun mineNft(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::bird::BirdStore, arg3: &mut 0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::bird::BirdArchieve, arg4: &0x2::clock::Clock, arg5: &0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::bird::mineNft(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun preyBird(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::bird::NFTGhost, arg3: &mut 0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::bird::BirdStore, arg4: &mut 0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::bird::BirdArchieve, arg5: &0x2::clock::Clock, arg6: &0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::bird::preyBird(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun register(arg0: &mut 0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::bird::BirdReg, arg1: &0x2::clock::Clock, arg2: &0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::bird::register(arg0, arg1, arg2, arg3);
    }

    public entry fun sponsor_gas(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: vector<address>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::bird::sponsor_gas(arg0, arg1, arg2, arg3);
    }

    public entry fun updateValidator(arg0: &0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::bird::AdminCap, arg1: vector<u8>, arg2: &mut 0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::bird::BirdStore, arg3: &mut 0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::version::Version) {
        0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::bird::updateValidator(arg0, arg1, arg2, arg3);
    }

    public entry fun claim_cap<T0: store + key>(arg0: &mut 0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::cap_vault::CapVault<T0>, arg1: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::cap_vault::claim_cap<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun revoke_cap<T0: store + key>(arg0: &mut 0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::cap_vault::CapVault<T0>, arg1: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::cap_vault::revoke_cap<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun transfer_cap<T0: store + key>(arg0: T0, arg1: address, arg2: &mut 0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::cap_vault::CapVault<T0>, arg3: &0x2::tx_context::TxContext) {
        0xc3167713d7150e5bde9f10e9d128e4326f772b8f7c540b5e3d2db15cf9cb910e::cap_vault::transfer_cap<T0>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

