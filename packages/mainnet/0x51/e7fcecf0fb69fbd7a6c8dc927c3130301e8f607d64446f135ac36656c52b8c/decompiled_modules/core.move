module 0xa59f6fa7927612f0d2b5e9d1878e69ba1400d3b015fca510336186e56f9967ad::core {
    struct Setting has key {
        id: 0x2::object::UID,
        version: u64,
        pools: 0x2::vec_map::VecMap<0x1::type_name::TypeName, address>,
    }

    struct Pool<phantom T0> has store, key {
        id: 0x2::object::UID,
        active: bool,
        balance: 0x2::balance::Balance<T0>,
        reward_configs: 0x2::vec_map::VecMap<0x1::type_name::TypeName, RewardConfig>,
        users: 0x2::table::Table<address, address>,
    }

    struct RewardConfig has store {
        reward_rate_before: u64,
        rate_change_at: u64,
        reward_rate_after: u64,
        per_share: u64,
        last_update_time: u64,
        bank: address,
    }

    struct Bank<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T1>,
    }

    struct Deposit<phantom T0> has key {
        id: 0x2::object::UID,
        pool: address,
        amount: u64,
        debts: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        credits: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
    }

    struct AddPoolEvent<phantom T0> has copy, drop {
        pool: address,
        coin_type: 0x1::type_name::TypeName,
    }

    struct SetPoolEvent<phantom T0> has copy, drop {
        pool: address,
        active: bool,
    }

    struct AddRewardConfigEvent<phantom T0> has copy, drop {
        pool: address,
        reward_type: 0x1::type_name::TypeName,
        reward_rate: u64,
        start_at: u64,
        bank: address,
    }

    struct SetRewardConfigEvent<phantom T0> has copy, drop {
        pool: address,
        reward_type: 0x1::type_name::TypeName,
        reward_rate: u64,
        start_at: u64,
    }

    struct FundingBankEvent<phantom T0> has copy, drop {
        bank: address,
        amount: u64,
    }

    struct DepositEvent<phantom T0> has copy, drop {
        deposit: address,
        owner: address,
        pool: address,
        amount: u64,
    }

    struct AddDepositEvent<phantom T0> has copy, drop {
        deposit: address,
        amount: u64,
    }

    struct WithdrawEvent<phantom T0> has copy, drop {
        deposit: address,
        amount: u64,
    }

    struct HarvestEvent<phantom T0> has copy, drop {
        deposit: address,
        reward_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct VersionUpdatedEvent has copy, drop {
        old: u64,
        new: u64,
    }

    fun add_credit<T0>(arg0: &mut Deposit<T0>, arg1: &0x1::type_name::TypeName, arg2: u64) {
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.credits, arg1)) {
            let v0 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, u64>(&mut arg0.credits, arg1);
            *v0 = *v0 + arg2;
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg0.credits, *arg1, arg2);
        };
    }

    public(friend) fun add_deposit<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut Pool<T0>, arg2: &mut Deposit<T0>, arg3: &0x2::clock::Clock) {
        assert!(arg1.active, 0);
        assert!(arg2.pool == 0x2::object::uid_to_address(&arg1.id), 7);
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = arg2.amount + v0;
        update_deposit_amount<T0>(arg1, arg2, v1, arg3);
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(arg0));
        let v2 = AddDepositEvent<T0>{
            deposit : 0x2::object::uid_to_address(&arg2.id),
            amount  : v0,
        };
        0x2::event::emit<AddDepositEvent<T0>>(v2);
    }

    public(friend) fun add_pool<T0>(arg0: &mut Setting, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(!0x2::vec_map::contains<0x1::type_name::TypeName, address>(&arg0.pools, &v0), 5);
        let v1 = create_pool<T0>(arg1);
        0x2::vec_map::insert<0x1::type_name::TypeName, address>(&mut arg0.pools, v0, 0x2::object::uid_to_address(&v1.id));
        let v2 = AddPoolEvent<T0>{
            pool      : 0x2::object::uid_to_address(&v1.id),
            coin_type : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<AddPoolEvent<T0>>(v2);
        0x2::transfer::share_object<Pool<T0>>(v1);
    }

    public(friend) fun add_reward_config<T0, T1>(arg0: &mut Pool<T0>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T1>();
        assert!(!0x2::vec_map::contains<0x1::type_name::TypeName, RewardConfig>(&arg0.reward_configs, &v0), 1);
        assert!(now(arg3) < arg1, 4);
        let (v1, v2) = create_reward_config_with_bank<T0, T1>(arg1, arg2, arg3, arg4);
        let v3 = v2;
        0x2::vec_map::insert<0x1::type_name::TypeName, RewardConfig>(&mut arg0.reward_configs, v0, v1);
        let v4 = AddRewardConfigEvent<T0>{
            pool        : 0x2::object::uid_to_address(&arg0.id),
            reward_type : v0,
            reward_rate : arg2,
            start_at    : arg1,
            bank        : 0x2::object::uid_to_address(&v3.id),
        };
        0x2::event::emit<AddRewardConfigEvent<T0>>(v4);
        0x2::transfer::share_object<Bank<T0, T1>>(v3);
    }

    public fun assert_version(arg0: &Setting) {
        assert!(arg0.version == 2, 6);
    }

    fun calculate_per_share_of_reward_config(arg0: u64, arg1: u64, arg2: u64, arg3: u128, arg4: u64, arg5: u64, arg6: u64) : u128 {
        let v0 = if (arg6 < arg1) {
            arg6
        } else {
            arg1
        };
        let v1 = if (arg1 < arg4) {
            arg4
        } else {
            arg1
        };
        arg3 + per_share_of_period(arg4, v0, arg0, arg5) + per_share_of_period(v1, arg6, arg2, arg5)
    }

    fun create_deposit<T0>(arg0: &mut Pool<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : Deposit<T0> {
        let v0 = 0x2::object::uid_to_address(&arg0.id);
        Deposit<T0>{
            id      : 0x2::object::new(arg3),
            pool    : v0,
            amount  : arg1,
            debts   : full_debts<T0>(arg0, arg1, arg2),
            credits : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
        }
    }

    fun create_pool<T0>(arg0: &mut 0x2::tx_context::TxContext) : Pool<T0> {
        Pool<T0>{
            id             : 0x2::object::new(arg0),
            active         : true,
            balance        : 0x2::balance::zero<T0>(),
            reward_configs : 0x2::vec_map::empty<0x1::type_name::TypeName, RewardConfig>(),
            users          : 0x2::table::new<address, address>(arg0),
        }
    }

    fun create_reward_config_with_bank<T0, T1>(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (RewardConfig, Bank<T0, T1>) {
        let v0 = Bank<T0, T1>{
            id      : 0x2::object::new(arg3),
            balance : 0x2::balance::zero<T1>(),
        };
        let v1 = RewardConfig{
            reward_rate_before : 0,
            rate_change_at     : arg0,
            reward_rate_after  : arg1,
            per_share          : 0,
            last_update_time   : now(arg2),
            bank               : 0x2::object::uid_to_address(&v0.id),
        };
        (v1, v0)
    }

    public(friend) fun deposit<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut Pool<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.active, 0);
        assert!(!0x2::table::contains<address, address>(&arg1.users, 0x2::tx_context::sender(arg3)), 2);
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = create_deposit<T0>(arg1, v0, arg2, arg3);
        0x2::table::add<address, address>(&mut arg1.users, 0x2::tx_context::sender(arg3), 0x2::object::uid_to_address(&v1.id));
        let v2 = DepositEvent<T0>{
            deposit : 0x2::object::uid_to_address(&v1.id),
            owner   : 0x2::tx_context::sender(arg3),
            pool    : 0x2::object::uid_to_address(&arg1.id),
            amount  : v0,
        };
        0x2::event::emit<DepositEvent<T0>>(v2);
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(arg0));
        0x2::transfer::transfer<Deposit<T0>>(v1, 0x2::tx_context::sender(arg3));
    }

    public(friend) fun extract_bank<T0, T1>(arg0: &mut Bank<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.balance, arg1), arg2)
    }

    fun extract_credit<T0>(arg0: &mut Deposit<T0>, arg1: &0x1::type_name::TypeName) : u64 {
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.credits, arg1)) {
            return 0
        };
        let (_, v1) = 0x2::vec_map::remove<0x1::type_name::TypeName, u64>(&mut arg0.credits, arg1);
        v1
    }

    fun full_debts<T0>(arg0: &mut Pool<T0>, arg1: u64, arg2: &0x2::clock::Clock) : 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64> {
        let v0 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
        let v1 = 0;
        while (v1 < 0x2::vec_map::size<0x1::type_name::TypeName, RewardConfig>(&arg0.reward_configs)) {
            let (v2, v3) = 0x2::vec_map::get_entry_by_idx_mut<0x1::type_name::TypeName, RewardConfig>(&mut arg0.reward_configs, v1);
            update_reward_config_per_share(v3, 0x2::balance::value<T0>(&arg0.balance), arg2);
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v0, *v2, (((v3.per_share as u128) * (arg1 as u128) / 1000000) as u64));
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun funding_bank<T0, T1>(arg0: &mut Bank<T0, T1>, arg1: 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::into_balance<T1>(arg1);
        let v1 = FundingBankEvent<T1>{
            bank   : 0x2::object::uid_to_address(&arg0.id),
            amount : 0x2::balance::value<T1>(&v0),
        };
        0x2::event::emit<FundingBankEvent<T1>>(v1);
        0x2::balance::join<T1>(&mut arg0.balance, v0);
    }

    fun get_debt<T0>(arg0: &Deposit<T0>, arg1: &0x1::type_name::TypeName) : u64 {
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.debts, arg1)) {
            return 0
        };
        *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&arg0.debts, arg1)
    }

    fun get_reward<T0>(arg0: &Deposit<T0>, arg1: &0x1::type_name::TypeName, arg2: u128) : u64 {
        (((arg0.amount as u128) * arg2 / 1000000) as u64) - get_debt<T0>(arg0, arg1)
    }

    public(friend) fun harvest<T0, T1>(arg0: &mut Pool<T0>, arg1: &mut Deposit<T0>, arg2: &mut Bank<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(arg0.active, 0);
        assert!(arg1.pool == 0x2::object::uid_to_address(&arg0.id), 7);
        rewards_to_credits<T0>(arg0, arg1, arg3);
        arg1.debts = full_debts<T0>(arg0, arg1.amount, arg3);
        let v0 = 0x1::type_name::get<T1>();
        let v1 = extract_credit<T0>(arg1, &v0);
        let v2 = HarvestEvent<T0>{
            deposit     : 0x2::object::uid_to_address(&arg1.id),
            reward_type : v0,
            amount      : v1,
        };
        0x2::event::emit<HarvestEvent<T0>>(v2);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg2.balance, v1), arg4)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Setting{
            id      : 0x2::object::new(arg0),
            version : 2,
            pools   : 0x2::vec_map::empty<0x1::type_name::TypeName, address>(),
        };
        0x2::transfer::share_object<Setting>(v0);
    }

    public(friend) fun migrate(arg0: &mut Setting) {
        assert!(arg0.version < 2, 6);
        let v0 = VersionUpdatedEvent{
            old : arg0.version,
            new : 2,
        };
        0x2::event::emit<VersionUpdatedEvent>(v0);
        arg0.version = 2;
    }

    fun now(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    public(friend) fun per_share_of_period(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u128 {
        if (arg1 <= arg0 || arg3 == 0) {
            0
        } else {
            ((arg1 - arg0) as u128) * (arg2 as u128) * 1000000 / (arg3 as u128)
        }
    }

    public(friend) fun remaining<T0>(arg0: &Pool<T0>, arg1: &Deposit<T0>, arg2: &0x2::clock::Clock) : 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64> {
        let v0 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
        let v1 = 0;
        while (v1 < 0x2::vec_map::size<0x1::type_name::TypeName, RewardConfig>(&arg0.reward_configs)) {
            let (v2, v3) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, RewardConfig>(&arg0.reward_configs, v1);
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v0, *v2, ((((calculate_per_share_of_reward_config(v3.reward_rate_before, v3.rate_change_at, v3.reward_rate_after, (v3.per_share as u128), v3.last_update_time, 0x2::balance::value<T0>(&arg0.balance), now(arg2)) as u64) as u128) * (arg1.amount as u128) / 1000000) as u64) - get_debt<T0>(arg1, v2));
            v1 = v1 + 1;
        };
        v0
    }

    fun rewards_to_credits<T0>(arg0: &mut Pool<T0>, arg1: &mut Deposit<T0>, arg2: &0x2::clock::Clock) {
        let v0 = 0;
        while (v0 < 0x2::vec_map::size<0x1::type_name::TypeName, RewardConfig>(&arg0.reward_configs)) {
            let (v1, v2) = 0x2::vec_map::get_entry_by_idx_mut<0x1::type_name::TypeName, RewardConfig>(&mut arg0.reward_configs, v0);
            update_reward_config_per_share(v2, 0x2::balance::value<T0>(&arg0.balance), arg2);
            let v3 = get_reward<T0>(arg1, v1, (v2.per_share as u128));
            add_credit<T0>(arg1, v1, v3);
            v0 = v0 + 1;
        };
    }

    public(friend) fun set_pool<T0>(arg0: &mut Pool<T0>, arg1: bool) {
        update_pool<T0>(arg0, arg1);
        let v0 = SetPoolEvent<T0>{
            pool   : 0x2::object::uid_to_address(&arg0.id),
            active : arg1,
        };
        0x2::event::emit<SetPoolEvent<T0>>(v0);
    }

    public(friend) fun set_reward_config<T0, T1>(arg0: &mut Pool<T0>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(now(arg3) < arg1, 4);
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, RewardConfig>(&mut arg0.reward_configs, &v0);
        update_reward_config(v1, arg1, arg2, 0x2::balance::value<T0>(&arg0.balance), arg3);
        let v2 = SetRewardConfigEvent<T0>{
            pool        : 0x2::object::uid_to_address(&arg0.id),
            reward_type : v0,
            reward_rate : arg2,
            start_at    : arg1,
        };
        0x2::event::emit<SetRewardConfigEvent<T0>>(v2);
    }

    fun update_deposit_amount<T0>(arg0: &mut Pool<T0>, arg1: &mut Deposit<T0>, arg2: u64, arg3: &0x2::clock::Clock) {
        rewards_to_credits<T0>(arg0, arg1, arg3);
        arg1.amount = arg2;
        arg1.debts = full_debts<T0>(arg0, arg1.amount, arg3);
    }

    fun update_pool<T0>(arg0: &mut Pool<T0>, arg1: bool) {
        arg0.active = arg1;
    }

    fun update_reward_config(arg0: &mut RewardConfig, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        update_reward_config_per_share(arg0, arg3, arg4);
        if (now(arg4) > arg0.rate_change_at) {
            arg0.reward_rate_before = arg0.reward_rate_after;
        };
        arg0.rate_change_at = arg1;
        arg0.reward_rate_after = arg2;
    }

    fun update_reward_config_per_share(arg0: &mut RewardConfig, arg1: u64, arg2: &0x2::clock::Clock) {
        arg0.per_share = (calculate_per_share_of_reward_config(arg0.reward_rate_before, arg0.rate_change_at, arg0.reward_rate_after, (arg0.per_share as u128), arg0.last_update_time, arg1, now(arg2)) as u64);
        arg0.last_update_time = now(arg2);
    }

    public(friend) fun withdraw<T0>(arg0: &mut Pool<T0>, arg1: &mut Deposit<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.active, 0);
        assert!(arg1.amount >= arg2, 3);
        assert!(arg1.pool == 0x2::object::uid_to_address(&arg0.id), 7);
        let v0 = arg1.amount - arg2;
        update_deposit_amount<T0>(arg0, arg1, v0, arg3);
        let v1 = WithdrawEvent<T0>{
            deposit : 0x2::object::uid_to_address(&arg1.id),
            amount  : arg2,
        };
        0x2::event::emit<WithdrawEvent<T0>>(v1);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg2), arg4)
    }

    // decompiled from Move bytecode v6
}

