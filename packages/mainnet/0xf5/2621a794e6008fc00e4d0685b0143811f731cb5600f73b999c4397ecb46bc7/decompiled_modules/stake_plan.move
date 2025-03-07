module 0xf52621a794e6008fc00e4d0685b0143811f731cb5600f73b999c4397ecb46bc7::stake_plan {
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

    struct PlanConfig has key {
        id: 0x2::object::UID,
        min_plus: u128,
        min_pro: u128,
    }

    struct UserPlan has store, key {
        id: 0x2::object::UID,
        user: address,
        pool: address,
        plan: u8,
        staked: u128,
        reward: u128,
        reward_withdraw: u128,
        last_updated_time: u64,
        unlocked_time: u64,
        unstaked: bool,
        claimed: bool,
    }

    struct StakePool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        apy: u128,
        paused: bool,
        unlock_times: u64,
        stake_coins: 0x2::coin::Coin<T0>,
        reward_coins: 0x2::coin::Coin<T1>,
        users: 0x2::table::Table<address, u8>,
        userPlan: 0x2::table::Table<address, vector<address>>,
    }

    struct ProjectRegistry has store, key {
        id: 0x2::object::UID,
        pools: 0x2::table::Table<address, u64>,
        user_pools: 0x2::table::Table<address, vector<address>>,
    }

    struct StakeEvent has copy, drop, store {
        userPlan: address,
        pool: address,
        user_address: address,
        amount: u128,
        apy: u128,
        plan: u8,
        pool_total_stake: u128,
    }

    struct UpgradeToPro has copy, drop, store {
        userPlan: address,
        pool: address,
        user_address: address,
        amount: u128,
        apy: u128,
        plan: u8,
        pool_total_stake: u128,
    }

    struct UnStakeEvent has copy, drop, store {
        pool: address,
        user_address: address,
        user_plan: u8,
        unstake_amount: u128,
        reward_amount: u128,
        unlock_time: u64,
    }

    struct WithdrawRockeeEvent has copy, drop, store {
        pool: address,
        user_address: address,
        withdraw_amount: u128,
        pool_total_stake: u128,
        pool_total_reward: u128,
    }

    struct ClaimRewardsEvent has copy, drop, store {
        pool: address,
        user_address: address,
        amount: u128,
        user_staked: u128,
        pool_total_stake: u128,
        pool_total_reward: u128,
    }

    struct CreatePoolEvent has copy, drop {
        pool: address,
        unlock_times: u64,
        apy: u128,
    }

    struct UpdatePLanConfigEvent has copy, drop {
        min_plus: u128,
        min_pro: u128,
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

    public fun addMemberInVault(arg0: &AdminCap, arg1: address, arg2: &mut Vault, arg3: &0xf52621a794e6008fc00e4d0685b0143811f731cb5600f73b999c4397ecb46bc7::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xf52621a794e6008fc00e4d0685b0143811f731cb5600f73b999c4397ecb46bc7::version::checkVersion(arg3, 1);
        assert!(!0x1::option::is_some<address>(&arg2.member), 8001);
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

    fun addUserPlanToPool<T0, T1>(arg0: &mut StakePool<T0, T1>, arg1: address, arg2: address) {
        if (0x2::table::contains<address, vector<address>>(&arg0.userPlan, arg1)) {
            0x1::vector::push_back<address>(0x2::table::borrow_mut<address, vector<address>>(&mut arg0.userPlan, arg1), arg2);
        } else {
            let v0 = 0x1::vector::empty<address>();
            0x1::vector::push_back<address>(&mut v0, arg2);
            0x2::table::add<address, vector<address>>(&mut arg0.userPlan, arg1, v0);
        };
    }

    public fun changeMemberInVault(arg0: &AdminCap, arg1: address, arg2: &mut Vault, arg3: &0xf52621a794e6008fc00e4d0685b0143811f731cb5600f73b999c4397ecb46bc7::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xf52621a794e6008fc00e4d0685b0143811f731cb5600f73b999c4397ecb46bc7::version::checkVersion(arg3, 1);
        assert!(0x1::option::is_some<address>(&arg2.member) && arg1 != *0x1::option::borrow<address>(&arg2.member), 8001);
        0x1::option::swap<address>(&mut arg2.member, arg1);
        let v0 = ChangeMemberInVaultEvent{new_member: arg1};
        0x2::event::emit<ChangeMemberInVaultEvent>(v0);
    }

    public fun changeOperationWallet(arg0: &mut Operation, arg1: &Vault, arg2: address, arg3: &0xf52621a794e6008fc00e4d0685b0143811f731cb5600f73b999c4397ecb46bc7::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xf52621a794e6008fc00e4d0685b0143811f731cb5600f73b999c4397ecb46bc7::version::checkVersion(arg3, 1);
        assert!(arg2 != arg0.operationWallet, 8001);
        assert!(0x1::option::is_some<address>(&arg1.member) && *0x1::option::borrow<address>(&arg1.member) == 0x2::tx_context::sender(arg4), 8006);
        assert!(arg0.operationWallet == 0x2::tx_context::sender(arg4), 8006);
        arg0.operationWallet = arg2;
        let v0 = ChangeOperationWalletEvent{new_operation_wallet: arg2};
        0x2::event::emit<ChangeOperationWalletEvent>(v0);
    }

    public fun claimReward<T0, T1>(arg0: &mut StakePool<T0, T1>, arg1: &mut UserPlan, arg2: &0x2::clock::Clock, arg3: &0xf52621a794e6008fc00e4d0685b0143811f731cb5600f73b999c4397ecb46bc7::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xf52621a794e6008fc00e4d0685b0143811f731cb5600f73b999c4397ecb46bc7::version::checkVersion(arg3, 1);
        assert!(!arg0.paused, 8008);
        assert!(arg1.plan == 1 || arg1.plan == 2, 8012);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg1.pool == 0x2::object::id_address<StakePool<T0, T1>>(arg0) && arg1.staked > 0, 8004);
        assert!(arg1.user == v0, 8001);
        assert!(!arg1.unstaked, 8014);
        update_reward_remaining(arg0.apy, 0x2::clock::timestamp_ms(arg2), arg1);
        let v1 = arg1.reward;
        assert!(v1 > 0 && (0x2::coin::value<T1>(&arg0.reward_coins) as u128) >= v1, 8009);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg0.reward_coins, (v1 as u64), arg4), v0);
        arg1.reward = 0;
        arg1.reward_withdraw = arg1.reward_withdraw + v1;
        let v2 = ClaimRewardsEvent{
            pool              : 0x2::object::id_address<StakePool<T0, T1>>(arg0),
            user_address      : v0,
            amount            : v1,
            user_staked       : arg1.staked,
            pool_total_stake  : (0x2::coin::value<T0>(&arg0.stake_coins) as u128),
            pool_total_reward : (0x2::coin::value<T1>(&arg0.reward_coins) as u128),
        };
        0x2::event::emit<ClaimRewardsEvent>(v2);
    }

    public fun createPool<T0, T1>(arg0: &ManagerCap, arg1: &mut ProjectRegistry, arg2: u64, arg3: u128, arg4: &0xf52621a794e6008fc00e4d0685b0143811f731cb5600f73b999c4397ecb46bc7::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xf52621a794e6008fc00e4d0685b0143811f731cb5600f73b999c4397ecb46bc7::version::checkVersion(arg4, 1);
        assert!(arg3 > 0, 8001);
        let v0 = StakePool<T0, T1>{
            id           : 0x2::object::new(arg5),
            apy          : arg3,
            paused       : false,
            unlock_times : arg2,
            stake_coins  : 0x2::coin::zero<T0>(arg5),
            reward_coins : 0x2::coin::zero<T1>(arg5),
            users        : 0x2::table::new<address, u8>(arg5),
            userPlan     : 0x2::table::new<address, vector<address>>(arg5),
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

    public fun depositRewardCoins<T0, T1>(arg0: &TreasureCap, arg1: &mut StakePool<T0, T1>, arg2: &0xf52621a794e6008fc00e4d0685b0143811f731cb5600f73b999c4397ecb46bc7::version::Version, arg3: 0x2::coin::Coin<T1>) {
        0xf52621a794e6008fc00e4d0685b0143811f731cb5600f73b999c4397ecb46bc7::version::checkVersion(arg2, 1);
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

    fun init(arg0: STAKE_PLAN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        let v1 = ManagerCap{id: 0x2::object::new(arg1)};
        let v2 = TreasureCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<ManagerCap>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<TreasureCap>(v2, 0x2::tx_context::sender(arg1));
        0xf52621a794e6008fc00e4d0685b0143811f731cb5600f73b999c4397ecb46bc7::cap_vault::createVault<AdminCap>(arg1);
        0xf52621a794e6008fc00e4d0685b0143811f731cb5600f73b999c4397ecb46bc7::cap_vault::createVault<ManagerCap>(arg1);
        0xf52621a794e6008fc00e4d0685b0143811f731cb5600f73b999c4397ecb46bc7::cap_vault::createVault<TreasureCap>(arg1);
        let v3 = ProjectRegistry{
            id         : 0x2::object::new(arg1),
            pools      : 0x2::table::new<address, u64>(arg1),
            user_pools : 0x2::table::new<address, vector<address>>(arg1),
        };
        0x2::transfer::share_object<ProjectRegistry>(v3);
        let v4 = Operation{
            id              : 0x2::object::new(arg1),
            operationWallet : @0xcf2791edbb647db10f904150aa7b8b50a13c52ff0796a357b71185f65366f999,
        };
        0x2::transfer::share_object<Operation>(v4);
        let v5 = Vault{
            id     : 0x2::object::new(arg1),
            member : 0x1::option::none<address>(),
        };
        0x2::transfer::share_object<Vault>(v5);
        let v6 = PlanConfig{
            id       : 0x2::object::new(arg1),
            min_plus : 200000 * 1000000,
            min_pro  : 1000000 * 1000000,
        };
        0x2::transfer::share_object<PlanConfig>(v6);
    }

    public fun pause<T0, T1>(arg0: &ManagerCap, arg1: &mut StakePool<T0, T1>, arg2: &0xf52621a794e6008fc00e4d0685b0143811f731cb5600f73b999c4397ecb46bc7::version::Version) {
        0xf52621a794e6008fc00e4d0685b0143811f731cb5600f73b999c4397ecb46bc7::version::checkVersion(arg2, 1);
        arg1.paused = true;
        let v0 = PausePoolEvent{pool: 0x2::object::id_address<StakePool<T0, T1>>(arg1)};
        0x2::event::emit<PausePoolEvent>(v0);
    }

    public fun stake<T0, T1>(arg0: &mut StakePool<T0, T1>, arg1: &PlanConfig, arg2: &mut ProjectRegistry, arg3: u8, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &0xf52621a794e6008fc00e4d0685b0143811f731cb5600f73b999c4397ecb46bc7::version::Version, arg7: &mut 0x2::tx_context::TxContext) {
        0xf52621a794e6008fc00e4d0685b0143811f731cb5600f73b999c4397ecb46bc7::version::checkVersion(arg6, 1);
        assert!(!arg0.paused, 8008);
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(!0x2::table::contains<address, u8>(&arg0.users, v0), 8010);
        assert!(arg3 == 1 || arg3 == 2, 8012);
        let v1 = arg0.apy;
        let v2 = (0x2::coin::value<T0>(&arg4) as u128);
        let v3 = UserPlan{
            id                : 0x2::object::new(arg7),
            user              : v0,
            pool              : 0x2::object::id_address<StakePool<T0, T1>>(arg0),
            plan              : 0,
            staked            : 0,
            reward            : 0,
            reward_withdraw   : 0,
            last_updated_time : 0x2::clock::timestamp_ms(arg5),
            unlocked_time     : 0,
            unstaked          : false,
            claimed           : false,
        };
        if (arg3 == 1) {
            assert!(v2 >= arg1.min_plus, 8011);
            v3.plan = 1;
            v3.staked = v2;
            0x2::table::add<address, u8>(&mut arg0.users, v0, 1);
        } else if (arg3 == 2) {
            assert!(v2 >= arg1.min_pro, 8011);
            v3.plan = 2;
            v3.staked = v2;
            0x2::table::add<address, u8>(&mut arg0.users, v0, 2);
        };
        0x2::coin::join<T0>(&mut arg0.stake_coins, arg4);
        addPoolToRegistry(arg2, v0, 0x2::object::id_address<StakePool<T0, T1>>(arg0));
        addUserPlanToPool<T0, T1>(arg0, v0, 0x2::object::id_address<UserPlan>(&v3));
        let v4 = StakeEvent{
            userPlan         : 0x2::object::id_address<UserPlan>(&v3),
            pool             : 0x2::object::id_address<StakePool<T0, T1>>(arg0),
            user_address     : v0,
            amount           : v2,
            apy              : v1,
            plan             : arg3,
            pool_total_stake : (0x2::coin::value<T0>(&arg0.stake_coins) as u128),
        };
        0x2::event::emit<StakeEvent>(v4);
        0x2::transfer::share_object<UserPlan>(v3);
    }

    public fun start<T0, T1>(arg0: &ManagerCap, arg1: &mut StakePool<T0, T1>, arg2: &0xf52621a794e6008fc00e4d0685b0143811f731cb5600f73b999c4397ecb46bc7::version::Version) {
        0xf52621a794e6008fc00e4d0685b0143811f731cb5600f73b999c4397ecb46bc7::version::checkVersion(arg2, 1);
        arg1.paused = false;
        let v0 = StartPoolEvent{pool: 0x2::object::id_address<StakePool<T0, T1>>(arg1)};
        0x2::event::emit<StartPoolEvent>(v0);
    }

    public fun stopEmergency<T0, T1>(arg0: &ManagerCap, arg1: &mut StakePool<T0, T1>, arg2: &mut UserPlan, arg3: bool, arg4: &0xf52621a794e6008fc00e4d0685b0143811f731cb5600f73b999c4397ecb46bc7::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xf52621a794e6008fc00e4d0685b0143811f731cb5600f73b999c4397ecb46bc7::version::checkVersion(arg4, 1);
        assert!(arg2.staked > 0, 8001);
        let v0 = arg2.staked;
        arg2.staked = 0;
        assert!(v0 > 0 && (0x2::coin::value<T0>(&arg1.stake_coins) as u128) >= v0, 8003);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1.stake_coins, (v0 as u64), arg5), arg2.user);
        arg1.paused = arg3;
        let v1 = StopEmergencyEvent{
            pool             : 0x2::object::id_address<StakePool<T0, T1>>(arg1),
            pool_total_stake : (0x2::coin::value<T0>(&arg1.stake_coins) as u128),
            paused           : arg3,
        };
        0x2::event::emit<StopEmergencyEvent>(v1);
    }

    public fun unstake<T0, T1>(arg0: &mut StakePool<T0, T1>, arg1: &mut UserPlan, arg2: &0x2::clock::Clock, arg3: &0xf52621a794e6008fc00e4d0685b0143811f731cb5600f73b999c4397ecb46bc7::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xf52621a794e6008fc00e4d0685b0143811f731cb5600f73b999c4397ecb46bc7::version::checkVersion(arg3, 1);
        assert!(!arg0.paused, 8008);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg1.user == v0, 8001);
        assert!(arg1.pool == 0x2::object::id_address<StakePool<T0, T1>>(arg0) && arg1.staked > 0, 8004);
        assert!(!arg1.unstaked, 8014);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        update_reward_remaining(arg0.apy, v1, arg1);
        arg1.last_updated_time = v1;
        arg1.unlocked_time = v1 + arg0.unlock_times;
        arg1.unstaked = true;
        let v2 = arg1.reward;
        if (v2 > 0) {
            assert!((0x2::coin::value<T1>(&arg0.reward_coins) as u128) >= v2, 8009);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg0.reward_coins, (v2 as u64), arg4), v0);
            arg1.reward = 0;
            arg1.reward_withdraw = arg1.reward_withdraw + v2;
        };
        let v3 = UnStakeEvent{
            pool           : 0x2::object::id_address<StakePool<T0, T1>>(arg0),
            user_address   : v0,
            user_plan      : arg1.plan,
            unstake_amount : arg1.staked,
            reward_amount  : v2,
            unlock_time    : arg1.unlocked_time,
        };
        0x2::event::emit<UnStakeEvent>(v3);
    }

    public fun updateApy<T0, T1>(arg0: &ManagerCap, arg1: &mut StakePool<T0, T1>, arg2: &mut UserPlan, arg3: u128, arg4: &0xf52621a794e6008fc00e4d0685b0143811f731cb5600f73b999c4397ecb46bc7::version::Version, arg5: &0x2::clock::Clock) {
        0xf52621a794e6008fc00e4d0685b0143811f731cb5600f73b999c4397ecb46bc7::version::checkVersion(arg4, 1);
        assert!(arg3 > 0, 8001);
        let v0 = arg1.apy;
        arg1.apy = arg3;
        assert!(0x2::table::contains<address, u8>(&arg1.users, arg2.user), 8004);
        update_reward_remaining(v0, 0x2::clock::timestamp_ms(arg5), arg2);
        let v1 = UpdateApyEvent{
            pool         : 0x2::object::id_address<StakePool<T0, T1>>(arg1),
            user_address : arg2.user,
            old_apy      : v0,
            new_apy      : arg3,
        };
        0x2::event::emit<UpdateApyEvent>(v1);
    }

    public fun updateMinPlus(arg0: &ManagerCap, arg1: &mut PlanConfig, arg2: u128, arg3: &0xf52621a794e6008fc00e4d0685b0143811f731cb5600f73b999c4397ecb46bc7::version::Version) {
        0xf52621a794e6008fc00e4d0685b0143811f731cb5600f73b999c4397ecb46bc7::version::checkVersion(arg3, 1);
        assert!(arg2 > 0 && arg2 * 1000000 != arg1.min_plus, 8001);
        arg1.min_plus = arg2 * 1000000;
        let v0 = UpdatePLanConfigEvent{
            min_plus : arg1.min_plus,
            min_pro  : arg1.min_pro,
        };
        0x2::event::emit<UpdatePLanConfigEvent>(v0);
    }

    public fun updateMinPro(arg0: &ManagerCap, arg1: &mut PlanConfig, arg2: u128, arg3: &0xf52621a794e6008fc00e4d0685b0143811f731cb5600f73b999c4397ecb46bc7::version::Version) {
        0xf52621a794e6008fc00e4d0685b0143811f731cb5600f73b999c4397ecb46bc7::version::checkVersion(arg3, 1);
        assert!(arg2 > 0 && arg2 * 1000000 != arg1.min_pro, 8001);
        arg1.min_pro = arg2 * 1000000;
        let v0 = UpdatePLanConfigEvent{
            min_plus : arg1.min_plus,
            min_pro  : arg1.min_pro,
        };
        0x2::event::emit<UpdatePLanConfigEvent>(v0);
    }

    public fun updateUnlockTime<T0, T1>(arg0: &ManagerCap, arg1: &mut StakePool<T0, T1>, arg2: &mut UserPlan, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0xf52621a794e6008fc00e4d0685b0143811f731cb5600f73b999c4397ecb46bc7::version::Version) {
        0xf52621a794e6008fc00e4d0685b0143811f731cb5600f73b999c4397ecb46bc7::version::checkVersion(arg5, 1);
        assert!(arg3 > 0, 8001);
        assert!(arg1.unlock_times != arg3, 8001);
        let v0 = arg1.unlock_times;
        arg1.unlock_times = arg3;
        if (arg2.unstaked && !arg2.claimed) {
            arg2.unlocked_time = arg2.unlocked_time - v0 + arg3;
            arg2.last_updated_time = 0x2::clock::timestamp_ms(arg4);
        };
        let v1 = UpdateUnlockTimeEvent{
            pool             : 0x2::object::id_address<StakePool<T0, T1>>(arg1),
            old_unlock_time  : v0,
            new_unclock_time : arg3,
        };
        0x2::event::emit<UpdateUnlockTimeEvent>(v1);
    }

    public fun updateUnlockTimeNew<T0, T1>(arg0: &ManagerCap, arg1: &mut StakePool<T0, T1>, arg2: u64, arg3: &0xf52621a794e6008fc00e4d0685b0143811f731cb5600f73b999c4397ecb46bc7::version::Version) {
        0xf52621a794e6008fc00e4d0685b0143811f731cb5600f73b999c4397ecb46bc7::version::checkVersion(arg3, 1);
        assert!(arg2 > 0, 8001);
        assert!(arg1.unlock_times != arg2, 8001);
        arg1.unlock_times = arg2;
        let v0 = UpdateUnlockTimeEvent{
            pool             : 0x2::object::id_address<StakePool<T0, T1>>(arg1),
            old_unlock_time  : arg1.unlock_times,
            new_unclock_time : arg2,
        };
        0x2::event::emit<UpdateUnlockTimeEvent>(v0);
    }

    fun update_reward_remaining(arg0: u128, arg1: u64, arg2: &mut UserPlan) {
        assert!(arg0 > 0, 8001);
        arg2.reward = arg2.reward + ((arg1 - arg2.last_updated_time) as u128) * arg2.staked * arg0 / 31536000000 * 10000;
        arg2.last_updated_time = arg1;
    }

    public fun upgradeToPro<T0, T1>(arg0: &mut StakePool<T0, T1>, arg1: &PlanConfig, arg2: u8, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &0xf52621a794e6008fc00e4d0685b0143811f731cb5600f73b999c4397ecb46bc7::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0xf52621a794e6008fc00e4d0685b0143811f731cb5600f73b999c4397ecb46bc7::version::checkVersion(arg5, 1);
        assert!(!arg0.paused, 8008);
        assert!(arg2 == 2, 8012);
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(0x2::table::contains<address, u8>(&arg0.users, v0), 8004);
        assert!(*0x2::table::borrow<address, u8>(&arg0.users, v0) == 1, 8005);
        let _ = arg1.min_plus;
        let v2 = (0x2::coin::value<T0>(&arg3) as u128);
        assert!(v2 >= arg1.min_pro, 8011);
        let v3 = arg0.apy;
        let v4 = UserPlan{
            id                : 0x2::object::new(arg6),
            user              : v0,
            pool              : 0x2::object::id_address<StakePool<T0, T1>>(arg0),
            plan              : 2,
            staked            : v2,
            reward            : 0,
            reward_withdraw   : 0,
            last_updated_time : 0x2::clock::timestamp_ms(arg4),
            unlocked_time     : 0,
            unstaked          : false,
            claimed           : false,
        };
        0x2::table::remove<address, u8>(&mut arg0.users, v0);
        0x2::table::add<address, u8>(&mut arg0.users, v0, 2);
        addUserPlanToPool<T0, T1>(arg0, v0, 0x2::object::id_address<UserPlan>(&v4));
        0x2::coin::join<T0>(&mut arg0.stake_coins, arg3);
        let v5 = UpgradeToPro{
            userPlan         : 0x2::object::id_address<UserPlan>(&v4),
            pool             : 0x2::object::id_address<StakePool<T0, T1>>(arg0),
            user_address     : v0,
            amount           : v2,
            apy              : v3,
            plan             : 2,
            pool_total_stake : (0x2::coin::value<T0>(&arg0.stake_coins) as u128),
        };
        0x2::event::emit<UpgradeToPro>(v5);
        0x2::transfer::share_object<UserPlan>(v4);
    }

    public fun withdrawRewardCoins<T0, T1>(arg0: &TreasureCap, arg1: &mut StakePool<T0, T1>, arg2: &Operation, arg3: &0xf52621a794e6008fc00e4d0685b0143811f731cb5600f73b999c4397ecb46bc7::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xf52621a794e6008fc00e4d0685b0143811f731cb5600f73b999c4397ecb46bc7::version::checkVersion(arg3, 1);
        let v0 = (0x2::coin::value<T1>(&arg1.reward_coins) as u128);
        assert!(v0 > 0, 8003);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg1.reward_coins, (v0 as u64), arg4), arg2.operationWallet);
        let v1 = WithdarawRewardEvent{
            pool   : 0x2::object::id_address<StakePool<T0, T1>>(arg1),
            amount : v0,
        };
        0x2::event::emit<WithdarawRewardEvent>(v1);
    }

    public fun withdrawRockee<T0, T1>(arg0: &mut StakePool<T0, T1>, arg1: &mut UserPlan, arg2: &0x2::clock::Clock, arg3: &0xf52621a794e6008fc00e4d0685b0143811f731cb5600f73b999c4397ecb46bc7::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xf52621a794e6008fc00e4d0685b0143811f731cb5600f73b999c4397ecb46bc7::version::checkVersion(arg3, 1);
        assert!(!arg0.paused, 8008);
        assert!(arg1.plan == 1 || arg1.plan == 2, 8012);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg1.pool == 0x2::object::id_address<StakePool<T0, T1>>(arg0) && arg1.staked > 0, 8004);
        assert!(arg1.user == v0, 8001);
        assert!(arg1.unstaked && 0x2::clock::timestamp_ms(arg2) >= arg1.unlocked_time, 8007);
        let v1 = arg1.staked;
        assert!(v1 > 0 && (0x2::coin::value<T0>(&arg0.stake_coins) as u128) >= v1, 8003);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.stake_coins, (v1 as u64), arg4), v0);
        arg1.staked = 0;
        arg1.claimed = true;
        if (0x2::table::contains<address, u8>(&arg0.users, v0)) {
            if (*0x2::table::borrow<address, u8>(&arg0.users, v0) == arg1.plan) {
                0x2::table::remove<address, u8>(&mut arg0.users, v0);
            };
        };
        let v2 = WithdrawRockeeEvent{
            pool              : 0x2::object::id_address<StakePool<T0, T1>>(arg0),
            user_address      : v0,
            withdraw_amount   : v1,
            pool_total_stake  : (0x2::coin::value<T0>(&arg0.stake_coins) as u128),
            pool_total_reward : (0x2::coin::value<T1>(&arg0.reward_coins) as u128),
        };
        0x2::event::emit<WithdrawRockeeEvent>(v2);
    }

    public fun withdrawStakeCoins<T0, T1>(arg0: &TreasureCap, arg1: &mut StakePool<T0, T1>, arg2: &Operation, arg3: &0xf52621a794e6008fc00e4d0685b0143811f731cb5600f73b999c4397ecb46bc7::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xf52621a794e6008fc00e4d0685b0143811f731cb5600f73b999c4397ecb46bc7::version::checkVersion(arg3, 1);
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

