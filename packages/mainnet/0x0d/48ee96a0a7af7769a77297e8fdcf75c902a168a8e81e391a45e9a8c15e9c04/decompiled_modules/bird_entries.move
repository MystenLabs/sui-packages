module 0xd48ee96a0a7af7769a77297e8fdcf75c902a168a8e81e391a45e9a8c15e9c04::bird_entries {
    public entry fun action(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0xd48ee96a0a7af7769a77297e8fdcf75c902a168a8e81e391a45e9a8c15e9c04::bird::BirdStore, arg3: &mut 0xd48ee96a0a7af7769a77297e8fdcf75c902a168a8e81e391a45e9a8c15e9c04::bird::BirdArchieve, arg4: &0x2::clock::Clock, arg5: &0xd48ee96a0a7af7769a77297e8fdcf75c902a168a8e81e391a45e9a8c15e9c04::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0xd48ee96a0a7af7769a77297e8fdcf75c902a168a8e81e391a45e9a8c15e9c04::bird::action(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun claimReward<T0>(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0xd48ee96a0a7af7769a77297e8fdcf75c902a168a8e81e391a45e9a8c15e9c04::bird::RewardPool<T0>, arg3: &mut 0xd48ee96a0a7af7769a77297e8fdcf75c902a168a8e81e391a45e9a8c15e9c04::bird::BirdStore, arg4: &mut 0xd48ee96a0a7af7769a77297e8fdcf75c902a168a8e81e391a45e9a8c15e9c04::bird::BirdArchieve, arg5: &0xd48ee96a0a7af7769a77297e8fdcf75c902a168a8e81e391a45e9a8c15e9c04::version::Version, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xd48ee96a0a7af7769a77297e8fdcf75c902a168a8e81e391a45e9a8c15e9c04::bird::claimReward<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun claim_admin(arg0: &mut 0xd48ee96a0a7af7769a77297e8fdcf75c902a168a8e81e391a45e9a8c15e9c04::bird::TransporterVault, arg1: &0xd48ee96a0a7af7769a77297e8fdcf75c902a168a8e81e391a45e9a8c15e9c04::version::Version, arg2: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd48ee96a0a7af7769a77297e8fdcf75c902a168a8e81e391a45e9a8c15e9c04::bird::BirdAdminCap>(0xd48ee96a0a7af7769a77297e8fdcf75c902a168a8e81e391a45e9a8c15e9c04::bird::claim_admin(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun claim_treasure(arg0: &mut 0xd48ee96a0a7af7769a77297e8fdcf75c902a168a8e81e391a45e9a8c15e9c04::bird::TransporterVault, arg1: &0xd48ee96a0a7af7769a77297e8fdcf75c902a168a8e81e391a45e9a8c15e9c04::version::Version, arg2: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd48ee96a0a7af7769a77297e8fdcf75c902a168a8e81e391a45e9a8c15e9c04::bird::RewardTreasureCap>(0xd48ee96a0a7af7769a77297e8fdcf75c902a168a8e81e391a45e9a8c15e9c04::bird::claim_treasure(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public fun configRewardPool<T0>(arg0: &0xd48ee96a0a7af7769a77297e8fdcf75c902a168a8e81e391a45e9a8c15e9c04::bird::BirdAdminCap, arg1: &mut 0xd48ee96a0a7af7769a77297e8fdcf75c902a168a8e81e391a45e9a8c15e9c04::bird::RewardPool<T0>, arg2: bool, arg3: u64, arg4: &0xd48ee96a0a7af7769a77297e8fdcf75c902a168a8e81e391a45e9a8c15e9c04::version::Version) {
        0xd48ee96a0a7af7769a77297e8fdcf75c902a168a8e81e391a45e9a8c15e9c04::bird::configRewardPool<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun createRewardPool<T0>(arg0: &0xd48ee96a0a7af7769a77297e8fdcf75c902a168a8e81e391a45e9a8c15e9c04::bird::BirdAdminCap, arg1: &0xd48ee96a0a7af7769a77297e8fdcf75c902a168a8e81e391a45e9a8c15e9c04::version::Version, arg2: &mut 0x2::tx_context::TxContext) {
        0xd48ee96a0a7af7769a77297e8fdcf75c902a168a8e81e391a45e9a8c15e9c04::bird::createRewardPool<T0>(arg0, arg1, arg2);
    }

    public fun depositReward<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0xd48ee96a0a7af7769a77297e8fdcf75c902a168a8e81e391a45e9a8c15e9c04::bird::RewardPool<T0>, arg2: &0xd48ee96a0a7af7769a77297e8fdcf75c902a168a8e81e391a45e9a8c15e9c04::version::Version, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xd48ee96a0a7af7769a77297e8fdcf75c902a168a8e81e391a45e9a8c15e9c04::bird::depositReward<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun emergencyRewardWithdraw<T0>(arg0: &0xd48ee96a0a7af7769a77297e8fdcf75c902a168a8e81e391a45e9a8c15e9c04::bird::RewardTreasureCap, arg1: &mut 0xd48ee96a0a7af7769a77297e8fdcf75c902a168a8e81e391a45e9a8c15e9c04::bird::RewardPool<T0>, arg2: &0xd48ee96a0a7af7769a77297e8fdcf75c902a168a8e81e391a45e9a8c15e9c04::version::Version, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xd48ee96a0a7af7769a77297e8fdcf75c902a168a8e81e391a45e9a8c15e9c04::bird::emergencyRewardWithdraw<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun register(arg0: &mut 0xd48ee96a0a7af7769a77297e8fdcf75c902a168a8e81e391a45e9a8c15e9c04::bird::BirdReg, arg1: &0x2::clock::Clock, arg2: &0xd48ee96a0a7af7769a77297e8fdcf75c902a168a8e81e391a45e9a8c15e9c04::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xd48ee96a0a7af7769a77297e8fdcf75c902a168a8e81e391a45e9a8c15e9c04::bird::register(arg0, arg1, arg2, arg3);
    }

    public entry fun revoke_admin(arg0: &mut 0xd48ee96a0a7af7769a77297e8fdcf75c902a168a8e81e391a45e9a8c15e9c04::bird::TransporterVault, arg1: &0xd48ee96a0a7af7769a77297e8fdcf75c902a168a8e81e391a45e9a8c15e9c04::version::Version, arg2: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd48ee96a0a7af7769a77297e8fdcf75c902a168a8e81e391a45e9a8c15e9c04::bird::BirdAdminCap>(0xd48ee96a0a7af7769a77297e8fdcf75c902a168a8e81e391a45e9a8c15e9c04::bird::revoke_admin(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun revoke_treasure(arg0: &mut 0xd48ee96a0a7af7769a77297e8fdcf75c902a168a8e81e391a45e9a8c15e9c04::bird::TransporterVault, arg1: &0xd48ee96a0a7af7769a77297e8fdcf75c902a168a8e81e391a45e9a8c15e9c04::version::Version, arg2: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd48ee96a0a7af7769a77297e8fdcf75c902a168a8e81e391a45e9a8c15e9c04::bird::RewardTreasureCap>(0xd48ee96a0a7af7769a77297e8fdcf75c902a168a8e81e391a45e9a8c15e9c04::bird::revoke_treasure(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun transfer_admin(arg0: 0xd48ee96a0a7af7769a77297e8fdcf75c902a168a8e81e391a45e9a8c15e9c04::bird::BirdAdminCap, arg1: address, arg2: &mut 0xd48ee96a0a7af7769a77297e8fdcf75c902a168a8e81e391a45e9a8c15e9c04::bird::TransporterVault, arg3: &0xd48ee96a0a7af7769a77297e8fdcf75c902a168a8e81e391a45e9a8c15e9c04::version::Version, arg4: &0x2::tx_context::TxContext) {
        0xd48ee96a0a7af7769a77297e8fdcf75c902a168a8e81e391a45e9a8c15e9c04::bird::transfer_admin(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun transfer_treasure(arg0: 0xd48ee96a0a7af7769a77297e8fdcf75c902a168a8e81e391a45e9a8c15e9c04::bird::RewardTreasureCap, arg1: address, arg2: &mut 0xd48ee96a0a7af7769a77297e8fdcf75c902a168a8e81e391a45e9a8c15e9c04::bird::TransporterVault, arg3: &0xd48ee96a0a7af7769a77297e8fdcf75c902a168a8e81e391a45e9a8c15e9c04::version::Version, arg4: &0x2::tx_context::TxContext) {
        0xd48ee96a0a7af7769a77297e8fdcf75c902a168a8e81e391a45e9a8c15e9c04::bird::transfer_treasure(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun claim_vadmin(arg0: &mut 0xd48ee96a0a7af7769a77297e8fdcf75c902a168a8e81e391a45e9a8c15e9c04::version::VTransporterVault, arg1: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd48ee96a0a7af7769a77297e8fdcf75c902a168a8e81e391a45e9a8c15e9c04::version::VAdminCap>(0xd48ee96a0a7af7769a77297e8fdcf75c902a168a8e81e391a45e9a8c15e9c04::version::claim_admin(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun revoke_vadmin(arg0: &mut 0xd48ee96a0a7af7769a77297e8fdcf75c902a168a8e81e391a45e9a8c15e9c04::version::VTransporterVault, arg1: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd48ee96a0a7af7769a77297e8fdcf75c902a168a8e81e391a45e9a8c15e9c04::version::VAdminCap>(0xd48ee96a0a7af7769a77297e8fdcf75c902a168a8e81e391a45e9a8c15e9c04::version::revoke_admin(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun set_validator(arg0: &0xd48ee96a0a7af7769a77297e8fdcf75c902a168a8e81e391a45e9a8c15e9c04::bird::BirdAdminCap, arg1: vector<u8>, arg2: &mut 0xd48ee96a0a7af7769a77297e8fdcf75c902a168a8e81e391a45e9a8c15e9c04::bird::BirdStore, arg3: &mut 0xd48ee96a0a7af7769a77297e8fdcf75c902a168a8e81e391a45e9a8c15e9c04::version::Version) {
        0xd48ee96a0a7af7769a77297e8fdcf75c902a168a8e81e391a45e9a8c15e9c04::bird::update_validator(arg0, arg1, arg2, arg3);
    }

    public entry fun transfer_vadmin(arg0: 0xd48ee96a0a7af7769a77297e8fdcf75c902a168a8e81e391a45e9a8c15e9c04::version::VAdminCap, arg1: address, arg2: &mut 0xd48ee96a0a7af7769a77297e8fdcf75c902a168a8e81e391a45e9a8c15e9c04::version::VTransporterVault, arg3: &0x2::tx_context::TxContext) {
        0xd48ee96a0a7af7769a77297e8fdcf75c902a168a8e81e391a45e9a8c15e9c04::version::transfer_admin(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

