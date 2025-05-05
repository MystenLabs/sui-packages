module 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::pools {
    struct POOLS has drop {
        dummy_field: bool,
    }

    struct RewardPool<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct RewardPoolGame<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        reward: 0x2::balance::Balance<T0>,
        bonus: 0x2::balance::Balance<T1>,
    }

    struct FeePool<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct CreatePoolRewardEvent has copy, drop {
        pool_id: 0x2::object::ID,
        token_type: 0x1::type_name::TypeName,
    }

    struct CreateFeePoolEvent has copy, drop {
        pool_id: 0x2::object::ID,
        token_type: 0x1::type_name::TypeName,
    }

    struct DepositEvent has copy, drop {
        owner: address,
        pool: 0x2::object::ID,
        amount: u64,
    }

    struct DepositPoolGameEvent has copy, drop {
        owner: address,
        pool: 0x2::object::ID,
        reward: u64,
        bonus: u64,
    }

    struct EmergencyWithdrawEvent has copy, drop {
        owner: address,
        pool: 0x2::object::ID,
        amount: u64,
    }

    struct EmergencyWithdrawPoolGameEvent has copy, drop {
        owner: address,
        pool: 0x2::object::ID,
        reward: u64,
        bonus: u64,
    }

    struct WithdrawPoolFeeEvent has copy, drop {
        owner: address,
        amount: u64,
    }

    public(friend) fun collect_fee<T0>(arg0: &mut FeePool<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun create_fee_pool<T0>(arg0: &0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::manager::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = FeePool<T0>{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<FeePool<T0>>(v0);
        let v1 = CreateFeePoolEvent{
            pool_id    : 0x2::object::id<FeePool<T0>>(&v0),
            token_type : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<CreateFeePoolEvent>(v1);
    }

    public fun create_reward_pool<T0>(arg0: &0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::manager::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = RewardPool<T0>{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<RewardPool<T0>>(v0);
        let v1 = CreatePoolRewardEvent{
            pool_id    : 0x2::object::id<RewardPool<T0>>(&v0),
            token_type : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<CreatePoolRewardEvent>(v1);
    }

    public fun create_reward_pool_game<T0, T1>(arg0: &0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::manager::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = RewardPoolGame<T0, T1>{
            id     : 0x2::object::new(arg1),
            reward : 0x2::balance::zero<T0>(),
            bonus  : 0x2::balance::zero<T1>(),
        };
        0x2::transfer::share_object<RewardPoolGame<T0, T1>>(v0);
        let v1 = CreatePoolRewardEvent{
            pool_id    : 0x2::object::id<RewardPoolGame<T0, T1>>(&v0),
            token_type : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<CreatePoolRewardEvent>(v1);
    }

    public fun deposit_reward<T0>(arg0: &0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::manager::TreasureCap, arg1: 0x2::coin::Coin<T0>, arg2: &mut RewardPool<T0>, arg3: &0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg2.balance, 0x2::coin::into_balance<T0>(arg1));
        let v0 = DepositEvent{
            owner  : 0x2::tx_context::sender(arg3),
            pool   : 0x2::object::id<RewardPool<T0>>(arg2),
            amount : 0x2::coin::value<T0>(&arg1),
        };
        0x2::event::emit<DepositEvent>(v0);
    }

    public fun deposit_reward_pool_game<T0, T1>(arg0: &0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::manager::TreasureCap, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut RewardPoolGame<T0, T1>, arg4: &0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg3.reward, 0x2::coin::into_balance<T0>(arg1));
        0x2::balance::join<T1>(&mut arg3.bonus, 0x2::coin::into_balance<T1>(arg2));
        let v0 = DepositPoolGameEvent{
            owner  : 0x2::tx_context::sender(arg4),
            pool   : 0x2::object::id<RewardPoolGame<T0, T1>>(arg3),
            reward : 0x2::coin::value<T0>(&arg1),
            bonus  : 0x2::coin::value<T1>(&arg2),
        };
        0x2::event::emit<DepositPoolGameEvent>(v0);
    }

    public fun emergency_reward_withdraw<T0>(arg0: &0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::manager::TreasureCap, arg1: &mut RewardPool<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::balance::value<T0>(&arg1.balance) > 0, 3000);
        let v1 = 0x2::balance::value<T0>(&arg1.balance);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, v1), arg2), v0);
        let v2 = EmergencyWithdrawEvent{
            owner  : v0,
            pool   : 0x2::object::id<RewardPool<T0>>(arg1),
            amount : v1,
        };
        0x2::event::emit<EmergencyWithdrawEvent>(v2);
    }

    public fun emergency_reward_withdraw_pool_game<T0, T1>(arg0: &0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::manager::TreasureCap, arg1: &mut RewardPoolGame<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::balance::value<T0>(&arg1.reward) > 0, 3000);
        assert!(0x2::balance::value<T1>(&arg1.bonus) > 0, 3000);
        let v1 = 0x2::balance::value<T0>(&arg1.reward);
        let v2 = 0x2::balance::value<T1>(&arg1.bonus);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.reward, v1), arg2), v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.bonus, v2), arg2), v0);
        let v3 = EmergencyWithdrawPoolGameEvent{
            owner  : v0,
            pool   : 0x2::object::id<RewardPoolGame<T0, T1>>(arg1),
            reward : v1,
            bonus  : v2,
        };
        0x2::event::emit<EmergencyWithdrawPoolGameEvent>(v3);
    }

    public fun get_reward_balance<T0>(arg0: &RewardPool<T0>) : u128 {
        (0x2::balance::value<T0>(&arg0.balance) as u128)
    }

    fun init(arg0: POOLS, arg1: &mut 0x2::tx_context::TxContext) {
    }

    public(friend) fun transfer_checkin_reward<T0>(arg0: &mut 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::archive::UserArchive, arg1: u64, arg2: &mut RewardPool<T0>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2.balance, arg1), arg4), arg3);
        0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::archive::inc_checkin_reward(arg0, arg1)
    }

    public(friend) fun transfer_mission_reward<T0>(arg0: &mut 0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::archive::GuestArchive, arg1: &mut RewardPool<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::archive::inc_mission_reward(arg0, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, arg2), arg4), arg3);
    }

    public(friend) fun transfer_reward_game<T0, T1>(arg0: &mut RewardPoolGame<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reward, arg1 + arg1 * arg3 / 100 / 100), arg5), arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.bonus, arg2 + arg2 * arg3 / 100 / 100), arg5), arg4);
    }

    public fun validate_reward_pool_game<T0, T1>(arg0: &RewardPoolGame<T0, T1>, arg1: u64, arg2: u64, arg3: u64) {
        assert!(0x2::balance::value<T0>(&arg0.reward) >= arg1 + arg1 * arg3 / 100 / 100, 3000);
        assert!(0x2::balance::value<T1>(&arg0.bonus) >= arg2 + arg2 * arg3 / 100 / 100, 3000);
    }

    public fun withdraw_fee_pool<T0>(arg0: &0xf05bb642d373a1056d208071faa67461f4aded2f99e3b7af4bc106d8f99ba104::manager::TreasureCap, arg1: &mut FeePool<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::balance::value<T0>(&arg1.balance) > 0, 3000);
        let v1 = 0x2::balance::value<T0>(&arg1.balance);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, v1), arg2), v0);
        let v2 = WithdrawPoolFeeEvent{
            owner  : v0,
            amount : v1,
        };
        0x2::event::emit<WithdrawPoolFeeEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

