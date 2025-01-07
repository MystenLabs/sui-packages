module 0x9c5b0ad01821f479aa8582d82d50b23a0d580f83ec0541722da8e3f626f946f6::stake_entries2 {
    public entry fun stake<T0, T1>(arg0: &mut 0x9c5b0ad01821f479aa8582d82d50b23a0d580f83ec0541722da8e3f626f946f6::stake::StakePool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x9c5b0ad01821f479aa8582d82d50b23a0d580f83ec0541722da8e3f626f946f6::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x9c5b0ad01821f479aa8582d82d50b23a0d580f83ec0541722da8e3f626f946f6::stake::stake<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun change_admin(arg0: 0x9c5b0ad01821f479aa8582d82d50b23a0d580f83ec0541722da8e3f626f946f6::stake::Admincap, arg1: address, arg2: &mut 0x9c5b0ad01821f479aa8582d82d50b23a0d580f83ec0541722da8e3f626f946f6::version::Version) {
        0x9c5b0ad01821f479aa8582d82d50b23a0d580f83ec0541722da8e3f626f946f6::stake::change_admin(arg0, arg1, arg2);
    }

    public entry fun claimRewards<T0, T1>(arg0: &mut 0x9c5b0ad01821f479aa8582d82d50b23a0d580f83ec0541722da8e3f626f946f6::stake::StakePool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x9c5b0ad01821f479aa8582d82d50b23a0d580f83ec0541722da8e3f626f946f6::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x9c5b0ad01821f479aa8582d82d50b23a0d580f83ec0541722da8e3f626f946f6::stake::claimRewards<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun createPool<T0, T1>(arg0: &0x9c5b0ad01821f479aa8582d82d50b23a0d580f83ec0541722da8e3f626f946f6::stake::Admincap, arg1: u64, arg2: u128, arg3: &mut 0x9c5b0ad01821f479aa8582d82d50b23a0d580f83ec0541722da8e3f626f946f6::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x9c5b0ad01821f479aa8582d82d50b23a0d580f83ec0541722da8e3f626f946f6::stake::createPool<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun depositRewardCoins<T0, T1>(arg0: &0x9c5b0ad01821f479aa8582d82d50b23a0d580f83ec0541722da8e3f626f946f6::stake::Admincap, arg1: &mut 0x9c5b0ad01821f479aa8582d82d50b23a0d580f83ec0541722da8e3f626f946f6::stake::StakePool<T0, T1>, arg2: &mut 0x9c5b0ad01821f479aa8582d82d50b23a0d580f83ec0541722da8e3f626f946f6::version::Version, arg3: 0x2::coin::Coin<T1>) {
        0x9c5b0ad01821f479aa8582d82d50b23a0d580f83ec0541722da8e3f626f946f6::stake::depositRewardCoins<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun migrateNewVersion<T0, T1>(arg0: &mut 0x9c5b0ad01821f479aa8582d82d50b23a0d580f83ec0541722da8e3f626f946f6::stake::StakePool<T0, T1>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x9c5b0ad01821f479aa8582d82d50b23a0d580f83ec0541722da8e3f626f946f6::stake::MigrateInfor, arg4: &mut 0x9c5b0ad01821f479aa8582d82d50b23a0d580f83ec0541722da8e3f626f946f6::version::Version, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x9c5b0ad01821f479aa8582d82d50b23a0d580f83ec0541722da8e3f626f946f6::stake::migrateNewVersion<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun migrateNewVersionV2<T0, T1>(arg0: &mut 0x9c5b0ad01821f479aa8582d82d50b23a0d580f83ec0541722da8e3f626f946f6::stake::StakePool<T0, T1>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x9c5b0ad01821f479aa8582d82d50b23a0d580f83ec0541722da8e3f626f946f6::stake::MigrateInfor, arg4: &mut 0x9c5b0ad01821f479aa8582d82d50b23a0d580f83ec0541722da8e3f626f946f6::version::Version, arg5: u128, arg6: &mut 0x2::tx_context::TxContext) {
        0x9c5b0ad01821f479aa8582d82d50b23a0d580f83ec0541722da8e3f626f946f6::stake::migrateNewVersionV2<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun pause<T0, T1>(arg0: &0x9c5b0ad01821f479aa8582d82d50b23a0d580f83ec0541722da8e3f626f946f6::stake::Admincap, arg1: &mut 0x9c5b0ad01821f479aa8582d82d50b23a0d580f83ec0541722da8e3f626f946f6::stake::StakePool<T0, T1>, arg2: bool) {
        0x9c5b0ad01821f479aa8582d82d50b23a0d580f83ec0541722da8e3f626f946f6::stake::pause<T0, T1>(arg0, arg1, arg2);
    }

    public entry fun set_treasury_admin_address<T0, T1>(arg0: &0x9c5b0ad01821f479aa8582d82d50b23a0d580f83ec0541722da8e3f626f946f6::stake::Admincap, arg1: &mut 0x9c5b0ad01821f479aa8582d82d50b23a0d580f83ec0541722da8e3f626f946f6::stake::MigrateInfor, arg2: address, arg3: &mut 0x9c5b0ad01821f479aa8582d82d50b23a0d580f83ec0541722da8e3f626f946f6::version::Version) {
        0x9c5b0ad01821f479aa8582d82d50b23a0d580f83ec0541722da8e3f626f946f6::stake::set_treasury_admin_address<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun stakeRewards<T0, T1>(arg0: &mut 0x9c5b0ad01821f479aa8582d82d50b23a0d580f83ec0541722da8e3f626f946f6::stake::StakePool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x9c5b0ad01821f479aa8582d82d50b23a0d580f83ec0541722da8e3f626f946f6::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x9c5b0ad01821f479aa8582d82d50b23a0d580f83ec0541722da8e3f626f946f6::stake::stakeRewards<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun start_migrate<T0, T1>(arg0: &0x9c5b0ad01821f479aa8582d82d50b23a0d580f83ec0541722da8e3f626f946f6::stake::Admincap, arg1: &mut 0x9c5b0ad01821f479aa8582d82d50b23a0d580f83ec0541722da8e3f626f946f6::version::Version, arg2: &mut 0x2::tx_context::TxContext) {
        0x9c5b0ad01821f479aa8582d82d50b23a0d580f83ec0541722da8e3f626f946f6::stake::start_migrate<T0, T1>(arg0, arg1, arg2);
    }

    public entry fun stopEmergency<T0, T1>(arg0: &0x9c5b0ad01821f479aa8582d82d50b23a0d580f83ec0541722da8e3f626f946f6::stake::Admincap, arg1: &mut 0x9c5b0ad01821f479aa8582d82d50b23a0d580f83ec0541722da8e3f626f946f6::stake::StakePool<T0, T1>, arg2: vector<address>, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x9c5b0ad01821f479aa8582d82d50b23a0d580f83ec0541722da8e3f626f946f6::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x9c5b0ad01821f479aa8582d82d50b23a0d580f83ec0541722da8e3f626f946f6::stake::stopEmergency<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun unstake<T0, T1>(arg0: &mut 0x9c5b0ad01821f479aa8582d82d50b23a0d580f83ec0541722da8e3f626f946f6::stake::StakePool<T0, T1>, arg1: u128, arg2: &0x2::clock::Clock, arg3: &mut 0x9c5b0ad01821f479aa8582d82d50b23a0d580f83ec0541722da8e3f626f946f6::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x9c5b0ad01821f479aa8582d82d50b23a0d580f83ec0541722da8e3f626f946f6::stake::unstake<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun updateApy<T0, T1>(arg0: &0x9c5b0ad01821f479aa8582d82d50b23a0d580f83ec0541722da8e3f626f946f6::stake::Admincap, arg1: &mut 0x9c5b0ad01821f479aa8582d82d50b23a0d580f83ec0541722da8e3f626f946f6::stake::StakePool<T0, T1>, arg2: vector<address>, arg3: u128, arg4: &mut 0x9c5b0ad01821f479aa8582d82d50b23a0d580f83ec0541722da8e3f626f946f6::version::Version, arg5: &0x2::clock::Clock) {
        0x9c5b0ad01821f479aa8582d82d50b23a0d580f83ec0541722da8e3f626f946f6::stake::updateApy<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun updateApyV2<T0, T1>(arg0: &0x9c5b0ad01821f479aa8582d82d50b23a0d580f83ec0541722da8e3f626f946f6::stake::Admincap, arg1: &mut 0x9c5b0ad01821f479aa8582d82d50b23a0d580f83ec0541722da8e3f626f946f6::stake::StakePool<T0, T1>, arg2: vector<address>, arg3: u128, arg4: u128, arg5: &mut 0x9c5b0ad01821f479aa8582d82d50b23a0d580f83ec0541722da8e3f626f946f6::version::Version, arg6: &0x2::clock::Clock) {
        0x9c5b0ad01821f479aa8582d82d50b23a0d580f83ec0541722da8e3f626f946f6::stake::updateApyV2<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun updateUnlockTime<T0, T1>(arg0: &0x9c5b0ad01821f479aa8582d82d50b23a0d580f83ec0541722da8e3f626f946f6::stake::Admincap, arg1: &mut 0x9c5b0ad01821f479aa8582d82d50b23a0d580f83ec0541722da8e3f626f946f6::stake::StakePool<T0, T1>, arg2: u64, arg3: &mut 0x9c5b0ad01821f479aa8582d82d50b23a0d580f83ec0541722da8e3f626f946f6::version::Version) {
        0x9c5b0ad01821f479aa8582d82d50b23a0d580f83ec0541722da8e3f626f946f6::stake::updateUnlockTime<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun withdrawRewardCoins<T0, T1>(arg0: &0x9c5b0ad01821f479aa8582d82d50b23a0d580f83ec0541722da8e3f626f946f6::stake::Admincap, arg1: &mut 0x9c5b0ad01821f479aa8582d82d50b23a0d580f83ec0541722da8e3f626f946f6::stake::StakePool<T0, T1>, arg2: &mut 0x9c5b0ad01821f479aa8582d82d50b23a0d580f83ec0541722da8e3f626f946f6::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x9c5b0ad01821f479aa8582d82d50b23a0d580f83ec0541722da8e3f626f946f6::stake::withdrawRewardCoins<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun withdrawSpt<T0, T1>(arg0: &mut 0x9c5b0ad01821f479aa8582d82d50b23a0d580f83ec0541722da8e3f626f946f6::stake::StakePool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x9c5b0ad01821f479aa8582d82d50b23a0d580f83ec0541722da8e3f626f946f6::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x9c5b0ad01821f479aa8582d82d50b23a0d580f83ec0541722da8e3f626f946f6::stake::withdrawSpt<T0, T1>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

