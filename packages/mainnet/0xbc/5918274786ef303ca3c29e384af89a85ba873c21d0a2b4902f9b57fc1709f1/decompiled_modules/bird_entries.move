module 0xbc5918274786ef303ca3c29e384af89a85ba873c21d0a2b4902f9b57fc1709f1::bird_entries {
    public entry fun claimPreyReward(arg0: &mut 0xbc5918274786ef303ca3c29e384af89a85ba873c21d0a2b4902f9b57fc1709f1::bird::BirdArchieve, arg1: &0x2::clock::Clock, arg2: &0xbc5918274786ef303ca3c29e384af89a85ba873c21d0a2b4902f9b57fc1709f1::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xbc5918274786ef303ca3c29e384af89a85ba873c21d0a2b4902f9b57fc1709f1::bird::claimPreyReward(arg0, arg1, arg2, arg3);
    }

    public entry fun claimReferallReward(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0xbc5918274786ef303ca3c29e384af89a85ba873c21d0a2b4902f9b57fc1709f1::bird::BirdStore, arg3: &mut 0xbc5918274786ef303ca3c29e384af89a85ba873c21d0a2b4902f9b57fc1709f1::bird::BirdArchieve, arg4: &0x2::clock::Clock, arg5: &0xbc5918274786ef303ca3c29e384af89a85ba873c21d0a2b4902f9b57fc1709f1::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0xbc5918274786ef303ca3c29e384af89a85ba873c21d0a2b4902f9b57fc1709f1::bird::claimReferallReward(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun claimReward<T0>(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0xbc5918274786ef303ca3c29e384af89a85ba873c21d0a2b4902f9b57fc1709f1::bird::RewardPool<T0>, arg3: &mut 0xbc5918274786ef303ca3c29e384af89a85ba873c21d0a2b4902f9b57fc1709f1::bird::BirdStore, arg4: &mut 0xbc5918274786ef303ca3c29e384af89a85ba873c21d0a2b4902f9b57fc1709f1::bird::BirdArchieve, arg5: &0xbc5918274786ef303ca3c29e384af89a85ba873c21d0a2b4902f9b57fc1709f1::version::Version, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xbc5918274786ef303ca3c29e384af89a85ba873c21d0a2b4902f9b57fc1709f1::bird::claimReward<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun configRewardPool<T0>(arg0: &0xbc5918274786ef303ca3c29e384af89a85ba873c21d0a2b4902f9b57fc1709f1::bird::AdminCap, arg1: &mut 0xbc5918274786ef303ca3c29e384af89a85ba873c21d0a2b4902f9b57fc1709f1::bird::RewardPool<T0>, arg2: bool, arg3: u64, arg4: &0xbc5918274786ef303ca3c29e384af89a85ba873c21d0a2b4902f9b57fc1709f1::version::Version) {
        0xbc5918274786ef303ca3c29e384af89a85ba873c21d0a2b4902f9b57fc1709f1::bird::configRewardPool<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun createRewardPool<T0>(arg0: &0xbc5918274786ef303ca3c29e384af89a85ba873c21d0a2b4902f9b57fc1709f1::bird::AdminCap, arg1: &0xbc5918274786ef303ca3c29e384af89a85ba873c21d0a2b4902f9b57fc1709f1::version::Version, arg2: &mut 0x2::tx_context::TxContext) {
        0xbc5918274786ef303ca3c29e384af89a85ba873c21d0a2b4902f9b57fc1709f1::bird::createRewardPool<T0>(arg0, arg1, arg2);
    }

    public entry fun depositReward<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0xbc5918274786ef303ca3c29e384af89a85ba873c21d0a2b4902f9b57fc1709f1::bird::RewardPool<T0>, arg2: &0xbc5918274786ef303ca3c29e384af89a85ba873c21d0a2b4902f9b57fc1709f1::version::Version, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xbc5918274786ef303ca3c29e384af89a85ba873c21d0a2b4902f9b57fc1709f1::bird::depositReward<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun emergencyRewardWithdraw<T0>(arg0: &0xbc5918274786ef303ca3c29e384af89a85ba873c21d0a2b4902f9b57fc1709f1::bird::TreasureCap, arg1: &mut 0xbc5918274786ef303ca3c29e384af89a85ba873c21d0a2b4902f9b57fc1709f1::bird::RewardPool<T0>, arg2: &0xbc5918274786ef303ca3c29e384af89a85ba873c21d0a2b4902f9b57fc1709f1::version::Version, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xbc5918274786ef303ca3c29e384af89a85ba873c21d0a2b4902f9b57fc1709f1::bird::emergencyRewardWithdraw<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun infoBirdGhost(arg0: &0xbc5918274786ef303ca3c29e384af89a85ba873c21d0a2b4902f9b57fc1709f1::bird::BirdArchieve) : (address, u64, u128) {
        0xbc5918274786ef303ca3c29e384af89a85ba873c21d0a2b4902f9b57fc1709f1::bird::infoBirdGhost(arg0)
    }

    public entry fun mineBird(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0xbc5918274786ef303ca3c29e384af89a85ba873c21d0a2b4902f9b57fc1709f1::bird::BirdStore, arg3: &mut 0xbc5918274786ef303ca3c29e384af89a85ba873c21d0a2b4902f9b57fc1709f1::bird::BirdArchieve, arg4: &0x2::clock::Clock, arg5: &0xbc5918274786ef303ca3c29e384af89a85ba873c21d0a2b4902f9b57fc1709f1::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0xbc5918274786ef303ca3c29e384af89a85ba873c21d0a2b4902f9b57fc1709f1::bird::mineBird(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun mineNft(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0xbc5918274786ef303ca3c29e384af89a85ba873c21d0a2b4902f9b57fc1709f1::bird::BirdStore, arg3: &mut 0xbc5918274786ef303ca3c29e384af89a85ba873c21d0a2b4902f9b57fc1709f1::bird::BirdArchieve, arg4: &0x2::clock::Clock, arg5: &0xbc5918274786ef303ca3c29e384af89a85ba873c21d0a2b4902f9b57fc1709f1::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0xbc5918274786ef303ca3c29e384af89a85ba873c21d0a2b4902f9b57fc1709f1::bird::mineNft(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun preyBird(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0xbc5918274786ef303ca3c29e384af89a85ba873c21d0a2b4902f9b57fc1709f1::bird::BirdStore, arg3: &mut 0xbc5918274786ef303ca3c29e384af89a85ba873c21d0a2b4902f9b57fc1709f1::bird::BirdArchieve, arg4: &0x2::clock::Clock, arg5: &0xbc5918274786ef303ca3c29e384af89a85ba873c21d0a2b4902f9b57fc1709f1::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0xbc5918274786ef303ca3c29e384af89a85ba873c21d0a2b4902f9b57fc1709f1::bird::preyBird(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun register(arg0: &mut 0xbc5918274786ef303ca3c29e384af89a85ba873c21d0a2b4902f9b57fc1709f1::bird::BirdReg, arg1: &0x2::clock::Clock, arg2: &0xbc5918274786ef303ca3c29e384af89a85ba873c21d0a2b4902f9b57fc1709f1::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xbc5918274786ef303ca3c29e384af89a85ba873c21d0a2b4902f9b57fc1709f1::bird::register(arg0, arg1, arg2, arg3);
    }

    public entry fun sponsor_gas(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: vector<address>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xbc5918274786ef303ca3c29e384af89a85ba873c21d0a2b4902f9b57fc1709f1::bird::sponsor_gas(arg0, arg1, arg2, arg3);
    }

    public entry fun updateValidator(arg0: &0xbc5918274786ef303ca3c29e384af89a85ba873c21d0a2b4902f9b57fc1709f1::bird::AdminCap, arg1: vector<u8>, arg2: &mut 0xbc5918274786ef303ca3c29e384af89a85ba873c21d0a2b4902f9b57fc1709f1::bird::BirdStore, arg3: &mut 0xbc5918274786ef303ca3c29e384af89a85ba873c21d0a2b4902f9b57fc1709f1::version::Version) {
        0xbc5918274786ef303ca3c29e384af89a85ba873c21d0a2b4902f9b57fc1709f1::bird::updateValidator(arg0, arg1, arg2, arg3);
    }

    public entry fun claim_cap<T0: store + key>(arg0: &mut 0xbc5918274786ef303ca3c29e384af89a85ba873c21d0a2b4902f9b57fc1709f1::cap_vault::CapVault<T0>, arg1: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(0xbc5918274786ef303ca3c29e384af89a85ba873c21d0a2b4902f9b57fc1709f1::cap_vault::claim_cap<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun revoke_cap<T0: store + key>(arg0: &mut 0xbc5918274786ef303ca3c29e384af89a85ba873c21d0a2b4902f9b57fc1709f1::cap_vault::CapVault<T0>, arg1: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(0xbc5918274786ef303ca3c29e384af89a85ba873c21d0a2b4902f9b57fc1709f1::cap_vault::revoke_cap<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun transfer_cap<T0: store + key>(arg0: T0, arg1: address, arg2: &mut 0xbc5918274786ef303ca3c29e384af89a85ba873c21d0a2b4902f9b57fc1709f1::cap_vault::CapVault<T0>, arg3: &0x2::tx_context::TxContext) {
        0xbc5918274786ef303ca3c29e384af89a85ba873c21d0a2b4902f9b57fc1709f1::cap_vault::transfer_cap<T0>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

