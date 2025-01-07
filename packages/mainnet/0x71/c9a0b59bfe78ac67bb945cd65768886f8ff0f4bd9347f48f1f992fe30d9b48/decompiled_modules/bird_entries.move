module 0x71c9a0b59bfe78ac67bb945cd65768886f8ff0f4bd9347f48f1f992fe30d9b48::bird_entries {
    public entry fun claimReward<T0>(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x71c9a0b59bfe78ac67bb945cd65768886f8ff0f4bd9347f48f1f992fe30d9b48::bird::RewardPool<T0>, arg3: &mut 0x71c9a0b59bfe78ac67bb945cd65768886f8ff0f4bd9347f48f1f992fe30d9b48::bird::BirdStore, arg4: &mut 0x71c9a0b59bfe78ac67bb945cd65768886f8ff0f4bd9347f48f1f992fe30d9b48::bird::BirdArchieve, arg5: &0x71c9a0b59bfe78ac67bb945cd65768886f8ff0f4bd9347f48f1f992fe30d9b48::version::Version, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x71c9a0b59bfe78ac67bb945cd65768886f8ff0f4bd9347f48f1f992fe30d9b48::bird::claimReward<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun configRewardPool<T0>(arg0: &0x71c9a0b59bfe78ac67bb945cd65768886f8ff0f4bd9347f48f1f992fe30d9b48::bird::BirdAdminCap, arg1: &mut 0x71c9a0b59bfe78ac67bb945cd65768886f8ff0f4bd9347f48f1f992fe30d9b48::bird::RewardPool<T0>, arg2: bool, arg3: u64, arg4: &0x71c9a0b59bfe78ac67bb945cd65768886f8ff0f4bd9347f48f1f992fe30d9b48::version::Version) {
        0x71c9a0b59bfe78ac67bb945cd65768886f8ff0f4bd9347f48f1f992fe30d9b48::bird::configRewardPool<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun createRewardPool<T0>(arg0: &0x71c9a0b59bfe78ac67bb945cd65768886f8ff0f4bd9347f48f1f992fe30d9b48::bird::BirdAdminCap, arg1: &0x71c9a0b59bfe78ac67bb945cd65768886f8ff0f4bd9347f48f1f992fe30d9b48::version::Version, arg2: &mut 0x2::tx_context::TxContext) {
        0x71c9a0b59bfe78ac67bb945cd65768886f8ff0f4bd9347f48f1f992fe30d9b48::bird::createRewardPool<T0>(arg0, arg1, arg2);
    }

    public entry fun depositReward<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x71c9a0b59bfe78ac67bb945cd65768886f8ff0f4bd9347f48f1f992fe30d9b48::bird::RewardPool<T0>, arg2: &0x71c9a0b59bfe78ac67bb945cd65768886f8ff0f4bd9347f48f1f992fe30d9b48::version::Version, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x71c9a0b59bfe78ac67bb945cd65768886f8ff0f4bd9347f48f1f992fe30d9b48::bird::depositReward<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun emergencyRewardWithdraw<T0>(arg0: &0x71c9a0b59bfe78ac67bb945cd65768886f8ff0f4bd9347f48f1f992fe30d9b48::bird::RewardTreasureCap, arg1: &mut 0x71c9a0b59bfe78ac67bb945cd65768886f8ff0f4bd9347f48f1f992fe30d9b48::bird::RewardPool<T0>, arg2: &0x71c9a0b59bfe78ac67bb945cd65768886f8ff0f4bd9347f48f1f992fe30d9b48::version::Version, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x71c9a0b59bfe78ac67bb945cd65768886f8ff0f4bd9347f48f1f992fe30d9b48::bird::emergencyRewardWithdraw<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun infoBirdGhost(arg0: &0x71c9a0b59bfe78ac67bb945cd65768886f8ff0f4bd9347f48f1f992fe30d9b48::bird::BirdArchieve) : (u64, u64, u64) {
        0x71c9a0b59bfe78ac67bb945cd65768886f8ff0f4bd9347f48f1f992fe30d9b48::bird::infoBirdGhost(arg0)
    }

    public entry fun infoNftGhost(arg0: &0x71c9a0b59bfe78ac67bb945cd65768886f8ff0f4bd9347f48f1f992fe30d9b48::bird::NFTGhost) : (u8, vector<u8>, u64, u8, u64, vector<u8>) {
        0x71c9a0b59bfe78ac67bb945cd65768886f8ff0f4bd9347f48f1f992fe30d9b48::bird::infoNftGhost(arg0)
    }

    public entry fun mineBird(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x71c9a0b59bfe78ac67bb945cd65768886f8ff0f4bd9347f48f1f992fe30d9b48::bird::BirdStore, arg3: &mut 0x71c9a0b59bfe78ac67bb945cd65768886f8ff0f4bd9347f48f1f992fe30d9b48::bird::BirdArchieve, arg4: &0x2::clock::Clock, arg5: &0x71c9a0b59bfe78ac67bb945cd65768886f8ff0f4bd9347f48f1f992fe30d9b48::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x71c9a0b59bfe78ac67bb945cd65768886f8ff0f4bd9347f48f1f992fe30d9b48::bird::mineBird(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun mineNft(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x71c9a0b59bfe78ac67bb945cd65768886f8ff0f4bd9347f48f1f992fe30d9b48::bird::BirdStore, arg3: &mut 0x71c9a0b59bfe78ac67bb945cd65768886f8ff0f4bd9347f48f1f992fe30d9b48::bird::BirdArchieve, arg4: &0x2::clock::Clock, arg5: &0x71c9a0b59bfe78ac67bb945cd65768886f8ff0f4bd9347f48f1f992fe30d9b48::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x71c9a0b59bfe78ac67bb945cd65768886f8ff0f4bd9347f48f1f992fe30d9b48::bird::mineNft(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun register(arg0: &mut 0x71c9a0b59bfe78ac67bb945cd65768886f8ff0f4bd9347f48f1f992fe30d9b48::bird::BirdReg, arg1: &0x2::clock::Clock, arg2: &0x71c9a0b59bfe78ac67bb945cd65768886f8ff0f4bd9347f48f1f992fe30d9b48::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x71c9a0b59bfe78ac67bb945cd65768886f8ff0f4bd9347f48f1f992fe30d9b48::bird::register(arg0, arg1, arg2, arg3);
    }

    public entry fun sponsor_gas(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: vector<address>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x71c9a0b59bfe78ac67bb945cd65768886f8ff0f4bd9347f48f1f992fe30d9b48::bird::sponsor_gas(arg0, arg1, arg2, arg3);
    }

    public entry fun claim_cap<T0: store + key>(arg0: &mut 0x71c9a0b59bfe78ac67bb945cd65768886f8ff0f4bd9347f48f1f992fe30d9b48::cap_vault::CapVault<T0>, arg1: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(0x71c9a0b59bfe78ac67bb945cd65768886f8ff0f4bd9347f48f1f992fe30d9b48::cap_vault::claim_cap<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun revoke_cap<T0: store + key>(arg0: &mut 0x71c9a0b59bfe78ac67bb945cd65768886f8ff0f4bd9347f48f1f992fe30d9b48::cap_vault::CapVault<T0>, arg1: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(0x71c9a0b59bfe78ac67bb945cd65768886f8ff0f4bd9347f48f1f992fe30d9b48::cap_vault::revoke_cap<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun set_validator(arg0: &0x71c9a0b59bfe78ac67bb945cd65768886f8ff0f4bd9347f48f1f992fe30d9b48::bird::BirdAdminCap, arg1: vector<u8>, arg2: &mut 0x71c9a0b59bfe78ac67bb945cd65768886f8ff0f4bd9347f48f1f992fe30d9b48::bird::BirdStore, arg3: &mut 0x71c9a0b59bfe78ac67bb945cd65768886f8ff0f4bd9347f48f1f992fe30d9b48::version::Version) {
        0x71c9a0b59bfe78ac67bb945cd65768886f8ff0f4bd9347f48f1f992fe30d9b48::bird::update_validator(arg0, arg1, arg2, arg3);
    }

    public entry fun transfer_cap<T0: store + key>(arg0: T0, arg1: address, arg2: &mut 0x71c9a0b59bfe78ac67bb945cd65768886f8ff0f4bd9347f48f1f992fe30d9b48::cap_vault::CapVault<T0>, arg3: &0x2::tx_context::TxContext) {
        0x71c9a0b59bfe78ac67bb945cd65768886f8ff0f4bd9347f48f1f992fe30d9b48::cap_vault::transfer_cap<T0>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

