module 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake_entries {
    public entry fun stake<T0, T1>(arg0: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::StakePool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::RegistryStakePool, arg4: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::UserStakePoolInfo, arg5: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::stake<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun addProvider(arg0: &0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::Admincap, arg1: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::Providers, arg2: address, arg3: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::version::Version) {
        0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::addProvider(arg0, arg1, arg2, arg3);
    }

    public entry fun change_admin(arg0: 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::Admincap, arg1: address, arg2: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::version::Version) {
        0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::change_admin(arg0, arg1, arg2);
    }

    public entry fun claim<T0, T1>(arg0: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::StakePool<T0, T1>, arg1: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::StakeItem, arg2: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::RegistryStakePool, arg3: &0x2::clock::Clock, arg4: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::claim<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun confirmRequestChangeTreasury(arg0: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::VaultDAO, arg1: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::RequestChangeTreasuryInfo, arg2: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::RegistryRequest, arg3: &0x2::clock::Clock, arg4: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::confirmRequestChangeTreasury(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun confirmRequestFund(arg0: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::VaultDAO, arg1: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::RequestFundInfo, arg2: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::RegistryRequest, arg3: &0x2::clock::Clock, arg4: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::confirmRequestFund(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun createPool<T0, T1>(arg0: &0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::Admincap, arg1: u128, arg2: u64, arg3: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::RegistryStakePool, arg4: vector<u8>, arg5: vector<u8>, arg6: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::createPool<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun depositRewardCoins<T0, T1>(arg0: &0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::Admincap, arg1: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::StakePool<T0, T1>, arg2: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::version::Version, arg3: 0x2::coin::Coin<T1>) {
        0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::depositRewardCoins<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun executeRequestChangeTreasury(arg0: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::RegistryRequest, arg1: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::RequestChangeTreasuryInfo, arg2: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::VaultDAO, arg3: &0x2::clock::Clock, arg4: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::executeRequestChangeTreasury(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun executeRequestChangeVoter(arg0: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::RegistryRequest, arg1: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::RequestChangeVoterInfo, arg2: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::VaultDAO, arg3: &0x2::clock::Clock, arg4: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::executeRequestChangeVoter(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun executeRequestFund<T0, T1>(arg0: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::StakePool<T0, T1>, arg1: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::RequestFundInfo, arg2: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::RegistryRequest, arg3: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::VaultDAO, arg4: &0x2::clock::Clock, arg5: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::executeRequestFund<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun migrateStake<T0, T1>(arg0: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::Providers, arg1: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::StakePool<T0, T1>, arg2: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::RegistryStakePool, arg3: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::UserStakePoolInfo, arg4: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::RequestId, arg5: vector<u8>, arg6: address, arg7: 0x2::coin::Coin<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::version::Version, arg10: &mut 0x2::tx_context::TxContext) {
        0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::migrateStake<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    public entry fun pause<T0, T1>(arg0: &0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::Admincap, arg1: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::StakePool<T0, T1>, arg2: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::version::Version) {
        0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::pause<T0, T1>(arg0, arg1, arg2);
    }

    public entry fun reStakeRewards<T0, T1>(arg0: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::StakePool<T0, T1>, arg1: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::StakeItem, arg2: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::RegistryStakePool, arg3: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::UserStakePoolInfo, arg4: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::version::Version, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::reStakeRewards<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun removeProvider(arg0: &0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::Admincap, arg1: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::Providers, arg2: address, arg3: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::version::Version) {
        0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::removeProvider(arg0, arg1, arg2, arg3);
    }

    public entry fun requestChangeTreasury(arg0: address, arg1: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::VaultDAO, arg2: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::RegistryRequest, arg3: &0x2::clock::Clock, arg4: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::requestChangeTreasury(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun requestChangeVoter(arg0: address, arg1: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::VaultDAO, arg2: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::RegistryRequest, arg3: &0x2::clock::Clock, arg4: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::requestChangeVoter(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun requestFund<T0, T1>(arg0: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::StakePool<T0, T1>, arg1: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::VaultDAO, arg2: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::RegistryStakePool, arg3: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::RegistryRequest, arg4: &0x2::clock::Clock, arg5: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::requestFund<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun restake<T0, T1>(arg0: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::StakePool<T0, T1>, arg1: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::StakeItem, arg2: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::RegistryStakePool, arg3: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::version::Version, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::restake<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun revokeRequestChangeTreasury(arg0: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::RegistryRequest, arg1: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::VaultDAO, arg2: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::RequestChangeTreasuryInfo, arg3: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::revokeRequestChangeTreasury(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun revokeRequestChangeVoter(arg0: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::RegistryRequest, arg1: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::VaultDAO, arg2: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::RequestChangeVoterInfo, arg3: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::revokeRequestChangeVoter(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun revokeRequestFund(arg0: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::VaultDAO, arg1: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::RequestFundInfo, arg2: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::RegistryRequest, arg3: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::revokeRequestFund(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun stopAll<T0, T1>(arg0: &0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::Admincap, arg1: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::StakePool<T0, T1>, arg2: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::version::Version) {
        0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::stopAll<T0, T1>(arg0, arg1, arg2);
    }

    public entry fun stopEmergency<T0, T1>(arg0: &0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::Admincap, arg1: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::StakePool<T0, T1>, arg2: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::StakeItem, arg3: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::RegistryStakePool, arg4: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::UserStakePoolInfo, arg5: address, arg6: bool, arg7: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::version::Version, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::stopEmergency<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public entry fun unPause<T0, T1>(arg0: &0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::Admincap, arg1: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::StakePool<T0, T1>, arg2: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::version::Version) {
        0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::unPause<T0, T1>(arg0, arg1, arg2);
    }

    public entry fun unStopAll<T0, T1>(arg0: &0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::Admincap, arg1: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::StakePool<T0, T1>, arg2: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::version::Version) {
        0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::unStopAll<T0, T1>(arg0, arg1, arg2);
    }

    public entry fun unstake<T0, T1>(arg0: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::StakePool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::StakeItem, arg3: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::RegistryStakePool, arg4: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::unstake<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun updateApyPool<T0, T1>(arg0: &0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::Admincap, arg1: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::StakePool<T0, T1>, arg2: u128, arg3: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::version::Version) {
        0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::updateApyPool<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun updateApyStakeItem(arg0: &0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::Admincap, arg1: u128, arg2: address, arg3: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::StakeItem, arg4: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::RegistryStakePool, arg5: &0x2::clock::Clock, arg6: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::version::Version) {
        0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::updateApyStakeItem(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun updateLockPeriod<T0, T1>(arg0: &0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::Admincap, arg1: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::StakePool<T0, T1>, arg2: u64, arg3: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::version::Version) {
        0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::updateLockPeriod<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun updateMinStake<T0, T1>(arg0: &0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::Admincap, arg1: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::StakePool<T0, T1>, arg2: u128, arg3: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::version::Version) {
        0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::updateMinStake<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun upgradeStakeItem<T0, T1>(arg0: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::StakePool<T0, T1>, arg1: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::StakePool<T0, T1>, arg2: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::StakeItem, arg3: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::RegistryStakePool, arg4: &0x2::clock::Clock, arg5: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::UserStakePoolInfo, arg6: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::upgradeStakeItem<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun confirmRequestChangeVote(arg0: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::VaultDAO, arg1: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::RequestChangeVoterInfo, arg2: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::RegistryRequest, arg3: &0x2::clock::Clock, arg4: &mut 0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xb437499c347b683b6e71b4e7bd66bcd1074b0910726d9031e387ed759c45dc0a::stake::confirmRequestChangeVoter(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

