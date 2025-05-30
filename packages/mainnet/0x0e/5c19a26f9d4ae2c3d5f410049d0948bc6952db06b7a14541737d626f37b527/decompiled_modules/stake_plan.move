module 0xe5c19a26f9d4ae2c3d5f410049d0948bc6952db06b7a14541737d626f37b527::stake_plan {
    struct STAKE_PLAN has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ManagerCap has store, key {
        id: 0x2::object::UID,
    }

    struct TreasureCap has store, key {
        id: 0x2::object::UID,
    }

    struct Operation has store, key {
        id: 0x2::object::UID,
        operationWallet: address,
    }

    struct Vault has store, key {
        id: 0x2::object::UID,
        member: 0x1::option::Option<address>,
    }

    struct StakeItem has copy, drop, store {
        owner: address,
        pool: address,
        stake: u128,
        withdraw_stake: u128,
        reward_remaining: u128,
        unlock_time: u64,
        unstaked: bool,
        claimable: bool,
        claimmed: bool,
        lastest_updated_time: u64,
    }

    struct StakePool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        apy: u128,
        paused: bool,
        unlock_times: u64,
        stake_coins: 0x2::coin::Coin<T0>,
        reward_coins: 0x2::coin::Coin<T1>,
        stakes: 0x2::table::Table<address, vector<StakeItem>>,
        plan: 0x2::table::Table<address, u8>,
    }

    struct ProjectRegistry has store, key {
        id: 0x2::object::UID,
        pools: 0x2::table::Table<address, u64>,
        user_pools: 0x2::table::Table<address, vector<address>>,
    }

    struct StakeEvent has copy, drop, store {
        pool: address,
        user_address: address,
        amount: u128,
        apy: u128,
        plan: u8,
        pool_total_stake: u128,
        user_total_staked: u128,
        user_total_withdraw: u128,
        user_total_reward_remain: u128,
    }

    struct UnStakeEvent has copy, drop, store {
        pool: address,
        user_address: address,
        unstake_amount: u128,
        reward_amount: u128,
        user_total_stake: u128,
        user_total_withdraw_stake: u128,
        user_total_reward_remaining: u128,
    }

    struct WithdrawRockeeEvent has copy, drop, store {
        pool: address,
        user_address: address,
        withdraw_amount: u128,
        reward_amount: u128,
        plan: u8,
        user_total_stake: u128,
        user_total_withdraw_stake: u128,
        user_total_reward_remaining: u128,
    }

    struct ClaimRewardsEvent has copy, drop, store {
        pool: address,
        user_address: address,
        amount: u128,
        user_total_stake: u128,
        user_total_withdraw_stake: u128,
        user_total_reward_remaining: u128,
    }

    struct StakeRewardsEvent has copy, drop, store {
        pool: address,
        user_address: address,
        amount: u128,
        plan: u8,
        pool_total_stake: u128,
        user_total_stake: u128,
        user_total_withdraw_stake: u128,
        user_total_reward_remaining: u128,
    }

    struct CreatePoolEvent has copy, drop {
        pool: address,
        unlock_times: u64,
        apy: u128,
    }

    struct PausePoolEvent has copy, drop, store {
        pool: address,
    }

    struct StartPoolEvent has copy, drop, store {
        pool: address,
    }

    struct UpdateUnlockTimeEvent has copy, drop, store {
        pool: address,
        old_unlock_time: u64,
        new_unclock_time: u64,
    }

    struct UpdateApyEvent has copy, drop, store {
        pool: address,
        user_address: address,
        old_apy: u128,
        new_apy: u128,
        user_total_stake: u128,
        user_total_withdraw_stake: u128,
        user_total_reward_remaining: u128,
        user_lastest_updated_time: u64,
    }

    struct WithdarawStakeEvent has copy, drop, store {
        pool: address,
        amount: u128,
    }

    struct DepositRewardEvent has copy, drop, store {
        pool: address,
        amount: u128,
        pool_total_reward: u128,
    }

    struct WithdarawRewardEvent has copy, drop, store {
        pool: address,
        amount: u128,
    }

    struct StopEmergencyEvent has copy, drop, store {
        pool: address,
        pool_total_stake: u128,
        paused: bool,
    }

    struct ChangeOperationWalletEvent has copy, drop {
        new_operation_wallet: address,
    }

    struct ChangeMemberInVaultEvent has copy, drop {
        new_member: address,
    }

    struct AddMemberInVaultEvent has copy, drop {
        member: address,
    }

    public fun addMemberInVault(arg0: &AdminCap, arg1: address, arg2: &mut Vault, arg3: &0xe5c19a26f9d4ae2c3d5f410049d0948bc6952db06b7a14541737d626f37b527::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xe5c19a26f9d4ae2c3d5f410049d0948bc6952db06b7a14541737d626f37b527::version::checkVersion(arg3, 1);
        assert!(!0x1::option::is_some<address>(&arg2.member), 8007);
        0x1::option::fill<address>(&mut arg2.member, arg1);
        let v0 = AddMemberInVaultEvent{member: arg1};
        0x2::event::emit<AddMemberInVaultEvent>(v0);
    }

    fun addPoolToRegistry(arg0: &mut ProjectRegistry, arg1: address, arg2: address) {
        if (0x2::table::contains<address, vector<address>>(&arg0.user_pools, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, vector<address>>(&mut arg0.user_pools, arg1);
            let (v1, _) = 0x1::vector::index_of<address>(v0, &arg2);
            if (!v1) {
                0x1::vector::push_back<address>(v0, arg2);
            };
        } else {
            let v3 = 0x1::vector::empty<address>();
            0x1::vector::push_back<address>(&mut v3, arg2);
            0x2::table::add<address, vector<address>>(&mut arg0.user_pools, arg1, v3);
        };
    }

    fun addStakeItemToPool<T0, T1>(arg0: &mut StakePool<T0, T1>, arg1: address, arg2: StakeItem) {
        if (0x2::table::contains<address, vector<StakeItem>>(&arg0.stakes, arg1)) {
            0x1::vector::push_back<StakeItem>(0x2::table::borrow_mut<address, vector<StakeItem>>(&mut arg0.stakes, arg1), arg2);
        } else {
            0x2::table::add<address, u8>(&mut arg0.plan, arg1, 0);
            let v0 = 0x1::vector::empty<StakeItem>();
            0x1::vector::push_back<StakeItem>(&mut v0, arg2);
            0x2::table::add<address, vector<StakeItem>>(&mut arg0.stakes, arg1, v0);
        };
    }

    public fun changeMemberInVault(arg0: &AdminCap, arg1: address, arg2: &mut Vault, arg3: &0xe5c19a26f9d4ae2c3d5f410049d0948bc6952db06b7a14541737d626f37b527::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xe5c19a26f9d4ae2c3d5f410049d0948bc6952db06b7a14541737d626f37b527::version::checkVersion(arg3, 1);
        assert!(0x1::option::is_some<address>(&arg2.member) && arg1 != *0x1::option::borrow<address>(&arg2.member), 8007);
        0x1::option::swap<address>(&mut arg2.member, arg1);
        let v0 = ChangeMemberInVaultEvent{new_member: arg1};
        0x2::event::emit<ChangeMemberInVaultEvent>(v0);
    }

    public fun changeOperationWallet(arg0: &mut Operation, arg1: &Vault, arg2: address, arg3: &0xe5c19a26f9d4ae2c3d5f410049d0948bc6952db06b7a14541737d626f37b527::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xe5c19a26f9d4ae2c3d5f410049d0948bc6952db06b7a14541737d626f37b527::version::checkVersion(arg3, 1);
        assert!(arg2 != arg0.operationWallet, 8007);
        assert!(0x1::option::is_some<address>(&arg1.member) && *0x1::option::borrow<address>(&arg1.member) == 0x2::tx_context::sender(arg4), 8006);
        assert!(arg0.operationWallet == 0x2::tx_context::sender(arg4), 8006);
        arg0.operationWallet = arg2;
        let v0 = ChangeOperationWalletEvent{new_operation_wallet: arg2};
        0x2::event::emit<ChangeOperationWalletEvent>(v0);
    }

    public fun claimReward<T0, T1>(arg0: &mut StakePool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0xe5c19a26f9d4ae2c3d5f410049d0948bc6952db06b7a14541737d626f37b527::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xe5c19a26f9d4ae2c3d5f410049d0948bc6952db06b7a14541737d626f37b527::version::checkVersion(arg2, 1);
        assert!(!arg0.paused, 8008);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, vector<StakeItem>>(&arg0.stakes, v1), 8004);
        let v2 = 0x2::table::borrow_mut<address, vector<StakeItem>>(&mut arg0.stakes, v1);
        let v3 = 0;
        let v4 = 0;
        while (v3 < 0x1::vector::length<StakeItem>(v2)) {
            let v5 = 0x1::vector::borrow_mut<StakeItem>(v2, v3);
            if (!v5.unstaked) {
                update_reward_remaining(arg0.apy, v0, v5);
                v4 = v4 + v5.reward_remaining;
                v5.reward_remaining = 0;
            };
            v3 = v3 + 1;
        };
        assert!(v4 > 0 && (0x2::coin::value<T1>(&arg0.reward_coins) as u128) >= v4, 8003);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg0.reward_coins, (v4 as u64), arg3), v1);
        let (v6, v7, v8) = getUserStakeInfoInAPool<T0, T1>(arg0, v1, v0);
        let v9 = ClaimRewardsEvent{
            pool                        : 0x2::object::id_address<StakePool<T0, T1>>(arg0),
            user_address                : v1,
            amount                      : v4,
            user_total_stake            : v6,
            user_total_withdraw_stake   : v7,
            user_total_reward_remaining : v8,
        };
        0x2::event::emit<ClaimRewardsEvent>(v9);
    }

    public fun createPool<T0, T1>(arg0: &ManagerCap, arg1: &mut ProjectRegistry, arg2: u64, arg3: u128, arg4: &0xe5c19a26f9d4ae2c3d5f410049d0948bc6952db06b7a14541737d626f37b527::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xe5c19a26f9d4ae2c3d5f410049d0948bc6952db06b7a14541737d626f37b527::version::checkVersion(arg4, 1);
        assert!(arg3 > 0, 8001);
        let v0 = StakePool<T0, T1>{
            id           : 0x2::object::new(arg5),
            apy          : arg3,
            paused       : false,
            unlock_times : arg2,
            stake_coins  : 0x2::coin::zero<T0>(arg5),
            reward_coins : 0x2::coin::zero<T1>(arg5),
            stakes       : 0x2::table::new<address, vector<StakeItem>>(arg5),
            plan         : 0x2::table::new<address, u8>(arg5),
        };
        0x2::table::add<address, u64>(&mut arg1.pools, 0x2::object::id_address<StakePool<T0, T1>>(&v0), 0);
        let v1 = CreatePoolEvent{
            pool         : 0x2::object::id_address<StakePool<T0, T1>>(&v0),
            unlock_times : arg2,
            apy          : arg3,
        };
        0x2::event::emit<CreatePoolEvent>(v1);
        0x2::transfer::share_object<StakePool<T0, T1>>(v0);
    }

    public fun depositRewardCoins<T0, T1>(arg0: &TreasureCap, arg1: &mut StakePool<T0, T1>, arg2: &0xe5c19a26f9d4ae2c3d5f410049d0948bc6952db06b7a14541737d626f37b527::version::Version, arg3: 0x2::coin::Coin<T1>) {
        0xe5c19a26f9d4ae2c3d5f410049d0948bc6952db06b7a14541737d626f37b527::version::checkVersion(arg2, 1);
        let v0 = (0x2::coin::value<T1>(&arg3) as u128);
        assert!(v0 > 0, 8002);
        0x2::coin::join<T1>(&mut arg1.reward_coins, arg3);
        let v1 = DepositRewardEvent{
            pool              : 0x2::object::id_address<StakePool<T0, T1>>(arg1),
            amount            : v0,
            pool_total_reward : (0x2::coin::value<T1>(&arg1.reward_coins) as u128),
        };
        0x2::event::emit<DepositRewardEvent>(v1);
    }

    public fun getOperationWallet(arg0: &Operation) : address {
        arg0.operationWallet
    }

    public fun getUserClaimableTokens<T0, T1>(arg0: &mut StakePool<T0, T1>, arg1: address, arg2: u64) : (u128, u128) {
        let v0 = 0x2::table::borrow_mut<address, vector<StakeItem>>(&mut arg0.stakes, arg1);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        while (v1 < 0x1::vector::length<StakeItem>(v0)) {
            let v4 = 0x1::vector::borrow_mut<StakeItem>(v0, v1);
            if (!v4.unstaked) {
                update_reward_remaining(arg0.apy, arg2, v4);
            };
            if (arg2 >= v4.unlock_time && !v4.claimmed) {
                v3 = v3 + v4.stake;
            };
            v2 = v2 + v4.reward_remaining;
            v1 = v1 + 1;
        };
        (v2, v3)
    }

    public fun getUserPlan<T0, T1>(arg0: &StakePool<T0, T1>, arg1: address) : u8 {
        *0x2::table::borrow<address, u8>(&arg0.plan, arg1)
    }

    public fun getUserStakeInfoInAPool<T0, T1>(arg0: &mut StakePool<T0, T1>, arg1: address, arg2: u64) : (u128, u128, u128) {
        let v0 = 0x2::table::borrow_mut<address, vector<StakeItem>>(&mut arg0.stakes, arg1);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<StakeItem>(v0)) {
            let v5 = 0x1::vector::borrow_mut<StakeItem>(v0, v4);
            v3 = v3 + v5.stake;
            v2 = v2 + v5.withdraw_stake;
            if (!v5.unstaked) {
                update_reward_remaining(arg0.apy, arg2, v5);
            };
            v1 = v1 + v5.reward_remaining;
            v4 = v4 + 1;
        };
        (v3, v2, v1)
    }

    fun init(arg0: STAKE_PLAN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        let v1 = ManagerCap{id: 0x2::object::new(arg1)};
        let v2 = TreasureCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<ManagerCap>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<TreasureCap>(v2, 0x2::tx_context::sender(arg1));
        0xe5c19a26f9d4ae2c3d5f410049d0948bc6952db06b7a14541737d626f37b527::cap_vault::createVault<AdminCap>(arg1);
        0xe5c19a26f9d4ae2c3d5f410049d0948bc6952db06b7a14541737d626f37b527::cap_vault::createVault<ManagerCap>(arg1);
        0xe5c19a26f9d4ae2c3d5f410049d0948bc6952db06b7a14541737d626f37b527::cap_vault::createVault<TreasureCap>(arg1);
        let v3 = ProjectRegistry{
            id         : 0x2::object::new(arg1),
            pools      : 0x2::table::new<address, u64>(arg1),
            user_pools : 0x2::table::new<address, vector<address>>(arg1),
        };
        0x2::transfer::share_object<ProjectRegistry>(v3);
        let v4 = Operation{
            id              : 0x2::object::new(arg1),
            operationWallet : @0x8320647849603591d5e5684289e9a78cd42371ac7a3f89a18136b693af6ef2f4,
        };
        0x2::transfer::share_object<Operation>(v4);
        let v5 = Vault{
            id     : 0x2::object::new(arg1),
            member : 0x1::option::none<address>(),
        };
        0x2::transfer::share_object<Vault>(v5);
    }

    public fun pause<T0, T1>(arg0: &ManagerCap, arg1: &mut StakePool<T0, T1>, arg2: &0xe5c19a26f9d4ae2c3d5f410049d0948bc6952db06b7a14541737d626f37b527::version::Version) {
        0xe5c19a26f9d4ae2c3d5f410049d0948bc6952db06b7a14541737d626f37b527::version::checkVersion(arg2, 1);
        arg1.paused = true;
        let v0 = PausePoolEvent{pool: 0x2::object::id_address<StakePool<T0, T1>>(arg1)};
        0x2::event::emit<PausePoolEvent>(v0);
    }

    public fun stake<T0, T1>(arg0: &mut StakePool<T0, T1>, arg1: &mut ProjectRegistry, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &0xe5c19a26f9d4ae2c3d5f410049d0948bc6952db06b7a14541737d626f37b527::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xe5c19a26f9d4ae2c3d5f410049d0948bc6952db06b7a14541737d626f37b527::version::checkVersion(arg4, 1);
        assert!(!arg0.paused, 8008);
        let v0 = (0x2::coin::value<T0>(&arg2) as u128);
        assert!(v0 > 0, 8002);
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = arg0.apy;
        let v3 = 0x2::clock::timestamp_ms(arg3);
        let v4 = StakeItem{
            owner                : v1,
            pool                 : 0x2::object::id_address<StakePool<T0, T1>>(arg0),
            stake                : v0,
            withdraw_stake       : 0,
            reward_remaining     : 0,
            unlock_time          : v3 + arg0.unlock_times,
            unstaked             : false,
            claimable            : false,
            claimmed             : false,
            lastest_updated_time : v3,
        };
        addStakeItemToPool<T0, T1>(arg0, v1, v4);
        addPoolToRegistry(arg1, v1, 0x2::object::id_address<StakePool<T0, T1>>(arg0));
        let (v5, v6, v7) = getUserStakeInfoInAPool<T0, T1>(arg0, v1, v3);
        if (v5 - v6 >= 200000000000 || v5 - v6 >= 1000000000000) {
            0x2::table::remove<address, u8>(&mut arg0.plan, v1);
            if (v5 - v6 >= 1000000000000) {
                0x2::table::add<address, u8>(&mut arg0.plan, v1, 2);
            } else if (v5 - v6 >= 200000000000) {
                0x2::table::add<address, u8>(&mut arg0.plan, v1, 1);
            };
        };
        0x2::coin::join<T0>(&mut arg0.stake_coins, arg2);
        let v8 = StakeEvent{
            pool                     : 0x2::object::id_address<StakePool<T0, T1>>(arg0),
            user_address             : v1,
            amount                   : v0,
            apy                      : v2,
            plan                     : getUserPlan<T0, T1>(arg0, v1),
            pool_total_stake         : (0x2::coin::value<T0>(&arg0.stake_coins) as u128),
            user_total_staked        : v5,
            user_total_withdraw      : v6,
            user_total_reward_remain : v7,
        };
        0x2::event::emit<StakeEvent>(v8);
    }

    public fun stakeReward<T0, T1>(arg0: &mut StakePool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0xe5c19a26f9d4ae2c3d5f410049d0948bc6952db06b7a14541737d626f37b527::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xe5c19a26f9d4ae2c3d5f410049d0948bc6952db06b7a14541737d626f37b527::version::checkVersion(arg2, 1);
        assert!(!arg0.paused, 8008);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, vector<StakeItem>>(&arg0.stakes, v1), 8003);
        let v2 = 0x2::table::borrow_mut<address, vector<StakeItem>>(&mut arg0.stakes, v1);
        let v3 = 0;
        let v4 = 0;
        while (v3 < 0x1::vector::length<StakeItem>(v2)) {
            let v5 = 0x1::vector::borrow_mut<StakeItem>(v2, v3);
            if (!v5.unstaked) {
                update_reward_remaining(arg0.apy, v0, v5);
                v5.stake = v5.stake + v5.reward_remaining;
                v4 = v4 + v5.reward_remaining;
                v5.reward_remaining = 0;
            };
            v3 = v3 + 1;
        };
        assert!(v4 > 0, 8003);
        let (v6, v7, v8) = getUserStakeInfoInAPool<T0, T1>(arg0, v1, v0);
        if (v6 - v7 >= 200000000000 || v6 - v7 >= 1000000000000) {
            0x2::table::remove<address, u8>(&mut arg0.plan, v1);
            if (v6 - v7 >= 1000000000000) {
                0x2::table::add<address, u8>(&mut arg0.plan, v1, 2);
            } else if (v6 - v7 >= 200000000000) {
                0x2::table::add<address, u8>(&mut arg0.plan, v1, 1);
            };
        };
        let v9 = StakeRewardsEvent{
            pool                        : 0x2::object::id_address<StakePool<T0, T1>>(arg0),
            user_address                : v1,
            amount                      : v4,
            plan                        : getUserPlan<T0, T1>(arg0, v1),
            pool_total_stake            : (0x2::coin::value<T0>(&arg0.stake_coins) as u128) + v4,
            user_total_stake            : v6,
            user_total_withdraw_stake   : v7,
            user_total_reward_remaining : v8,
        };
        0x2::event::emit<StakeRewardsEvent>(v9);
    }

    public fun start<T0, T1>(arg0: &ManagerCap, arg1: &mut StakePool<T0, T1>, arg2: &0xe5c19a26f9d4ae2c3d5f410049d0948bc6952db06b7a14541737d626f37b527::version::Version) {
        0xe5c19a26f9d4ae2c3d5f410049d0948bc6952db06b7a14541737d626f37b527::version::checkVersion(arg2, 1);
        arg1.paused = false;
        let v0 = StartPoolEvent{pool: 0x2::object::id_address<StakePool<T0, T1>>(arg1)};
        0x2::event::emit<StartPoolEvent>(v0);
    }

    public fun stopEmergency<T0, T1>(arg0: &ManagerCap, arg1: &mut StakePool<T0, T1>, arg2: vector<address>, arg3: bool, arg4: &0xe5c19a26f9d4ae2c3d5f410049d0948bc6952db06b7a14541737d626f37b527::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xe5c19a26f9d4ae2c3d5f410049d0948bc6952db06b7a14541737d626f37b527::version::checkVersion(arg4, 1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = *0x1::vector::borrow<address>(&arg2, v0);
            if (0x2::table::contains<address, vector<StakeItem>>(&arg1.stakes, v1)) {
                let v2 = 0x2::table::borrow_mut<address, vector<StakeItem>>(&mut arg1.stakes, v1);
                let v3 = 0;
                let v4 = 0;
                while (v3 < 0x1::vector::length<StakeItem>(v2)) {
                    let v5 = 0x1::vector::borrow_mut<StakeItem>(v2, v3);
                    if (!v5.claimmed) {
                        v4 = v4 + v5.stake;
                        v5.withdraw_stake = v5.stake;
                        v5.unstaked = true;
                        v5.claimmed = true;
                        v5.claimmed = true;
                    };
                    v3 = v3 + 1;
                };
                assert!(v4 > 0, 8003);
                assert!(v4 > 0 && (0x2::coin::value<T0>(&arg1.stake_coins) as u128) >= v4, 8003);
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1.stake_coins, (v4 as u64), arg5), v1);
            };
            v0 = v0 + 1;
        };
        arg1.paused = arg3;
        let v6 = StopEmergencyEvent{
            pool             : 0x2::object::id_address<StakePool<T0, T1>>(arg1),
            pool_total_stake : (0x2::coin::value<T0>(&arg1.stake_coins) as u128),
            paused           : arg3,
        };
        0x2::event::emit<StopEmergencyEvent>(v6);
    }

    public fun unstake<T0, T1>(arg0: &mut StakePool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0xe5c19a26f9d4ae2c3d5f410049d0948bc6952db06b7a14541737d626f37b527::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xe5c19a26f9d4ae2c3d5f410049d0948bc6952db06b7a14541737d626f37b527::version::checkVersion(arg2, 1);
        assert!(!arg0.paused, 8008);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, vector<StakeItem>>(&arg0.stakes, v1), 8004);
        let v2 = 0x2::table::borrow_mut<address, vector<StakeItem>>(&mut arg0.stakes, v1);
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        while (v3 < 0x1::vector::length<StakeItem>(v2)) {
            let v6 = 0x1::vector::borrow_mut<StakeItem>(v2, v3);
            if (!v6.unstaked) {
                v6.unstaked = true;
                update_reward_remaining(arg0.apy, v0, v6);
                v5 = v5 + v6.stake;
                v4 = v4 + v6.reward_remaining;
                v6.reward_remaining = 0;
            };
            v3 = v3 + 1;
        };
        assert!(v4 > 0 && (0x2::coin::value<T1>(&arg0.reward_coins) as u128) >= v4, 8003);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg0.reward_coins, (v4 as u64), arg3), v1);
        let (v7, v8, v9) = getUserStakeInfoInAPool<T0, T1>(arg0, v1, v0);
        let v10 = UnStakeEvent{
            pool                        : 0x2::object::id_address<StakePool<T0, T1>>(arg0),
            user_address                : v1,
            unstake_amount              : v5,
            reward_amount               : v4,
            user_total_stake            : v7,
            user_total_withdraw_stake   : v8,
            user_total_reward_remaining : v9,
        };
        0x2::event::emit<UnStakeEvent>(v10);
    }

    public entry fun updateApy<T0, T1>(arg0: &ManagerCap, arg1: &mut StakePool<T0, T1>, arg2: vector<address>, arg3: u128, arg4: &0xe5c19a26f9d4ae2c3d5f410049d0948bc6952db06b7a14541737d626f37b527::version::Version, arg5: &0x2::clock::Clock) {
        0xe5c19a26f9d4ae2c3d5f410049d0948bc6952db06b7a14541737d626f37b527::version::checkVersion(arg4, 1);
        assert!(arg3 > 0, 8001);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = arg1.apy;
        arg1.apy = arg3;
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&arg2)) {
            let v3 = *0x1::vector::borrow<address>(&arg2, v2);
            if (0x2::table::contains<address, vector<StakeItem>>(&arg1.stakes, v3)) {
                let v4 = 0x2::table::borrow_mut<address, vector<StakeItem>>(&mut arg1.stakes, v3);
                let v5 = 0;
                while (v5 < 0x1::vector::length<StakeItem>(v4)) {
                    let v6 = 0x1::vector::borrow_mut<StakeItem>(v4, v5);
                    if (!v6.unstaked) {
                        update_reward_remaining(v1, v0, v6);
                    };
                    v5 = v5 + 1;
                };
                let (v7, v8, v9) = getUserStakeInfoInAPool<T0, T1>(arg1, v3, v0);
                let v10 = UpdateApyEvent{
                    pool                        : 0x2::object::id_address<StakePool<T0, T1>>(arg1),
                    user_address                : v3,
                    old_apy                     : v1,
                    new_apy                     : arg3,
                    user_total_stake            : v7,
                    user_total_withdraw_stake   : v8,
                    user_total_reward_remaining : v9,
                    user_lastest_updated_time   : v0,
                };
                0x2::event::emit<UpdateApyEvent>(v10);
            };
            v2 = v2 + 1;
        };
    }

    public fun updateUnlockTime<T0, T1>(arg0: &ManagerCap, arg1: &mut StakePool<T0, T1>, arg2: u64, arg3: &0xe5c19a26f9d4ae2c3d5f410049d0948bc6952db06b7a14541737d626f37b527::version::Version) {
        0xe5c19a26f9d4ae2c3d5f410049d0948bc6952db06b7a14541737d626f37b527::version::checkVersion(arg3, 1);
        assert!(arg2 > 0, 8001);
        arg1.unlock_times = arg2;
        let v0 = UpdateUnlockTimeEvent{
            pool             : 0x2::object::id_address<StakePool<T0, T1>>(arg1),
            old_unlock_time  : arg1.unlock_times,
            new_unclock_time : arg2,
        };
        0x2::event::emit<UpdateUnlockTimeEvent>(v0);
    }

    fun update_reward_remaining(arg0: u128, arg1: u64, arg2: &mut StakeItem) {
        assert!(arg0 > 0, 8001);
        arg2.reward_remaining = arg2.reward_remaining + ((arg1 - arg2.lastest_updated_time) as u128) * arg2.stake * arg0 / ((31536000000 * 10000) as u128);
        arg2.lastest_updated_time = arg1;
    }

    public fun withdrawRewardCoins<T0, T1>(arg0: &TreasureCap, arg1: &mut StakePool<T0, T1>, arg2: &Operation, arg3: &0xe5c19a26f9d4ae2c3d5f410049d0948bc6952db06b7a14541737d626f37b527::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xe5c19a26f9d4ae2c3d5f410049d0948bc6952db06b7a14541737d626f37b527::version::checkVersion(arg3, 1);
        let v0 = (0x2::coin::value<T1>(&arg1.reward_coins) as u128);
        assert!(v0 > 0, 8003);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg1.reward_coins, (v0 as u64), arg4), arg2.operationWallet);
        let v1 = WithdarawRewardEvent{
            pool   : 0x2::object::id_address<StakePool<T0, T1>>(arg1),
            amount : v0,
        };
        0x2::event::emit<WithdarawRewardEvent>(v1);
    }

    public fun withdrawRockee<T0, T1>(arg0: &mut StakePool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0xe5c19a26f9d4ae2c3d5f410049d0948bc6952db06b7a14541737d626f37b527::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xe5c19a26f9d4ae2c3d5f410049d0948bc6952db06b7a14541737d626f37b527::version::checkVersion(arg2, 1);
        assert!(!arg0.paused, 8008);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let v2 = 0x2::table::borrow_mut<address, vector<StakeItem>>(&mut arg0.stakes, v0);
        let v3 = 0;
        let v4 = 0;
        while (v3 < 0x1::vector::length<StakeItem>(v2)) {
            let v5 = 0x1::vector::borrow_mut<StakeItem>(v2, v3);
            if (!v5.unstaked) {
                update_reward_remaining(arg0.apy, v1, v5);
            };
            if (v1 >= v5.unlock_time && !v5.claimmed) {
                v5.claimable = true;
                v5.withdraw_stake = v5.stake;
                v4 = v4 + v5.stake;
                v5.unstaked = true;
                v5.claimmed = true;
            };
            v3 = v3 + 1;
        };
        assert!(v4 > 0, 8003);
        assert!(v4 > 0 && (0x2::coin::value<T0>(&arg0.stake_coins) as u128) >= v4, 8003);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.stake_coins, (v4 as u64), arg3), v0);
        let (v6, v7, v8) = getUserStakeInfoInAPool<T0, T1>(arg0, v0, v1);
        if (v6 - v7 < 200000000000 || v6 - v7 < 1000000000000) {
            0x2::table::remove<address, u8>(&mut arg0.plan, v0);
            if (v6 - v7 < 200000000000) {
                0x2::table::add<address, u8>(&mut arg0.plan, v0, 0);
            } else if (v6 - v7 < 1000000000000) {
                0x2::table::add<address, u8>(&mut arg0.plan, v0, 1);
            };
        };
        let v9 = WithdrawRockeeEvent{
            pool                        : 0x2::object::id_address<StakePool<T0, T1>>(arg0),
            user_address                : v0,
            withdraw_amount             : v4,
            reward_amount               : 0,
            plan                        : getUserPlan<T0, T1>(arg0, v0),
            user_total_stake            : v6,
            user_total_withdraw_stake   : v7,
            user_total_reward_remaining : v8,
        };
        0x2::event::emit<WithdrawRockeeEvent>(v9);
    }

    public fun withdrawStakeCoins<T0, T1>(arg0: &TreasureCap, arg1: &mut StakePool<T0, T1>, arg2: &Operation, arg3: &0xe5c19a26f9d4ae2c3d5f410049d0948bc6952db06b7a14541737d626f37b527::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xe5c19a26f9d4ae2c3d5f410049d0948bc6952db06b7a14541737d626f37b527::version::checkVersion(arg3, 1);
        let v0 = (0x2::coin::value<T0>(&arg1.stake_coins) as u128);
        assert!(v0 > 0, 8003);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1.stake_coins, (v0 as u64), arg4), arg2.operationWallet);
        let v1 = WithdarawStakeEvent{
            pool   : 0x2::object::id_address<StakePool<T0, T1>>(arg1),
            amount : v0,
        };
        0x2::event::emit<WithdarawStakeEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

