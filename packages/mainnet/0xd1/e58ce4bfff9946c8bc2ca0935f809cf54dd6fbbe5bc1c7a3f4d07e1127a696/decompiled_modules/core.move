module 0x20f36728bf6015e290a58ffef79a5b5f16f5684d2520e7fb48091f5b9fdc4eed::core {
    struct Setting has key {
        id: 0x2::object::UID,
        version: u64,
        pools: 0x2::vec_map::VecMap<0x1::type_name::TypeName, address>,
        boosts: 0x2::vec_map::VecMap<address, u64>,
    }

    struct Pool<phantom T0> has store, key {
        id: 0x2::object::UID,
        active: bool,
        balance: 0x2::balance::Balance<T0>,
        total_share: u128,
        total_boost_share: u128,
        reward_configs: 0x2::vec_map::VecMap<0x1::type_name::TypeName, RewardConfig>,
        users: 0x2::table::Table<address, address>,
    }

    struct RewardConfig has store {
        reward_rate_before: u64,
        rate_change_at: u64,
        reward_rate_after: u64,
        per_share: u128,
        last_update_time: u64,
        bank: address,
        boost_active: bool,
    }

    struct Bank<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        pool: address,
        balance: 0x2::balance::Balance<T1>,
    }

    struct Deposit<phantom T0> has key {
        id: 0x2::object::UID,
        pool: address,
        amount: u64,
        share: u128,
        boost_share: u128,
        debts: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        credits: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        owner: address,
    }

    struct DepositInfo<phantom T0> has key {
        id: 0x2::object::UID,
        pool: address,
        deposit: address,
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
        boost_active: bool,
    }

    struct SetRewardConfigEvent<phantom T0> has copy, drop {
        pool: address,
        reward_type: 0x1::type_name::TypeName,
        reward_rate: u64,
        start_at: u64,
    }

    struct FlipBoostEvent has copy, drop {
        pool: address,
        reward_type: 0x1::type_name::TypeName,
    }

    struct SettleEvent has copy, drop {
        pool: address,
        deposit: address,
        old_debts: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        new_debts: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
    }

    struct AfterSetBoostEvent has copy, drop {
        pool: address,
        deposit: address,
        old_debts: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        old_share: u128,
        old_boost_share: u128,
        new_debts: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        new_share: u128,
        new_boost_share: u128,
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

    struct SetBoostEvent has copy, drop {
        addr: address,
        boost: u64,
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

    public(friend) fun add_deposit<T0>(arg0: &Setting, arg1: 0x2::coin::Coin<T0>, arg2: &mut Pool<T0>, arg3: &mut Deposit<T0>, arg4: &0x2::clock::Clock) {
        assert!(arg2.active, 0);
        assert!(arg3.pool == 0x2::object::uid_to_address(&arg2.id), 7);
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = arg3.amount + v0;
        update_deposit_amount<T0>(arg0, arg2, arg3, v1, arg4);
        0x2::balance::join<T0>(&mut arg2.balance, 0x2::coin::into_balance<T0>(arg1));
        let v2 = AddDepositEvent<T0>{
            deposit : 0x2::object::uid_to_address(&arg3.id),
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

    public(friend) fun add_reward_config<T0, T1>(arg0: &mut Pool<T0>, arg1: u64, arg2: u64, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T1>();
        assert!(!0x2::vec_map::contains<0x1::type_name::TypeName, RewardConfig>(&arg0.reward_configs, &v0), 1);
        assert!(now(arg4) < arg1, 4);
        let (v1, v2) = create_reward_config_with_bank<T0, T1>(0x2::object::uid_to_address(&arg0.id), arg1, arg2, arg3, arg4, arg5);
        let v3 = v2;
        0x2::vec_map::insert<0x1::type_name::TypeName, RewardConfig>(&mut arg0.reward_configs, v0, v1);
        let v4 = AddRewardConfigEvent<T0>{
            pool         : 0x2::object::uid_to_address(&arg0.id),
            reward_type  : v0,
            reward_rate  : arg2,
            start_at     : arg1,
            bank         : 0x2::object::uid_to_address(&v3.id),
            boost_active : arg3,
        };
        0x2::event::emit<AddRewardConfigEvent<T0>>(v4);
        0x2::transfer::share_object<Bank<T0, T1>>(v3);
    }

    public(friend) fun after_set_boost<T0>(arg0: &Setting, arg1: &mut Pool<T0>, arg2: &mut Deposit<T0>, arg3: &0x2::clock::Clock) {
        let v0 = arg2.debts;
        let v1 = arg2.share;
        let v2 = arg2.boost_share;
        update_share<T0>(arg2, arg0, arg1, false);
        let v3 = debts<T0>(arg1, arg2.amount, get_boost(arg0, &arg2.owner), arg3);
        arg2.debts = v3;
        let v4 = AfterSetBoostEvent{
            pool            : 0x2::object::uid_to_address(&arg1.id),
            deposit         : 0x2::object::uid_to_address(&arg2.id),
            old_debts       : v0,
            old_share       : v1,
            old_boost_share : v2,
            new_debts       : arg2.debts,
            new_share       : arg2.share,
            new_boost_share : arg2.boost_share,
        };
        0x2::event::emit<AfterSetBoostEvent>(v4);
    }

    public fun assert_version(arg0: &Setting) {
        assert!(arg0.version == 1, 6);
    }

    fun cal_share<T0>(arg0: &Deposit<T0>, arg1: &Setting) : (u128, u128) {
        ((arg0.amount as u128) * 1000, (arg0.amount as u128) * (get_boost(arg1, &arg0.owner) as u128))
    }

    public(friend) fun calculate_per_share_of_reward_config(arg0: u64, arg1: u64, arg2: u64, arg3: u128, arg4: u64, arg5: u128, arg6: u64) : u128 {
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

    fun create_deposit<T0>(arg0: &mut Pool<T0>, arg1: u64, arg2: u64, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : Deposit<T0> {
        let v0 = 0x2::object::uid_to_address(&arg0.id);
        Deposit<T0>{
            id          : 0x2::object::new(arg5),
            pool        : v0,
            amount      : arg1,
            share       : 0,
            boost_share : 0,
            debts       : debts<T0>(arg0, arg1, arg2, arg4),
            credits     : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            owner       : arg3,
        }
    }

    fun create_deposit_info<T0>(arg0: address, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : DepositInfo<T0> {
        DepositInfo<T0>{
            id      : 0x2::object::new(arg2),
            pool    : arg0,
            deposit : arg1,
        }
    }

    fun create_pool<T0>(arg0: &mut 0x2::tx_context::TxContext) : Pool<T0> {
        Pool<T0>{
            id                : 0x2::object::new(arg0),
            active            : true,
            balance           : 0x2::balance::zero<T0>(),
            total_share       : 0,
            total_boost_share : 0,
            reward_configs    : 0x2::vec_map::empty<0x1::type_name::TypeName, RewardConfig>(),
            users             : 0x2::table::new<address, address>(arg0),
        }
    }

    fun create_reward_config_with_bank<T0, T1>(arg0: address, arg1: u64, arg2: u64, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (RewardConfig, Bank<T0, T1>) {
        let v0 = Bank<T0, T1>{
            id      : 0x2::object::new(arg5),
            pool    : arg0,
            balance : 0x2::balance::zero<T1>(),
        };
        let v1 = RewardConfig{
            reward_rate_before : 0,
            rate_change_at     : arg1,
            reward_rate_after  : arg2,
            per_share          : 0,
            last_update_time   : now(arg4),
            bank               : 0x2::object::uid_to_address(&v0.id),
            boost_active       : arg3,
        };
        (v1, v0)
    }

    fun current_total_share(arg0: &RewardConfig, arg1: u128, arg2: u128) : u128 {
        if (arg0.boost_active) {
            arg2
        } else {
            arg1
        }
    }

    fun debt(arg0: &mut RewardConfig, arg1: u128, arg2: u128, arg3: &0x2::clock::Clock) : u64 {
        update_per_share(arg0, arg2, arg3);
        ((arg0.per_share * arg1 / 18446744073709551616) as u64)
    }

    fun debts<T0>(arg0: &mut Pool<T0>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) : 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64> {
        let v0 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
        let v1 = 0;
        while (v1 < 0x2::vec_map::size<0x1::type_name::TypeName, RewardConfig>(&arg0.reward_configs)) {
            let (v2, v3, v4) = get_reward_config_info_by_idx_mut<T0>(arg0, v1);
            let v5 = if (v3.boost_active) {
                (arg1 as u128) * (arg2 as u128)
            } else {
                (arg1 as u128) * 1000
            };
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v0, *v2, debt(v3, v5, v4, arg3));
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun deposit<T0>(arg0: &Setting, arg1: 0x2::coin::Coin<T0>, arg2: &mut Pool<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.active, 0);
        assert!(!0x2::table::contains<address, address>(&arg2.users, 0x2::tx_context::sender(arg4)), 2);
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = 0x2::tx_context::sender(arg4);
        let v3 = create_deposit<T0>(arg2, v0, get_boost(arg0, &v1), v2, arg3, arg4);
        let v4 = create_deposit_info<T0>(0x2::object::uid_to_address(&arg2.id), 0x2::object::uid_to_address(&v3.id), arg4);
        let v5 = &mut v3;
        update_share<T0>(v5, arg0, arg2, true);
        0x2::table::add<address, address>(&mut arg2.users, 0x2::tx_context::sender(arg4), 0x2::object::uid_to_address(&v3.id));
        let v6 = DepositEvent<T0>{
            deposit : 0x2::object::uid_to_address(&v3.id),
            owner   : 0x2::tx_context::sender(arg4),
            pool    : 0x2::object::uid_to_address(&arg2.id),
            amount  : v0,
        };
        0x2::event::emit<DepositEvent<T0>>(v6);
        0x2::balance::join<T0>(&mut arg2.balance, 0x2::coin::into_balance<T0>(arg1));
        0x2::transfer::share_object<Deposit<T0>>(v3);
        0x2::transfer::transfer<DepositInfo<T0>>(v4, 0x2::tx_context::sender(arg4));
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

    public(friend) fun flip_boost<T0, T1>(arg0: &mut Pool<T0>, arg1: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, RewardConfig>(&mut arg0.reward_configs, &v0);
        let v2 = current_total_share(v1, arg0.total_share, arg0.total_boost_share);
        update_per_share(v1, v2, arg1);
        v1.boost_active = !v1.boost_active;
        let v3 = FlipBoostEvent{
            pool        : 0x2::object::uid_to_address(&arg0.id),
            reward_type : v0,
        };
        0x2::event::emit<FlipBoostEvent>(v3);
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

    public fun get_boost(arg0: &Setting, arg1: &address) : u64 {
        if (!0x2::vec_map::contains<address, u64>(&arg0.boosts, arg1)) {
            return (1000 as u64)
        };
        *0x2::vec_map::get<address, u64>(&arg0.boosts, arg1)
    }

    fun get_credit<T0>(arg0: &Deposit<T0>, arg1: &0x1::type_name::TypeName) : u64 {
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.credits, arg1)) {
            return 0
        };
        *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&arg0.credits, arg1)
    }

    fun get_debt<T0>(arg0: &Deposit<T0>, arg1: &0x1::type_name::TypeName) : u64 {
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.debts, arg1)) {
            return 0
        };
        *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&arg0.debts, arg1)
    }

    public(friend) fun get_deposit<T0>(arg0: &Pool<T0>, arg1: &0x2::tx_context::TxContext) : address {
        let v0 = 0x2::tx_context::sender(arg1);
        if (0x2::table::contains<address, address>(&arg0.users, v0)) {
            *0x2::table::borrow<address, address>(&arg0.users, v0)
        } else {
            @0x0
        }
    }

    fun get_reward<T0>(arg0: &Deposit<T0>, arg1: &RewardConfig, arg2: &0x1::type_name::TypeName) : u64 {
        (((share_in_the_reward_config<T0>(arg0, arg1) as u128) * arg1.per_share / 18446744073709551616) as u64) - get_debt<T0>(arg0, arg2)
    }

    fun get_reward_config_info_by_idx_mut<T0>(arg0: &mut Pool<T0>, arg1: u64) : (&0x1::type_name::TypeName, &mut RewardConfig, u128) {
        let (v0, v1) = 0x2::vec_map::get_entry_by_idx_mut<0x1::type_name::TypeName, RewardConfig>(&mut arg0.reward_configs, arg1);
        (v0, v1, current_total_share(v1, arg0.total_share, arg0.total_boost_share))
    }

    public(friend) fun harvest<T0, T1>(arg0: &mut Pool<T0>, arg1: &mut Deposit<T0>, arg2: &mut Bank<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(arg0.active, 0);
        assert!(arg1.pool == 0x2::object::uid_to_address(&arg0.id), 7);
        assert!(arg2.pool == 0x2::object::uid_to_address(&arg0.id), 8);
        assert!(arg1.owner == 0x2::tx_context::sender(arg4), 9);
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, RewardConfig>(&mut arg0.reward_configs, &v0);
        let v2 = current_total_share(v1, arg0.total_share, arg0.total_boost_share);
        reward_to_credit<T0>(arg1, &v0, v1, v2, arg3);
        let v3 = share_in_the_reward_config<T0>(arg1, v1);
        update_debt<T0>(arg1, &v0, debt(v1, v3, v2, arg3));
        let v4 = extract_credit<T0>(arg1, &v0);
        let v5 = HarvestEvent<T0>{
            deposit     : 0x2::object::uid_to_address(&arg1.id),
            reward_type : v0,
            amount      : v4,
        };
        0x2::event::emit<HarvestEvent<T0>>(v5);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg2.balance, v4), arg4)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Setting{
            id      : 0x2::object::new(arg0),
            version : 1,
            pools   : 0x2::vec_map::empty<0x1::type_name::TypeName, address>(),
            boosts  : 0x2::vec_map::empty<address, u64>(),
        };
        0x2::transfer::share_object<Setting>(v0);
    }

    public(friend) fun migrate(arg0: &mut Setting) {
        assert!(arg0.version < 1, 6);
        let v0 = VersionUpdatedEvent{
            old : arg0.version,
            new : 1,
        };
        0x2::event::emit<VersionUpdatedEvent>(v0);
        arg0.version = 1;
    }

    fun now(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    public(friend) fun per_share_of_period(arg0: u64, arg1: u64, arg2: u64, arg3: u128) : u128 {
        if (arg1 <= arg0 || arg3 == 0) {
            0
        } else {
            ((arg1 - arg0) as u128) * (arg2 as u128) * 18446744073709551616 / (arg3 as u128)
        }
    }

    public(friend) fun remaining<T0>(arg0: &Pool<T0>, arg1: &Deposit<T0>, arg2: &0x2::clock::Clock) : 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64> {
        let v0 = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
        let v1 = 0;
        while (v1 < 0x2::vec_map::size<0x1::type_name::TypeName, RewardConfig>(&arg0.reward_configs)) {
            let (v2, v3) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, RewardConfig>(&arg0.reward_configs, v1);
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut v0, *v2, ((calculate_per_share_of_reward_config(v3.reward_rate_before, v3.rate_change_at, v3.reward_rate_after, v3.per_share, v3.last_update_time, current_total_share(v3, arg0.total_share, arg0.total_boost_share), now(arg2)) * (share_in_the_reward_config<T0>(arg1, v3) as u128) / 18446744073709551616) as u64) + (get_credit<T0>(arg1, v2) as u64) - get_debt<T0>(arg1, v2));
            v1 = v1 + 1;
        };
        v0
    }

    fun reward_to_credit<T0>(arg0: &mut Deposit<T0>, arg1: &0x1::type_name::TypeName, arg2: &mut RewardConfig, arg3: u128, arg4: &0x2::clock::Clock) {
        update_per_share(arg2, arg3, arg4);
        let v0 = get_reward<T0>(arg0, arg2, arg1);
        add_credit<T0>(arg0, arg1, v0);
    }

    fun rewards_to_credits<T0>(arg0: &mut Pool<T0>, arg1: &mut Deposit<T0>, arg2: &0x2::clock::Clock) {
        let v0 = 0;
        while (v0 < 0x2::vec_map::size<0x1::type_name::TypeName, RewardConfig>(&arg0.reward_configs)) {
            let (v1, v2, v3) = get_reward_config_info_by_idx_mut<T0>(arg0, v0);
            reward_to_credit<T0>(arg1, v1, v2, v3, arg2);
            v0 = v0 + 1;
        };
    }

    public(friend) fun set_boost(arg0: &mut Setting, arg1: address, arg2: u64) {
        update_boost(arg0, arg1, arg2);
        let v0 = SetBoostEvent{
            addr  : arg1,
            boost : arg2,
        };
        0x2::event::emit<SetBoostEvent>(v0);
    }

    public(friend) fun set_pool<T0>(arg0: &mut Pool<T0>, arg1: bool) {
        set_pool_active<T0>(arg0, arg1);
        let v0 = SetPoolEvent<T0>{
            pool   : 0x2::object::uid_to_address(&arg0.id),
            active : arg1,
        };
        0x2::event::emit<SetPoolEvent<T0>>(v0);
    }

    fun set_pool_active<T0>(arg0: &mut Pool<T0>, arg1: bool) {
        arg0.active = arg1;
    }

    public(friend) fun set_reward_config<T0, T1>(arg0: &mut Pool<T0>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(now(arg3) < arg1, 4);
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, RewardConfig>(&mut arg0.reward_configs, &v0);
        let v2 = current_total_share(v1, arg0.total_share, arg0.total_boost_share);
        update_reward_rate(v1, arg1, arg2, v2, arg3);
        let v3 = SetRewardConfigEvent<T0>{
            pool        : 0x2::object::uid_to_address(&arg0.id),
            reward_type : v0,
            reward_rate : arg2,
            start_at    : arg1,
        };
        0x2::event::emit<SetRewardConfigEvent<T0>>(v3);
    }

    public(friend) fun settle<T0>(arg0: &Setting, arg1: &mut Pool<T0>, arg2: &mut Deposit<T0>, arg3: &0x2::clock::Clock) {
        assert!(arg1.active, 0);
        assert!(arg2.pool == 0x2::object::uid_to_address(&arg1.id), 7);
        let v0 = arg2.debts;
        rewards_to_credits<T0>(arg1, arg2, arg3);
        let v1 = debts<T0>(arg1, arg2.amount, get_boost(arg0, &arg2.owner), arg3);
        arg2.debts = v1;
        let v2 = SettleEvent{
            pool      : 0x2::object::uid_to_address(&arg1.id),
            deposit   : 0x2::object::uid_to_address(&arg2.id),
            old_debts : v0,
            new_debts : arg2.debts,
        };
        0x2::event::emit<SettleEvent>(v2);
    }

    fun share_in_the_reward_config<T0>(arg0: &Deposit<T0>, arg1: &RewardConfig) : u128 {
        if (arg1.boost_active) {
            return arg0.boost_share
        };
        arg0.share
    }

    fun update_boost(arg0: &mut Setting, arg1: address, arg2: u64) {
        if (0x2::vec_map::contains<address, u64>(&arg0.boosts, &arg1)) {
            let (_, _) = 0x2::vec_map::remove<address, u64>(&mut arg0.boosts, &arg1);
        };
        if (arg2 != (1000 as u64)) {
            0x2::vec_map::insert<address, u64>(&mut arg0.boosts, arg1, arg2);
        };
    }

    fun update_debt<T0>(arg0: &mut Deposit<T0>, arg1: &0x1::type_name::TypeName, arg2: u64) {
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u64>(&arg0.debts, arg1)) {
            let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, u64>(&mut arg0.debts, arg1);
        };
        0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg0.debts, *arg1, arg2);
    }

    fun update_deposit_amount<T0>(arg0: &Setting, arg1: &mut Pool<T0>, arg2: &mut Deposit<T0>, arg3: u64, arg4: &0x2::clock::Clock) {
        rewards_to_credits<T0>(arg1, arg2, arg4);
        arg2.amount = arg3;
        update_share<T0>(arg2, arg0, arg1, false);
        arg2.debts = debts<T0>(arg1, arg2.amount, get_boost(arg0, &arg2.owner), arg4);
    }

    fun update_per_share(arg0: &mut RewardConfig, arg1: u128, arg2: &0x2::clock::Clock) {
        arg0.per_share = calculate_per_share_of_reward_config(arg0.reward_rate_before, arg0.rate_change_at, arg0.reward_rate_after, arg0.per_share, arg0.last_update_time, arg1, now(arg2));
        arg0.last_update_time = now(arg2);
    }

    fun update_reward_rate(arg0: &mut RewardConfig, arg1: u64, arg2: u64, arg3: u128, arg4: &0x2::clock::Clock) {
        update_per_share(arg0, arg3, arg4);
        if (now(arg4) > arg0.rate_change_at) {
            arg0.reward_rate_before = arg0.reward_rate_after;
        };
        arg0.rate_change_at = arg1;
        arg0.reward_rate_after = arg2;
    }

    fun update_share<T0>(arg0: &mut Deposit<T0>, arg1: &Setting, arg2: &mut Pool<T0>, arg3: bool) {
        let (v0, v1) = cal_share<T0>(arg0, arg1);
        if (!arg3) {
            arg2.total_share = arg2.total_share - arg0.share;
            arg2.total_boost_share = arg2.total_boost_share - arg0.boost_share;
        };
        arg0.share = v0;
        arg2.total_share = arg2.total_share + arg0.share;
        arg0.boost_share = v1;
        arg2.total_boost_share = arg2.total_boost_share + arg0.boost_share;
    }

    public(friend) fun withdraw<T0>(arg0: &Setting, arg1: &mut Pool<T0>, arg2: &mut Deposit<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1.active, 0);
        assert!(arg2.amount >= arg3, 3);
        assert!(arg2.pool == 0x2::object::uid_to_address(&arg1.id), 7);
        assert!(arg2.owner == 0x2::tx_context::sender(arg5), 9);
        let v0 = arg2.amount - arg3;
        update_deposit_amount<T0>(arg0, arg1, arg2, v0, arg4);
        let v1 = WithdrawEvent<T0>{
            deposit : 0x2::object::uid_to_address(&arg2.id),
            amount  : arg3,
        };
        0x2::event::emit<WithdrawEvent<T0>>(v1);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, arg3), arg5)
    }

    // decompiled from Move bytecode v6
}

