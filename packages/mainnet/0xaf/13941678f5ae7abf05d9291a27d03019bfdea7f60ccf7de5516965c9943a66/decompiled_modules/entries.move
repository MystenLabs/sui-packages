module 0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::entries {
    public entry fun addMemberInVault_Plan(arg0: &0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::AdminCap, arg1: address, arg2: &mut 0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::Vault, arg3: &mut 0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::addMemberInVault(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun addMemberInVault_Pool(arg0: &0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::AdminCap, arg1: address, arg2: &mut 0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::Vault, arg3: &mut 0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_pool::addMemberInVault(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun changeMemberInVault_Plan(arg0: &0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::AdminCap, arg1: address, arg2: &mut 0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::Vault, arg3: &mut 0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::changeMemberInVault(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun changeMemberInVault_Pool(arg0: &0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::AdminCap, arg1: address, arg2: &mut 0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::Vault, arg3: &mut 0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_pool::changeMemberInVault(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun changeOperationWallet_Plan(arg0: &mut 0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::Operation, arg1: &0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::Vault, arg2: address, arg3: &mut 0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::changeOperationWallet(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun changeOperationWallet_Pool(arg0: &mut 0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::Operation, arg1: &0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::Vault, arg2: address, arg3: &mut 0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_pool::changeOperationWallet(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun claimCap<T0: store + key>(arg0: &mut 0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::cap_vault::CapVault<T0>, arg1: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::cap_vault::claim_cap<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun claimReward_Plan<T0, T1>(arg0: &mut 0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::StakePool<T0, T1>, arg1: &mut 0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::UserPlan, arg2: &0x2::clock::Clock, arg3: &0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::claimReward<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun claimReward_Pool<T0, T1>(arg0: &mut 0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_pool::StakePool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_pool::claimReward<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun createPool_Plan<T0, T1>(arg0: &0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::ManagerCap, arg1: &mut 0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::ProjectRegistry, arg2: u64, arg3: u128, arg4: &0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::createPool<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun createPool_Pool<T0, T1>(arg0: &0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::ManagerCap, arg1: &mut 0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_pool::ProjectRegistry, arg2: u64, arg3: u128, arg4: &0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_pool::createPool<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun depositRewardCoins_Plan<T0, T1>(arg0: &0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::TreasureCap, arg1: &mut 0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::StakePool<T0, T1>, arg2: &0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::version::Version, arg3: 0x2::coin::Coin<T1>) {
        0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::depositRewardCoins<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun depositRewardCoins_Pool<T0, T1>(arg0: &0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::TreasureCap, arg1: &mut 0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_pool::StakePool<T0, T1>, arg2: &0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::version::Version, arg3: 0x2::coin::Coin<T1>) {
        0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_pool::depositRewardCoins<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun migrateVersion(arg0: &0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::version::VerAdminCap, arg1: &mut 0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::version::Version, arg2: u64) {
        0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::version::migrate(arg0, arg1, arg2);
    }

    public entry fun pause_Plan<T0, T1>(arg0: &0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::ManagerCap, arg1: &mut 0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::StakePool<T0, T1>, arg2: &0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::version::Version) {
        0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::pause<T0, T1>(arg0, arg1, arg2);
    }

    public entry fun pause_Pool<T0, T1>(arg0: &0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::ManagerCap, arg1: &mut 0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_pool::StakePool<T0, T1>, arg2: &0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::version::Version) {
        0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_pool::pause<T0, T1>(arg0, arg1, arg2);
    }

    public entry fun revokeCap<T0: store + key>(arg0: &mut 0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::cap_vault::CapVault<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::cap_vault::revoke_cap<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun stakeReward_Pool<T0, T1>(arg0: &mut 0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_pool::StakePool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_pool::stakeReward<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun stake_Plan<T0, T1>(arg0: &mut 0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::StakePool<T0, T1>, arg1: &0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::PlanConfig, arg2: &mut 0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::ProjectRegistry, arg3: u8, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::stake<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun stake_Pool<T0, T1>(arg0: &mut 0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_pool::StakePool<T0, T1>, arg1: &mut 0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_pool::ProjectRegistry, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_pool::stake<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun start_Plan<T0, T1>(arg0: &0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::ManagerCap, arg1: &mut 0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::StakePool<T0, T1>, arg2: &0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::version::Version) {
        0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::start<T0, T1>(arg0, arg1, arg2);
    }

    public entry fun start_Pool<T0, T1>(arg0: &0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::ManagerCap, arg1: &mut 0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_pool::StakePool<T0, T1>, arg2: &0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::version::Version) {
        0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_pool::start<T0, T1>(arg0, arg1, arg2);
    }

    public entry fun stopEmergency_Plan<T0, T1>(arg0: &0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::ManagerCap, arg1: &mut 0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::StakePool<T0, T1>, arg2: &mut 0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::UserPlan, arg3: bool, arg4: &0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::stopEmergency<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun stopEmergency_Pool<T0, T1>(arg0: &0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::ManagerCap, arg1: &mut 0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_pool::StakePool<T0, T1>, arg2: vector<address>, arg3: bool, arg4: &0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_pool::stopEmergency<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun transferCap<T0: store + key>(arg0: T0, arg1: address, arg2: &mut 0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::cap_vault::CapVault<T0>, arg3: &0x2::tx_context::TxContext) {
        0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::cap_vault::transfer_cap<T0>(arg0, arg1, arg2, arg3);
    }

    public entry fun unstake_Plan<T0, T1>(arg0: &mut 0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::StakePool<T0, T1>, arg1: &mut 0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::UserPlan, arg2: &0x2::clock::Clock, arg3: &0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::unstake<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun unstake_Pool<T0, T1>(arg0: &mut 0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_pool::StakePool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_pool::unstake<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun updateApy_Plan<T0, T1>(arg0: &0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::ManagerCap, arg1: &mut 0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::StakePool<T0, T1>, arg2: &mut 0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::UserPlan, arg3: u128, arg4: &0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::version::Version, arg5: &0x2::clock::Clock) {
        0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::updateApy<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun updateApy_Pool<T0, T1>(arg0: &0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::ManagerCap, arg1: &mut 0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_pool::StakePool<T0, T1>, arg2: vector<address>, arg3: u128, arg4: &0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::version::Version, arg5: &0x2::clock::Clock) {
        0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_pool::updateApy<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun updateMinPlus(arg0: &0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::ManagerCap, arg1: &mut 0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::PlanConfig, arg2: u128, arg3: &0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::version::Version) {
        0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::updateMinPlus(arg0, arg1, arg2, arg3);
    }

    public entry fun updateMinPro(arg0: &0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::ManagerCap, arg1: &mut 0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::PlanConfig, arg2: u128, arg3: &0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::version::Version) {
        0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::updateMinPro(arg0, arg1, arg2, arg3);
    }

    public entry fun updateUnlockTimeNew_Plan<T0, T1>(arg0: &0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::ManagerCap, arg1: &mut 0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::StakePool<T0, T1>, arg2: u64, arg3: &0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::version::Version) {
        0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::updateUnlockTimeNew<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun updateUnlockTime_Plan<T0, T1>(arg0: &0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::ManagerCap, arg1: &mut 0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::StakePool<T0, T1>, arg2: &mut 0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::UserPlan, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::version::Version) {
        0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::updateUnlockTime<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun updateUnlockTime_Pool<T0, T1>(arg0: &0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::ManagerCap, arg1: &mut 0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_pool::StakePool<T0, T1>, arg2: vector<address>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::version::Version) {
        0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_pool::updateUnlockTime<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun upgradeToPro<T0, T1>(arg0: &mut 0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::StakePool<T0, T1>, arg1: &0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::PlanConfig, arg2: u8, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::upgradeToPro<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun withdrawRewardCoins_Plan<T0, T1>(arg0: &0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::TreasureCap, arg1: &mut 0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::StakePool<T0, T1>, arg2: &0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::Operation, arg3: &0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::withdrawRewardCoins<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun withdrawRewardCoins_Pool<T0, T1>(arg0: &0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::TreasureCap, arg1: &mut 0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_pool::StakePool<T0, T1>, arg2: &0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::Operation, arg3: &0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_pool::withdrawRewardCoins<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun withdrawRockee<T0, T1>(arg0: &mut 0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::StakePool<T0, T1>, arg1: &mut 0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::UserPlan, arg2: &0x2::clock::Clock, arg3: &0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::withdrawRockee<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun withdrawStakeCoins_Plan<T0, T1>(arg0: &0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::TreasureCap, arg1: &mut 0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::StakePool<T0, T1>, arg2: &0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::Operation, arg3: &0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::withdrawStakeCoins<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun withdrawStakeCoins_Pool<T0, T1>(arg0: &0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::TreasureCap, arg1: &mut 0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_pool::StakePool<T0, T1>, arg2: &0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_plan::Operation, arg3: &0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xaf13941678f5ae7abf05d9291a27d03019bfdea7f60ccf7de5516965c9943a66::stake_pool::withdrawStakeCoins<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

