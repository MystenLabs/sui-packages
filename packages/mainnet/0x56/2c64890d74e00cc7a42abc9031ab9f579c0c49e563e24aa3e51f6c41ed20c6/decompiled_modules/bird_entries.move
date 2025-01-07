module 0x562c64890d74e00cc7a42abc9031ab9f579c0c49e563e24aa3e51f6c41ed20c6::bird_entries {
    public entry fun action(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x562c64890d74e00cc7a42abc9031ab9f579c0c49e563e24aa3e51f6c41ed20c6::bird::BirdStore, arg3: &mut 0x562c64890d74e00cc7a42abc9031ab9f579c0c49e563e24aa3e51f6c41ed20c6::bird::BirdArchieve, arg4: &0x2::clock::Clock, arg5: &mut 0x562c64890d74e00cc7a42abc9031ab9f579c0c49e563e24aa3e51f6c41ed20c6::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x562c64890d74e00cc7a42abc9031ab9f579c0c49e563e24aa3e51f6c41ed20c6::bird::action(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun claimReward<T0>(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x562c64890d74e00cc7a42abc9031ab9f579c0c49e563e24aa3e51f6c41ed20c6::bird::RewardPool<T0>, arg3: &mut 0x562c64890d74e00cc7a42abc9031ab9f579c0c49e563e24aa3e51f6c41ed20c6::bird::BirdStore, arg4: &mut 0x562c64890d74e00cc7a42abc9031ab9f579c0c49e563e24aa3e51f6c41ed20c6::bird::BirdArchieve, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x562c64890d74e00cc7a42abc9031ab9f579c0c49e563e24aa3e51f6c41ed20c6::bird::claimReward<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun claim_admin(arg0: &mut 0x562c64890d74e00cc7a42abc9031ab9f579c0c49e563e24aa3e51f6c41ed20c6::version::Version, arg1: &mut 0x562c64890d74e00cc7a42abc9031ab9f579c0c49e563e24aa3e51f6c41ed20c6::bird::TransporterVault, arg2: &0x2::tx_context::TxContext) {
        0x562c64890d74e00cc7a42abc9031ab9f579c0c49e563e24aa3e51f6c41ed20c6::bird::claim_admin(arg0, arg1, arg2);
    }

    fun claim_treasure(arg0: &mut 0x562c64890d74e00cc7a42abc9031ab9f579c0c49e563e24aa3e51f6c41ed20c6::version::Version, arg1: &mut 0x562c64890d74e00cc7a42abc9031ab9f579c0c49e563e24aa3e51f6c41ed20c6::bird::TransporterVault, arg2: &0x2::tx_context::TxContext) {
        0x562c64890d74e00cc7a42abc9031ab9f579c0c49e563e24aa3e51f6c41ed20c6::bird::claim_treasure(arg0, arg1, arg2);
    }

    public fun configRewardPool<T0>(arg0: &0x562c64890d74e00cc7a42abc9031ab9f579c0c49e563e24aa3e51f6c41ed20c6::bird::BirdAdminCap, arg1: &mut 0x562c64890d74e00cc7a42abc9031ab9f579c0c49e563e24aa3e51f6c41ed20c6::bird::RewardPool<T0>, arg2: bool, arg3: u64) {
        0x562c64890d74e00cc7a42abc9031ab9f579c0c49e563e24aa3e51f6c41ed20c6::bird::configRewardPool<T0>(arg0, arg1, arg2, arg3);
    }

    public entry fun createRewardPool<T0>(arg0: &0x562c64890d74e00cc7a42abc9031ab9f579c0c49e563e24aa3e51f6c41ed20c6::bird::BirdAdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        0x562c64890d74e00cc7a42abc9031ab9f579c0c49e563e24aa3e51f6c41ed20c6::bird::createRewardPool<T0>(arg0, arg1);
    }

    public fun depositReward<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x562c64890d74e00cc7a42abc9031ab9f579c0c49e563e24aa3e51f6c41ed20c6::bird::RewardPool<T0>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0x562c64890d74e00cc7a42abc9031ab9f579c0c49e563e24aa3e51f6c41ed20c6::bird::depositReward<T0>(arg0, arg1, arg2, arg3);
    }

    public fun emergencyRewardWithdraw<T0>(arg0: &0x562c64890d74e00cc7a42abc9031ab9f579c0c49e563e24aa3e51f6c41ed20c6::bird::RewardTreasureCap, arg1: &mut 0x562c64890d74e00cc7a42abc9031ab9f579c0c49e563e24aa3e51f6c41ed20c6::bird::RewardPool<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x562c64890d74e00cc7a42abc9031ab9f579c0c49e563e24aa3e51f6c41ed20c6::bird::emergencyRewardWithdraw<T0>(arg0, arg1, arg2, arg3);
    }

    public entry fun register(arg0: &mut 0x562c64890d74e00cc7a42abc9031ab9f579c0c49e563e24aa3e51f6c41ed20c6::bird::BirdReg, arg1: &0x2::clock::Clock, arg2: &mut 0x562c64890d74e00cc7a42abc9031ab9f579c0c49e563e24aa3e51f6c41ed20c6::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x562c64890d74e00cc7a42abc9031ab9f579c0c49e563e24aa3e51f6c41ed20c6::bird::register(arg0, arg1, arg2, arg3);
    }

    public entry fun revoke_admin(arg0: &mut 0x562c64890d74e00cc7a42abc9031ab9f579c0c49e563e24aa3e51f6c41ed20c6::version::Version, arg1: &mut 0x562c64890d74e00cc7a42abc9031ab9f579c0c49e563e24aa3e51f6c41ed20c6::bird::TransporterVault, arg2: &0x2::tx_context::TxContext) {
        0x562c64890d74e00cc7a42abc9031ab9f579c0c49e563e24aa3e51f6c41ed20c6::bird::revoke_admin(arg0, arg1, arg2);
    }

    public entry fun revoke_treasure(arg0: &mut 0x562c64890d74e00cc7a42abc9031ab9f579c0c49e563e24aa3e51f6c41ed20c6::version::Version, arg1: &mut 0x562c64890d74e00cc7a42abc9031ab9f579c0c49e563e24aa3e51f6c41ed20c6::bird::TransporterVault, arg2: &0x2::tx_context::TxContext) {
        0x562c64890d74e00cc7a42abc9031ab9f579c0c49e563e24aa3e51f6c41ed20c6::bird::revoke_treasure(arg0, arg1, arg2);
    }

    public entry fun transfer_admin(arg0: 0x562c64890d74e00cc7a42abc9031ab9f579c0c49e563e24aa3e51f6c41ed20c6::bird::BirdAdminCap, arg1: address, arg2: &mut 0x562c64890d74e00cc7a42abc9031ab9f579c0c49e563e24aa3e51f6c41ed20c6::version::Version, arg3: &mut 0x562c64890d74e00cc7a42abc9031ab9f579c0c49e563e24aa3e51f6c41ed20c6::bird::TransporterVault, arg4: &0x2::tx_context::TxContext) {
        0x562c64890d74e00cc7a42abc9031ab9f579c0c49e563e24aa3e51f6c41ed20c6::bird::transfer_admin(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun transfer_treasure(arg0: 0x562c64890d74e00cc7a42abc9031ab9f579c0c49e563e24aa3e51f6c41ed20c6::bird::RewardTreasureCap, arg1: address, arg2: &mut 0x562c64890d74e00cc7a42abc9031ab9f579c0c49e563e24aa3e51f6c41ed20c6::version::Version, arg3: &mut 0x562c64890d74e00cc7a42abc9031ab9f579c0c49e563e24aa3e51f6c41ed20c6::bird::TransporterVault, arg4: &0x2::tx_context::TxContext) {
        0x562c64890d74e00cc7a42abc9031ab9f579c0c49e563e24aa3e51f6c41ed20c6::bird::transfer_treasure(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun set_validator(arg0: &0x562c64890d74e00cc7a42abc9031ab9f579c0c49e563e24aa3e51f6c41ed20c6::bird::BirdAdminCap, arg1: vector<u8>, arg2: &mut 0x562c64890d74e00cc7a42abc9031ab9f579c0c49e563e24aa3e51f6c41ed20c6::bird::BirdStore, arg3: &mut 0x562c64890d74e00cc7a42abc9031ab9f579c0c49e563e24aa3e51f6c41ed20c6::version::Version) {
        0x562c64890d74e00cc7a42abc9031ab9f579c0c49e563e24aa3e51f6c41ed20c6::bird::update_validator(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

