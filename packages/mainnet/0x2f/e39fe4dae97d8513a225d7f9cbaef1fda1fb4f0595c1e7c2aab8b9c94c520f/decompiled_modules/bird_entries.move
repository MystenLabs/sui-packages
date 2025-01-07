module 0x2fe39fe4dae97d8513a225d7f9cbaef1fda1fb4f0595c1e7c2aab8b9c94c520f::bird_entries {
    public entry fun action(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x2fe39fe4dae97d8513a225d7f9cbaef1fda1fb4f0595c1e7c2aab8b9c94c520f::bird::BirdStore, arg3: &mut 0x2fe39fe4dae97d8513a225d7f9cbaef1fda1fb4f0595c1e7c2aab8b9c94c520f::bird::BirdArchieve, arg4: &0x2::clock::Clock, arg5: &0x2fe39fe4dae97d8513a225d7f9cbaef1fda1fb4f0595c1e7c2aab8b9c94c520f::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x2fe39fe4dae97d8513a225d7f9cbaef1fda1fb4f0595c1e7c2aab8b9c94c520f::bird::action(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun claimReward<T0>(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x2fe39fe4dae97d8513a225d7f9cbaef1fda1fb4f0595c1e7c2aab8b9c94c520f::bird::RewardPool<T0>, arg3: &mut 0x2fe39fe4dae97d8513a225d7f9cbaef1fda1fb4f0595c1e7c2aab8b9c94c520f::bird::BirdStore, arg4: &mut 0x2fe39fe4dae97d8513a225d7f9cbaef1fda1fb4f0595c1e7c2aab8b9c94c520f::bird::BirdArchieve, arg5: &0x2fe39fe4dae97d8513a225d7f9cbaef1fda1fb4f0595c1e7c2aab8b9c94c520f::version::Version, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x2fe39fe4dae97d8513a225d7f9cbaef1fda1fb4f0595c1e7c2aab8b9c94c520f::bird::claimReward<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun claim_admin(arg0: &mut 0x2fe39fe4dae97d8513a225d7f9cbaef1fda1fb4f0595c1e7c2aab8b9c94c520f::bird::TransporterVault, arg1: &0x2fe39fe4dae97d8513a225d7f9cbaef1fda1fb4f0595c1e7c2aab8b9c94c520f::version::Version, arg2: &0x2::tx_context::TxContext) {
        0x2fe39fe4dae97d8513a225d7f9cbaef1fda1fb4f0595c1e7c2aab8b9c94c520f::bird::claim_admin(arg0, arg1, arg2);
    }

    fun claim_treasure(arg0: &mut 0x2fe39fe4dae97d8513a225d7f9cbaef1fda1fb4f0595c1e7c2aab8b9c94c520f::bird::TransporterVault, arg1: &0x2fe39fe4dae97d8513a225d7f9cbaef1fda1fb4f0595c1e7c2aab8b9c94c520f::version::Version, arg2: &0x2::tx_context::TxContext) {
        0x2fe39fe4dae97d8513a225d7f9cbaef1fda1fb4f0595c1e7c2aab8b9c94c520f::bird::claim_treasure(arg0, arg1, arg2);
    }

    public fun configRewardPool<T0>(arg0: &0x2fe39fe4dae97d8513a225d7f9cbaef1fda1fb4f0595c1e7c2aab8b9c94c520f::bird::BirdAdminCap, arg1: &mut 0x2fe39fe4dae97d8513a225d7f9cbaef1fda1fb4f0595c1e7c2aab8b9c94c520f::bird::RewardPool<T0>, arg2: bool, arg3: u64, arg4: &0x2fe39fe4dae97d8513a225d7f9cbaef1fda1fb4f0595c1e7c2aab8b9c94c520f::version::Version) {
        0x2fe39fe4dae97d8513a225d7f9cbaef1fda1fb4f0595c1e7c2aab8b9c94c520f::bird::configRewardPool<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun createRewardPool<T0>(arg0: &0x2fe39fe4dae97d8513a225d7f9cbaef1fda1fb4f0595c1e7c2aab8b9c94c520f::bird::BirdAdminCap, arg1: &0x2fe39fe4dae97d8513a225d7f9cbaef1fda1fb4f0595c1e7c2aab8b9c94c520f::version::Version, arg2: &mut 0x2::tx_context::TxContext) {
        0x2fe39fe4dae97d8513a225d7f9cbaef1fda1fb4f0595c1e7c2aab8b9c94c520f::bird::createRewardPool<T0>(arg0, arg1, arg2);
    }

    public fun depositReward<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2fe39fe4dae97d8513a225d7f9cbaef1fda1fb4f0595c1e7c2aab8b9c94c520f::bird::RewardPool<T0>, arg2: &0x2fe39fe4dae97d8513a225d7f9cbaef1fda1fb4f0595c1e7c2aab8b9c94c520f::version::Version, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x2fe39fe4dae97d8513a225d7f9cbaef1fda1fb4f0595c1e7c2aab8b9c94c520f::bird::depositReward<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun emergencyRewardWithdraw<T0>(arg0: &0x2fe39fe4dae97d8513a225d7f9cbaef1fda1fb4f0595c1e7c2aab8b9c94c520f::bird::RewardTreasureCap, arg1: &mut 0x2fe39fe4dae97d8513a225d7f9cbaef1fda1fb4f0595c1e7c2aab8b9c94c520f::bird::RewardPool<T0>, arg2: &0x2fe39fe4dae97d8513a225d7f9cbaef1fda1fb4f0595c1e7c2aab8b9c94c520f::version::Version, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x2fe39fe4dae97d8513a225d7f9cbaef1fda1fb4f0595c1e7c2aab8b9c94c520f::bird::emergencyRewardWithdraw<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun register(arg0: &mut 0x2fe39fe4dae97d8513a225d7f9cbaef1fda1fb4f0595c1e7c2aab8b9c94c520f::bird::BirdReg, arg1: &0x2::clock::Clock, arg2: &0x2fe39fe4dae97d8513a225d7f9cbaef1fda1fb4f0595c1e7c2aab8b9c94c520f::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x2fe39fe4dae97d8513a225d7f9cbaef1fda1fb4f0595c1e7c2aab8b9c94c520f::bird::register(arg0, arg1, arg2, arg3);
    }

    public entry fun revoke_admin(arg0: &mut 0x2fe39fe4dae97d8513a225d7f9cbaef1fda1fb4f0595c1e7c2aab8b9c94c520f::bird::TransporterVault, arg1: &0x2fe39fe4dae97d8513a225d7f9cbaef1fda1fb4f0595c1e7c2aab8b9c94c520f::version::Version, arg2: &0x2::tx_context::TxContext) {
        0x2fe39fe4dae97d8513a225d7f9cbaef1fda1fb4f0595c1e7c2aab8b9c94c520f::bird::revoke_admin(arg0, arg1, arg2);
    }

    public entry fun revoke_treasure(arg0: &mut 0x2fe39fe4dae97d8513a225d7f9cbaef1fda1fb4f0595c1e7c2aab8b9c94c520f::bird::TransporterVault, arg1: &0x2fe39fe4dae97d8513a225d7f9cbaef1fda1fb4f0595c1e7c2aab8b9c94c520f::version::Version, arg2: &0x2::tx_context::TxContext) {
        0x2fe39fe4dae97d8513a225d7f9cbaef1fda1fb4f0595c1e7c2aab8b9c94c520f::bird::revoke_treasure(arg0, arg1, arg2);
    }

    public entry fun transfer_admin(arg0: 0x2fe39fe4dae97d8513a225d7f9cbaef1fda1fb4f0595c1e7c2aab8b9c94c520f::bird::BirdAdminCap, arg1: address, arg2: &mut 0x2fe39fe4dae97d8513a225d7f9cbaef1fda1fb4f0595c1e7c2aab8b9c94c520f::bird::TransporterVault, arg3: &0x2fe39fe4dae97d8513a225d7f9cbaef1fda1fb4f0595c1e7c2aab8b9c94c520f::version::Version, arg4: &0x2::tx_context::TxContext) {
        0x2fe39fe4dae97d8513a225d7f9cbaef1fda1fb4f0595c1e7c2aab8b9c94c520f::bird::transfer_admin(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun transfer_treasure(arg0: 0x2fe39fe4dae97d8513a225d7f9cbaef1fda1fb4f0595c1e7c2aab8b9c94c520f::bird::RewardTreasureCap, arg1: address, arg2: &mut 0x2fe39fe4dae97d8513a225d7f9cbaef1fda1fb4f0595c1e7c2aab8b9c94c520f::bird::TransporterVault, arg3: &0x2fe39fe4dae97d8513a225d7f9cbaef1fda1fb4f0595c1e7c2aab8b9c94c520f::version::Version, arg4: &0x2::tx_context::TxContext) {
        0x2fe39fe4dae97d8513a225d7f9cbaef1fda1fb4f0595c1e7c2aab8b9c94c520f::bird::transfer_treasure(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun set_validator(arg0: &0x2fe39fe4dae97d8513a225d7f9cbaef1fda1fb4f0595c1e7c2aab8b9c94c520f::bird::BirdAdminCap, arg1: vector<u8>, arg2: &mut 0x2fe39fe4dae97d8513a225d7f9cbaef1fda1fb4f0595c1e7c2aab8b9c94c520f::bird::BirdStore, arg3: &mut 0x2fe39fe4dae97d8513a225d7f9cbaef1fda1fb4f0595c1e7c2aab8b9c94c520f::version::Version) {
        0x2fe39fe4dae97d8513a225d7f9cbaef1fda1fb4f0595c1e7c2aab8b9c94c520f::bird::update_validator(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

