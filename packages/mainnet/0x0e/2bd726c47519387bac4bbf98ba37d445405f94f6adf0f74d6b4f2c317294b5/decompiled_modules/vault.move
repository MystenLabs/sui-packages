module 0x63d5fa6a5e173de759525146d52148a8aa38168d3daffbbbc0ad382487b7c1ec::vault {
    struct BackInRangeKey has copy, drop, store {
        dummy_field: bool,
    }

    struct RewardDebtKey has copy, drop, store {
        dummy_field: bool,
    }

    struct LossBudgetKey has copy, drop, store {
        dummy_field: bool,
    }

    struct LossBudgetConfigKey has copy, drop, store {
        dummy_field: bool,
    }

    struct LossBudget has copy, drop, store {
        spent_bps: u64,
        at_ms: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct KeeperCap has store, key {
        id: 0x2::object::UID,
        epoch: u64,
    }

    struct VaultOwnerCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        keeper_epoch: u64,
        allowed_pools: 0x2::vec_map::VecMap<0x2::object::ID, PoolConfig>,
        fee_bps: u64,
        affiliate_bps: u64,
        dev_address: address,
        max_loss_bps: u64,
        min_rebalance_interval_ms: u64,
        max_price_drift_bps: u64,
        max_range_move_ticks: u32,
    }

    struct PoolConfig has copy, drop, store {
        min_value_y: u256,
    }

    struct VaultConfig has copy, drop, store {
        width_ticks: u32,
        delay_ms: u64,
        auto_rebalance: bool,
        compound: bool,
    }

    struct Vault<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        version: u64,
        beneficiary: address,
        affiliate: 0x1::option::Option<address>,
        pool_id: 0x2::object::ID,
        position: 0x1::option::Option<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::position::Position>,
        balance_x: 0x2::balance::Balance<T0>,
        balance_y: 0x2::balance::Balance<T1>,
        config: VaultConfig,
        out_of_range_since_ms: u64,
        last_rebalance_ms: u64,
        rebalance_count: u64,
    }

    struct RebalanceTicket {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        old_position_id: 0x2::object::ID,
        value_before: u256,
        sqrt_price_snapshot: u128,
        width_ticks: u32,
        tick_spacing: u32,
        old_tick_lower: 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::i32::I32,
        old_tick_upper: 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::i32::I32,
    }

    struct VaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        width_ticks: u32,
        delay_ms: u64,
        auto_rebalance: bool,
        compound: bool,
    }

    struct Rebalanced has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        old_position_id: 0x2::object::ID,
        new_position_id: 0x2::object::ID,
        value_before: u256,
        value_after: u256,
        tick_lower: 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::i32::I32,
        tick_upper: 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::i32::I32,
        rebalance_count: u64,
        timestamp_ms: u64,
    }

    struct YieldSkimmed has copy, drop {
        vault_id: 0x2::object::ID,
        fee_x: u64,
        fee_y: u64,
        affiliate_x: u64,
        affiliate_y: u64,
        compounded: bool,
    }

    struct Withdrawn has copy, drop {
        vault_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        amount_x: u64,
        amount_y: u64,
    }

    struct PausedChanged has copy, drop {
        paused: bool,
    }

    struct PoolAllowed has copy, drop {
        pool_id: 0x2::object::ID,
        min_value_y: u256,
    }

    struct PoolDisallowed has copy, drop {
        pool_id: 0x2::object::ID,
    }

    struct KeepersRevoked has copy, drop {
        new_epoch: u64,
    }

    struct LossBudgetChanged has copy, drop {
        budget_bps: u64,
    }

    struct FeesChanged has copy, drop {
        fee_bps: u64,
        affiliate_bps: u64,
        dev_address: address,
    }

    struct RiskParamsChanged has copy, drop {
        max_loss_bps: u64,
        min_rebalance_interval_ms: u64,
        max_price_drift_bps: u64,
    }

    struct RewardPaid has copy, drop {
        vault_id: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        to_beneficiary: u64,
        fee: u64,
        affiliate: u64,
    }

    struct RewardCompounded has copy, drop {
        vault_id: 0x2::object::ID,
        is_token_x: bool,
        compounded: u64,
        fee: u64,
        affiliate: u64,
    }

    struct VaultDestroyed has copy, drop {
        vault_id: 0x2::object::ID,
    }

    struct ReferralRecorded has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        affiliate: address,
    }

    struct Migrated has copy, drop {
        from_version: u64,
        to_version: u64,
    }

    struct ConfigUpdated has copy, drop {
        vault_id: 0x2::object::ID,
        width_ticks: u32,
        delay_ms: u64,
        auto_rebalance: bool,
        compound: bool,
    }

    public fun affiliate<T0, T1>(arg0: &Vault<T0, T1>) : 0x1::option::Option<address> {
        arg0.affiliate
    }

    public fun allow_pool(arg0: &mut Registry, arg1: &AdminCap, arg2: 0x2::object::ID, arg3: u256) {
        assert_version(arg0);
        assert!(0x2::vec_map::length<0x2::object::ID, PoolConfig>(&arg0.allowed_pools) < 64, 19);
        let v0 = PoolConfig{min_value_y: arg3};
        if (0x2::vec_map::contains<0x2::object::ID, PoolConfig>(&arg0.allowed_pools, &arg2)) {
            *0x2::vec_map::get_mut<0x2::object::ID, PoolConfig>(&mut arg0.allowed_pools, &arg2) = v0;
        } else {
            0x2::vec_map::insert<0x2::object::ID, PoolConfig>(&mut arg0.allowed_pools, arg2, v0);
        };
        let v1 = PoolAllowed{
            pool_id     : arg2,
            min_value_y : arg3,
        };
        0x2::event::emit<PoolAllowed>(v1);
    }

    fun assert_cap<T0, T1>(arg0: &Vault<T0, T1>, arg1: &VaultOwnerCap) {
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1>>(arg0), 20);
    }

    fun assert_price_stable(arg0: u128, arg1: u128, arg2: u64) {
        let (v0, v1) = if (arg1 >= arg0) {
            (arg0, arg1)
        } else {
            (arg1, arg0)
        };
        assert!(v0 > 0, 14);
        assert!(((v1 - v0) as u256) * (10000 as u256) / (v0 as u256) <= (arg2 as u256), 14);
    }

    fun assert_version(arg0: &Registry) {
        assert!(arg0.version == 5, 23);
    }

    fun assert_width_valid(arg0: u32, arg1: u32) {
        assert!(arg1 > 0, 18);
        assert!(arg0 > 0 && arg0 % arg1 == 0, 18);
        assert!(arg0 <= 887272, 25);
    }

    public fun auto_rebalance(arg0: &VaultConfig) : bool {
        arg0.auto_rebalance
    }

    fun bank_yield<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &Registry, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>) {
        if (0x2::balance::value<T0>(&arg2) == 0 && 0x2::balance::value<T1>(&arg3) == 0) {
            0x2::balance::destroy_zero<T0>(arg2);
            0x2::balance::destroy_zero<T1>(arg3);
            return
        };
        let v0 = &mut arg2;
        let (v1, v2) = split_fee<T0>(arg1, &arg0.affiliate, v0);
        let v3 = &mut arg3;
        let (v4, v5) = split_fee<T1>(arg1, &arg0.affiliate, v3);
        let v6 = YieldSkimmed{
            vault_id    : 0x2::object::id<Vault<T0, T1>>(arg0),
            fee_x       : v1,
            fee_y       : v4,
            affiliate_x : v2,
            affiliate_y : v5,
            compounded  : arg0.config.compound,
        };
        0x2::event::emit<YieldSkimmed>(v6);
        if (!arg0.config.compound) {
            let v7 = arg0.beneficiary;
            send_balance<T0>(arg2, v7);
            send_balance<T1>(arg3, v7);
            return
        };
        0x2::balance::join<T0>(&mut arg0.balance_x, arg2);
        0x2::balance::join<T1>(&mut arg0.balance_y, arg3);
    }

    public fun begin_rebalance<T0, T1>(arg0: &Registry, arg1: &mut Vault<T0, T1>, arg2: &KeeperCap, arg3: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock) : (0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::position::Position, RebalanceTicket) {
        abort 30
    }

    public fun begin_rebalance_as_owner<T0, T1>(arg0: &Registry, arg1: &mut Vault<T0, T1>, arg2: &VaultOwnerCap, arg3: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock) : (0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::position::Position, RebalanceTicket) {
        abort 30
    }

    public fun begin_rebalance_as_owner_v2<T0, T1>(arg0: &Registry, arg1: &mut Vault<T0, T1>, arg2: &VaultOwnerCap, arg3: &mut 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::version::Version, arg6: &mut 0x2::tx_context::TxContext) : (0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::position::Position, RebalanceTicket) {
        assert_cap<T0, T1>(arg1, arg2);
        assert!(arg1.out_of_range_since_ms != 0, 9);
        assert!(0x2::clock::timestamp_ms(arg4) >= arg1.out_of_range_since_ms + 300000, 9);
        begin_rebalance_inner<T0, T1>(arg0, arg1, arg3, arg4, arg5, arg6)
    }

    fun begin_rebalance_inner<T0, T1>(arg0: &Registry, arg1: &mut Vault<T0, T1>, arg2: &mut 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::version::Version, arg5: &mut 0x2::tx_context::TxContext) : (0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::position::Position, RebalanceTicket) {
        assert_version(arg0);
        assert!(!arg0.paused, 2);
        assert!(0x2::object::id<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>>(arg2) == arg1.pool_id, 5);
        assert!(0x2::vec_map::contains<0x2::object::ID, PoolConfig>(&arg0.allowed_pools, &arg1.pool_id), 4);
        assert!(0x1::option::is_some<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::position::Position>(&arg1.position), 16);
        assert!(0x2::clock::timestamp_ms(arg3) >= arg1.last_rebalance_ms + arg0.min_rebalance_interval_ms, 10);
        assert!(!is_in_range<T0, T1>(arg2, 0x1::option::borrow<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::position::Position>(&arg1.position)), 8);
        let v0 = 0x1::option::extract<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::position::Position>(&mut arg1.position);
        let (v1, v2) = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::collect::fee<T0, T1>(arg2, &mut v0, arg3, arg4, arg5);
        bank_yield<T0, T1>(arg1, arg0, 0x2::coin::into_balance<T0>(v1), 0x2::coin::into_balance<T1>(v2));
        let v3 = vector[];
        let v4 = 0;
        while (v4 < 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::position::reward_length(&v0)) {
            let v5 = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::position::coins_owed_reward(&v0, v4);
            if (v5 > 0) {
                0x1::vector::push_back<u64>(&mut v3, v5);
            };
            v4 = v4 + 1;
        };
        let v6 = RewardDebtKey{dummy_field: false};
        if (0x2::dynamic_field::exists<RewardDebtKey>(&arg1.id, v6)) {
            let v7 = RewardDebtKey{dummy_field: false};
            0x2::dynamic_field::remove<RewardDebtKey, vector<u64>>(&mut arg1.id, v7);
        };
        let v8 = RewardDebtKey{dummy_field: false};
        0x2::dynamic_field::add<RewardDebtKey, vector<u64>>(&mut arg1.id, v8, v3);
        let v9 = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::sqrt_price<T0, T1>(arg2);
        let v10 = RebalanceTicket{
            vault_id            : 0x2::object::id<Vault<T0, T1>>(arg1),
            pool_id             : arg1.pool_id,
            old_position_id     : 0x2::object::id<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::position::Position>(&v0),
            value_before        : position_value_in_y(v9, &v0) + idle_value_in_y<T0, T1>(arg1, v9),
            sqrt_price_snapshot : v9,
            width_ticks         : arg1.config.width_ticks,
            tick_spacing        : 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::tick_spacing<T0, T1>(arg2),
            old_tick_lower      : 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::position::tick_lower_index(&v0),
            old_tick_upper      : 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::position::tick_upper_index(&v0),
        };
        (v0, v10)
    }

    public fun begin_rebalance_v2<T0, T1>(arg0: &Registry, arg1: &mut Vault<T0, T1>, arg2: &KeeperCap, arg3: &mut 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::version::Version, arg6: &mut 0x2::tx_context::TxContext) : (0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::position::Position, RebalanceTicket) {
        assert!(arg2.epoch == arg0.keeper_epoch, 3);
        assert!(arg1.config.auto_rebalance, 7);
        assert!(arg1.out_of_range_since_ms != 0, 9);
        assert!(0x2::clock::timestamp_ms(arg4) >= arg1.out_of_range_since_ms + arg1.config.delay_ms, 9);
        begin_rebalance_inner<T0, T1>(arg0, arg1, arg3, arg4, arg5, arg6)
    }

    public fun beneficiary<T0, T1>(arg0: &Vault<T0, T1>) : address {
        arg0.beneficiary
    }

    fun charge_loss_budget<T0, T1>(arg0: &Registry, arg1: &mut Vault<T0, T1>, arg2: u64, arg3: u64) {
        let v0 = loss_budget_bps(arg0);
        let v1 = LossBudgetKey{dummy_field: false};
        let v2 = if (0x2::dynamic_field::exists<LossBudgetKey>(&arg1.id, v1)) {
            let v3 = LossBudgetKey{dummy_field: false};
            *0x2::dynamic_field::borrow<LossBudgetKey, LossBudget>(&arg1.id, v3)
        } else {
            LossBudget{spent_bps: 0, at_ms: arg3}
        };
        let v4 = v2;
        let v5 = if (arg3 > v4.at_ms) {
            arg3 - v4.at_ms
        } else {
            0
        };
        let v6 = mul_div_to_u64(v0, v5, 86400000);
        let v7 = if (v6 >= v4.spent_bps) {
            0
        } else {
            v4.spent_bps - v6
        };
        assert!(v7 + arg2 <= v0, 34);
        let v8 = LossBudget{
            spent_bps : v7 + arg2,
            at_ms     : arg3,
        };
        let v9 = LossBudgetKey{dummy_field: false};
        if (0x2::dynamic_field::exists<LossBudgetKey>(&arg1.id, v9)) {
            let v10 = LossBudgetKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<LossBudgetKey, LossBudget>(&mut arg1.id, v10) = v8;
        } else {
            let v11 = LossBudgetKey{dummy_field: false};
            0x2::dynamic_field::add<LossBudgetKey, LossBudget>(&mut arg1.id, v11, v8);
        };
    }

    fun claim_into_balance<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: &VaultOwnerCap, arg2: &Registry, arg3: &mut 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::version::Version, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T2> {
        assert_version(arg2);
        assert_cap<T0, T1>(arg0, arg1);
        assert!(0x2::object::id<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>>(arg3) == arg0.pool_id, 5);
        assert!(0x1::option::is_some<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::position::Position>(&arg0.position), 16);
        0x2::coin::into_balance<T2>(0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::collect::reward<T0, T1, T2>(arg3, 0x1::option::borrow_mut<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::position::Position>(&mut arg0.position), arg4, arg5, arg6))
    }

    public fun claim_reward<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: &VaultOwnerCap, arg2: &Registry, arg3: &mut 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!reward_is_pool_token<T0, T1, T2>(), 29);
        let v0 = claim_into_balance<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        let v1 = &mut v0;
        let (v2, v3) = split_fee<T2>(arg2, &arg0.affiliate, v1);
        let v4 = RewardPaid{
            vault_id       : 0x2::object::id<Vault<T0, T1>>(arg0),
            reward_type    : 0x1::type_name::with_defining_ids<T2>(),
            to_beneficiary : 0x2::balance::value<T2>(&v0),
            fee            : v2,
            affiliate      : v3,
        };
        0x2::event::emit<RewardPaid>(v4);
        send_balance<T2>(v0, arg0.beneficiary);
    }

    public fun claim_reward_x<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &VaultOwnerCap, arg2: &Registry, arg3: &mut 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = claim_into_balance<T0, T1, T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        let v1 = &mut v0;
        let (v2, v3) = split_fee<T0>(arg2, &arg0.affiliate, v1);
        if (arg0.config.compound) {
            let v4 = RewardCompounded{
                vault_id   : 0x2::object::id<Vault<T0, T1>>(arg0),
                is_token_x : true,
                compounded : 0x2::balance::value<T0>(&v0),
                fee        : v2,
                affiliate  : v3,
            };
            0x2::event::emit<RewardCompounded>(v4);
            0x2::balance::join<T0>(&mut arg0.balance_x, v0);
        } else {
            let v5 = RewardPaid{
                vault_id       : 0x2::object::id<Vault<T0, T1>>(arg0),
                reward_type    : 0x1::type_name::with_defining_ids<T0>(),
                to_beneficiary : 0x2::balance::value<T0>(&v0),
                fee            : v2,
                affiliate      : v3,
            };
            0x2::event::emit<RewardPaid>(v5);
            send_balance<T0>(v0, arg0.beneficiary);
        };
    }

    public fun claim_reward_y<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &VaultOwnerCap, arg2: &Registry, arg3: &mut 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = claim_into_balance<T0, T1, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        let v1 = &mut v0;
        let (v2, v3) = split_fee<T1>(arg2, &arg0.affiliate, v1);
        if (arg0.config.compound) {
            let v4 = RewardCompounded{
                vault_id   : 0x2::object::id<Vault<T0, T1>>(arg0),
                is_token_x : false,
                compounded : 0x2::balance::value<T1>(&v0),
                fee        : v2,
                affiliate  : v3,
            };
            0x2::event::emit<RewardCompounded>(v4);
            0x2::balance::join<T1>(&mut arg0.balance_y, v0);
        } else {
            let v5 = RewardPaid{
                vault_id       : 0x2::object::id<Vault<T0, T1>>(arg0),
                reward_type    : 0x1::type_name::with_defining_ids<T1>(),
                to_beneficiary : 0x2::balance::value<T1>(&v0),
                fee            : v2,
                affiliate      : v3,
            };
            0x2::event::emit<RewardPaid>(v5);
            send_balance<T1>(v0, arg0.beneficiary);
        };
    }

    public fun compound(arg0: &VaultConfig) : bool {
        arg0.compound
    }

    public fun compound_reward_x<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &RebalanceTicket, arg2: &Registry, arg3: 0x2::coin::Coin<T0>) {
        assert_version(arg2);
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1>>(arg0), 6);
        settle_reward_debt<T0, T1>(arg0, 0x2::coin::value<T0>(&arg3));
        let v0 = 0x2::coin::into_balance<T0>(arg3);
        let v1 = &mut v0;
        let (v2, v3) = split_fee<T0>(arg2, &arg0.affiliate, v1);
        let v4 = RewardCompounded{
            vault_id   : 0x2::object::id<Vault<T0, T1>>(arg0),
            is_token_x : true,
            compounded : 0x2::balance::value<T0>(&v0),
            fee        : v2,
            affiliate  : v3,
        };
        0x2::event::emit<RewardCompounded>(v4);
        if (arg0.config.compound) {
            0x2::balance::join<T0>(&mut arg0.balance_x, v0);
        } else {
            send_balance<T0>(v0, arg0.beneficiary);
        };
    }

    public fun compound_reward_y<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &RebalanceTicket, arg2: &Registry, arg3: 0x2::coin::Coin<T1>) {
        assert_version(arg2);
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1>>(arg0), 6);
        settle_reward_debt<T0, T1>(arg0, 0x2::coin::value<T1>(&arg3));
        let v0 = 0x2::coin::into_balance<T1>(arg3);
        let v1 = &mut v0;
        let (v2, v3) = split_fee<T1>(arg2, &arg0.affiliate, v1);
        let v4 = RewardCompounded{
            vault_id   : 0x2::object::id<Vault<T0, T1>>(arg0),
            is_token_x : false,
            compounded : 0x2::balance::value<T1>(&v0),
            fee        : v2,
            affiliate  : v3,
        };
        0x2::event::emit<RewardCompounded>(v4);
        if (arg0.config.compound) {
            0x2::balance::join<T1>(&mut arg0.balance_y, v0);
        } else {
            send_balance<T1>(v0, arg0.beneficiary);
        };
    }

    public fun config<T0, T1>(arg0: &Vault<T0, T1>) : VaultConfig {
        arg0.config
    }

    public fun delay_ms(arg0: &VaultConfig) : u64 {
        arg0.delay_ms
    }

    public fun deposit<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>) {
        0x2::balance::join<T0>(&mut arg0.balance_x, 0x2::coin::into_balance<T0>(arg1));
        0x2::balance::join<T1>(&mut arg0.balance_y, 0x2::coin::into_balance<T1>(arg2));
    }

    public fun destroy_admin_cap(arg0: AdminCap, arg1: &AdminCap) {
        let AdminCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public fun destroy_empty_vault<T0, T1>(arg0: Vault<T0, T1>, arg1: VaultOwnerCap) {
        let v0 = 0x2::object::id<Vault<T0, T1>>(&arg0);
        assert!(arg1.vault_id == v0, 20);
        let v1 = &mut arg0;
        drop_dynamic_state<T0, T1>(v1);
        let Vault {
            id                    : v2,
            version               : _,
            beneficiary           : _,
            affiliate             : _,
            pool_id               : _,
            position              : v7,
            balance_x             : v8,
            balance_y             : v9,
            config                : _,
            out_of_range_since_ms : _,
            last_rebalance_ms     : _,
            rebalance_count       : _,
        } = arg0;
        let v14 = v9;
        let v15 = v8;
        let v16 = v7;
        assert!(0x1::option::is_none<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::position::Position>(&v16), 21);
        assert!(0x2::balance::value<T0>(&v15) == 0 && 0x2::balance::value<T1>(&v14) == 0, 21);
        0x1::option::destroy_none<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::position::Position>(v16);
        0x2::balance::destroy_zero<T0>(v15);
        0x2::balance::destroy_zero<T1>(v14);
        let v17 = VaultDestroyed{vault_id: v0};
        0x2::event::emit<VaultDestroyed>(v17);
        0x2::object::delete(v2);
        let VaultOwnerCap {
            id       : v18,
            vault_id : _,
        } = arg1;
        0x2::object::delete(v18);
    }

    public fun destroy_empty_vault_v2<T0, T1>(arg0: Vault<T0, T1>, arg1: VaultOwnerCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<Vault<T0, T1>>(&arg0);
        assert!(arg1.vault_id == v0, 20);
        let v1 = &mut arg0;
        drop_dynamic_state<T0, T1>(v1);
        let Vault {
            id                    : v2,
            version               : _,
            beneficiary           : _,
            affiliate             : _,
            pool_id               : _,
            position              : v7,
            balance_x             : v8,
            balance_y             : v9,
            config                : _,
            out_of_range_since_ms : _,
            last_rebalance_ms     : _,
            rebalance_count       : _,
        } = arg0;
        let v14 = v7;
        assert!(0x1::option::is_none<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::position::Position>(&v14), 21);
        0x1::option::destroy_none<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::position::Position>(v14);
        let v15 = 0x2::tx_context::sender(arg2);
        send_balance<T0>(v8, v15);
        send_balance<T1>(v9, v15);
        let v16 = VaultDestroyed{vault_id: v0};
        0x2::event::emit<VaultDestroyed>(v16);
        0x2::object::delete(v2);
        let VaultOwnerCap {
            id       : v17,
            vault_id : _,
        } = arg1;
        0x2::object::delete(v17);
    }

    public fun destroy_keeper_cap(arg0: KeeperCap) {
        let KeeperCap {
            id    : v0,
            epoch : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun disallow_pool(arg0: &mut Registry, arg1: &AdminCap, arg2: 0x2::object::ID) {
        assert_version(arg0);
        if (0x2::vec_map::contains<0x2::object::ID, PoolConfig>(&arg0.allowed_pools, &arg2)) {
            let (_, _) = 0x2::vec_map::remove<0x2::object::ID, PoolConfig>(&mut arg0.allowed_pools, &arg2);
            let v2 = PoolDisallowed{pool_id: arg2};
            0x2::event::emit<PoolDisallowed>(v2);
        };
    }

    fun drop_dynamic_state<T0, T1>(arg0: &mut Vault<T0, T1>) {
        let v0 = BackInRangeKey{dummy_field: false};
        if (0x2::dynamic_field::exists<BackInRangeKey>(&arg0.id, v0)) {
            let v1 = BackInRangeKey{dummy_field: false};
            0x2::dynamic_field::remove<BackInRangeKey, u64>(&mut arg0.id, v1);
        };
        let v2 = RewardDebtKey{dummy_field: false};
        if (0x2::dynamic_field::exists<RewardDebtKey>(&arg0.id, v2)) {
            let v3 = RewardDebtKey{dummy_field: false};
            0x2::dynamic_field::remove<RewardDebtKey, vector<u64>>(&mut arg0.id, v3);
        };
    }

    public fun end_rebalance<T0, T1>(arg0: &Registry, arg1: &mut Vault<T0, T1>, arg2: RebalanceTicket, arg3: 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::position::Position, arg4: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg5: &0x2::clock::Clock) {
        let RebalanceTicket {
            vault_id            : v0,
            pool_id             : v1,
            old_position_id     : v2,
            value_before        : v3,
            sqrt_price_snapshot : v4,
            width_ticks         : v5,
            tick_spacing        : v6,
            old_tick_lower      : v7,
            old_tick_upper      : v8,
        } = arg2;
        assert_version(arg0);
        assert!(v0 == 0x2::object::id<Vault<T0, T1>>(arg1), 6);
        assert!(0x2::object::id<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>>(arg4) == v1, 5);
        assert!(0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::position::pool_id(&arg3) == v1, 5);
        assert_price_stable(v4, 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::sqrt_price<T0, T1>(arg4), arg0.max_price_drift_bps);
        let v9 = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::position::tick_lower_index(&arg3);
        let v10 = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::position::tick_upper_index(&arg3);
        assert!(0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::i32::abs_u32(0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::i32::sub(v10, v9)) == v5, 12);
        assert!(!range_unchanged(v9, v10, v7, v8), 28);
        let v11 = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::tick_index_current<T0, T1>(arg4);
        let v12 = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::i32::from(v6);
        assert!(0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::i32::abs_u32(0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::i32::sub(v9, v7)) <= arg0.max_range_move_ticks && 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::i32::abs_u32(0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::i32::sub(v10, v8)) <= arg0.max_range_move_ticks, 27);
        assert!(0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::i32::lte(v9, 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::i32::add(v11, v12)), 13);
        assert!(0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::i32::gte(0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::i32::add(v10, v12), v11), 13);
        assert!(0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::i32::lt(v11, v9) || 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::i32::gte(v11, v10), 22);
        let v13 = value_of(&arg3, v4) + idle_value_in_y<T0, T1>(arg1, v4);
        assert!(v13 >= v3 * ((10000 - arg0.max_loss_bps) as u256) / (10000 as u256), 11);
        let v14 = 0x2::clock::timestamp_ms(arg5);
        charge_loss_budget<T0, T1>(arg0, arg1, loss_bps(v3, v13), v14);
        let v15 = RewardDebtKey{dummy_field: false};
        let v16 = 0x2::dynamic_field::remove<RewardDebtKey, vector<u64>>(&mut arg1.id, v15);
        assert!(0x1::vector::is_empty<u64>(&v16), 31);
        0x1::option::fill<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::position::Position>(&mut arg1.position, arg3);
        arg1.last_rebalance_ms = v14;
        arg1.rebalance_count = arg1.rebalance_count + 1;
        let v17 = if (is_in_range<T0, T1>(arg4, 0x1::option::borrow<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::position::Position>(&arg1.position))) {
            0
        } else {
            v14
        };
        arg1.out_of_range_since_ms = v17;
        let v18 = BackInRangeKey{dummy_field: false};
        if (0x2::dynamic_field::exists<BackInRangeKey>(&arg1.id, v18)) {
            let v19 = BackInRangeKey{dummy_field: false};
            0x2::dynamic_field::remove<BackInRangeKey, u64>(&mut arg1.id, v19);
        };
        let v20 = Rebalanced{
            vault_id        : v0,
            pool_id         : v1,
            old_position_id : v2,
            new_position_id : 0x2::object::id<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::position::Position>(&arg3),
            value_before    : v3,
            value_after     : v13,
            tick_lower      : v9,
            tick_upper      : v10,
            rebalance_count : arg1.rebalance_count,
            timestamp_ms    : v14,
        };
        0x2::event::emit<Rebalanced>(v20);
    }

    public fun harvest<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &VaultOwnerCap, arg2: &Registry, arg3: &mut 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        assert_version(arg2);
        assert_cap<T0, T1>(arg0, arg1);
        assert!(0x2::object::id<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>>(arg3) == arg0.pool_id, 5);
        assert!(0x1::option::is_some<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::position::Position>(&arg0.position), 16);
        let (v0, v1) = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::collect::fee<T0, T1>(arg3, 0x1::option::borrow_mut<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::position::Position>(&mut arg0.position), arg4, arg5, arg6);
        let v2 = 0x2::coin::into_balance<T0>(v0);
        let v3 = 0x2::coin::into_balance<T1>(v1);
        let v4 = &mut v2;
        let (v5, v6) = split_fee<T0>(arg2, &arg0.affiliate, v4);
        let v7 = &mut v3;
        let (v8, v9) = split_fee<T1>(arg2, &arg0.affiliate, v7);
        let v10 = YieldSkimmed{
            vault_id    : 0x2::object::id<Vault<T0, T1>>(arg0),
            fee_x       : v5,
            fee_y       : v8,
            affiliate_x : v6,
            affiliate_y : v9,
            compounded  : arg0.config.compound,
        };
        0x2::event::emit<YieldSkimmed>(v10);
        if (arg0.config.compound) {
            0x2::balance::join<T0>(&mut arg0.balance_x, v2);
            0x2::balance::join<T1>(&mut arg0.balance_y, v3);
        } else {
            let v11 = arg0.beneficiary;
            send_balance<T0>(v2, v11);
            send_balance<T1>(v3, v11);
        };
    }

    public fun idle_balances<T0, T1>(arg0: &Vault<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.balance_x), 0x2::balance::value<T1>(&arg0.balance_y))
    }

    fun idle_value_in_y<T0, T1>(arg0: &Vault<T0, T1>, arg1: u128) : u256 {
        value_in_y(0x2::balance::value<T0>(&arg0.balance_x), 0x2::balance::value<T1>(&arg0.balance_y), arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = Registry{
            id                        : 0x2::object::new(arg0),
            version                   : 5,
            paused                    : false,
            keeper_epoch              : 0,
            allowed_pools             : 0x2::vec_map::empty<0x2::object::ID, PoolConfig>(),
            fee_bps                   : 800,
            affiliate_bps             : 300,
            dev_address               : 0x2::tx_context::sender(arg0),
            max_loss_bps              : 100,
            min_rebalance_interval_ms : 3600000,
            max_price_drift_bps       : 100,
            max_range_move_ticks      : 5000,
        };
        0x2::transfer::share_object<Registry>(v1);
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    fun is_in_range<T0, T1>(arg0: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg1: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::position::Position) : bool {
        let v0 = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::tick_index_current<T0, T1>(arg0);
        0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::i32::lte(0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::position::tick_lower_index(arg1), v0) && 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::i32::lt(v0, 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::position::tick_upper_index(arg1))
    }

    public fun is_paused(arg0: &Registry) : bool {
        arg0.paused
    }

    fun loss_bps(arg0: u256, arg1: u256) : u64 {
        if (arg1 >= arg0 || arg0 == 0) {
            return 0
        };
        let v0 = ((arg0 - arg1) * 10000 + arg0 - 1) / arg0;
        if (v0 > 10000) {
            10000
        } else {
            (v0 as u64)
        }
    }

    public fun loss_budget_bps(arg0: &Registry) : u64 {
        let v0 = LossBudgetConfigKey{dummy_field: false};
        if (0x2::dynamic_field::exists<LossBudgetConfigKey>(&arg0.id, v0)) {
            let v2 = LossBudgetConfigKey{dummy_field: false};
            *0x2::dynamic_field::borrow<LossBudgetConfigKey, u64>(&arg0.id, v2)
        } else {
            200
        }
    }

    public fun loss_budget_spent<T0, T1>(arg0: &Vault<T0, T1>, arg1: &Registry, arg2: u64) : u64 {
        let v0 = LossBudgetKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<LossBudgetKey>(&arg0.id, v0)) {
            return 0
        };
        let v1 = LossBudgetKey{dummy_field: false};
        let v2 = *0x2::dynamic_field::borrow<LossBudgetKey, LossBudget>(&arg0.id, v1);
        let v3 = if (arg2 > v2.at_ms) {
            arg2 - v2.at_ms
        } else {
            0
        };
        let v4 = mul_div_to_u64(loss_budget_bps(arg1), v3, 86400000);
        if (v4 >= v2.spent_bps) {
            0
        } else {
            v2.spent_bps - v4
        }
    }

    public fun migrate(arg0: &mut Registry, arg1: &AdminCap) {
        assert!(arg0.version < 5, 24);
        arg0.version = 5;
        let v0 = Migrated{
            from_version : arg0.version,
            to_version   : 5,
        };
        0x2::event::emit<Migrated>(v0);
    }

    public fun migrate_vault<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &AdminCap) {
        assert!(arg0.version < 5, 24);
        arg0.version = 5;
    }

    public fun mint_admin_cap(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) : AdminCap {
        AdminCap{id: 0x2::object::new(arg1)}
    }

    public fun mint_keeper_cap(arg0: &Registry, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) : KeeperCap {
        assert_version(arg0);
        KeeperCap{
            id    : 0x2::object::new(arg2),
            epoch : arg0.keeper_epoch,
        }
    }

    fun mul_div_to_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg1 == 0 || arg0 == 0) {
            return 0
        };
        let v0 = (arg0 as u128) * (arg1 as u128) / (arg2 as u128);
        assert!(v0 <= 18446744073709551615, 26);
        (v0 as u64)
    }

    public fun new_vault<T0, T1>(arg0: &Registry, arg1: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg2: 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::position::Position, arg3: u32, arg4: u64, arg5: bool, arg6: bool, arg7: 0x1::option::Option<address>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : VaultOwnerCap {
        assert_version(arg0);
        assert!(!arg0.paused, 2);
        let v0 = 0x2::object::id<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>>(arg1);
        assert!(0x2::vec_map::contains<0x2::object::ID, PoolConfig>(&arg0.allowed_pools, &v0), 4);
        assert!(0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::position::pool_id(&arg2) == v0, 5);
        assert_width_valid(arg3, 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::tick_spacing<T0, T1>(arg1));
        let v1 = if (0x1::option::is_some<address>(&arg7) && *0x1::option::borrow<address>(&arg7) == 0x2::tx_context::sender(arg9)) {
            0x1::option::none<address>()
        } else {
            arg7
        };
        if (arg5) {
            assert!(position_value_in_y(0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::sqrt_price<T0, T1>(arg1), &arg2) >= pool_min_value(arg0, &v0), 15);
        };
        let v2 = VaultConfig{
            width_ticks    : arg3,
            delay_ms       : arg4,
            auto_rebalance : arg5,
            compound       : arg6,
        };
        let v3 = Vault<T0, T1>{
            id                    : 0x2::object::new(arg9),
            version               : 5,
            beneficiary           : 0x2::tx_context::sender(arg9),
            affiliate             : v1,
            pool_id               : v0,
            position              : 0x1::option::some<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::position::Position>(arg2),
            balance_x             : 0x2::balance::zero<T0>(),
            balance_y             : 0x2::balance::zero<T1>(),
            config                : v2,
            out_of_range_since_ms : 0,
            last_rebalance_ms     : 0x2::clock::timestamp_ms(arg8),
            rebalance_count       : 0,
        };
        let v4 = 0x2::object::id<Vault<T0, T1>>(&v3);
        let v5 = VaultOwnerCap{
            id       : 0x2::object::new(arg9),
            vault_id : v4,
        };
        let v6 = VaultCreated{
            vault_id       : v4,
            owner          : v3.beneficiary,
            pool_id        : v0,
            position_id    : 0x2::object::id<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::position::Position>(&arg2),
            width_ticks    : arg3,
            delay_ms       : arg4,
            auto_rebalance : arg5,
            compound       : arg6,
        };
        0x2::event::emit<VaultCreated>(v6);
        if (0x1::option::is_some<address>(&v3.affiliate)) {
            let v7 = ReferralRecorded{
                vault_id  : v4,
                owner     : v3.beneficiary,
                affiliate : *0x1::option::borrow<address>(&v3.affiliate),
            };
            0x2::event::emit<ReferralRecorded>(v7);
        };
        0x2::transfer::share_object<Vault<T0, T1>>(v3);
        v5
    }

    fun oor_transition(arg0: bool, arg1: u64, arg2: 0x1::option::Option<u64>, arg3: u64) : (bool, u8) {
        if (!arg0) {
            let v0 = if (0x1::option::is_some<u64>(&arg2)) {
                2
            } else {
                0
            };
            return (false, v0)
        };
        if (arg1 == 0) {
            return (false, 0)
        };
        if (0x1::option::is_none<u64>(&arg2)) {
            return (false, 1)
        };
        if (arg3 >= *0x1::option::borrow<u64>(&arg2) + 300000) {
            (true, 2)
        } else {
            (false, 0)
        }
    }

    public fun out_of_range_since_ms<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.out_of_range_since_ms
    }

    public fun payout_reward<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: &RebalanceTicket, arg2: &Registry, arg3: 0x2::coin::Coin<T2>) {
        assert_version(arg2);
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1>>(arg0), 6);
        settle_reward_debt<T0, T1>(arg0, 0x2::coin::value<T2>(&arg3));
        let v0 = 0x2::coin::into_balance<T2>(arg3);
        let v1 = &mut v0;
        let (v2, v3) = split_fee<T2>(arg2, &arg0.affiliate, v1);
        let v4 = RewardPaid{
            vault_id       : 0x2::object::id<Vault<T0, T1>>(arg0),
            reward_type    : 0x1::type_name::with_defining_ids<T2>(),
            to_beneficiary : 0x2::balance::value<T2>(&v0),
            fee            : v2,
            affiliate      : v3,
        };
        0x2::event::emit<RewardPaid>(v4);
        send_balance<T2>(v0, arg0.beneficiary);
    }

    public fun pool_allowed(arg0: &Registry, arg1: 0x2::object::ID) : bool {
        0x2::vec_map::contains<0x2::object::ID, PoolConfig>(&arg0.allowed_pools, &arg1)
    }

    public fun pool_id<T0, T1>(arg0: &Vault<T0, T1>) : 0x2::object::ID {
        arg0.pool_id
    }

    fun pool_min_value(arg0: &Registry, arg1: &0x2::object::ID) : u256 {
        0x2::vec_map::get<0x2::object::ID, PoolConfig>(&arg0.allowed_pools, arg1).min_value_y
    }

    public fun pool_min_value_y(arg0: &Registry, arg1: 0x2::object::ID) : u256 {
        0x2::vec_map::get<0x2::object::ID, PoolConfig>(&arg0.allowed_pools, &arg1).min_value_y
    }

    fun position_value_in_y(arg0: u128, arg1: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::position::Position) : u256 {
        value_of(arg1, arg0)
    }

    fun range_unchanged(arg0: 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::i32::I32, arg1: 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::i32::I32, arg2: 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::i32::I32, arg3: 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::i32::I32) : bool {
        0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::i32::eq(arg0, arg2) && 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::i32::eq(arg1, arg3)
    }

    public fun rebalance_count<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.rebalance_count
    }

    fun remove_first_at_most(arg0: &mut vector<u64>, arg1: u64) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(arg0)) {
            if (*0x1::vector::borrow<u64>(arg0, v0) <= arg1) {
                0x1::vector::remove<u64>(arg0, v0);
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun return_idle<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &RebalanceTicket, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>) {
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1>>(arg0), 6);
        0x2::balance::join<T0>(&mut arg0.balance_x, 0x2::coin::into_balance<T0>(arg2));
        0x2::balance::join<T1>(&mut arg0.balance_y, 0x2::coin::into_balance<T1>(arg3));
    }

    public fun revoke_keepers(arg0: &mut Registry, arg1: &AdminCap) {
        assert_version(arg0);
        arg0.keeper_epoch = arg0.keeper_epoch + 1;
        let v0 = KeepersRevoked{new_epoch: arg0.keeper_epoch};
        0x2::event::emit<KeepersRevoked>(v0);
    }

    fun reward_is_pool_token<T0, T1, T2>() : bool {
        let v0 = 0x1::type_name::with_defining_ids<T2>();
        v0 == 0x1::type_name::with_defining_ids<T0>() || v0 == 0x1::type_name::with_defining_ids<T1>()
    }

    fun send_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
            return
        };
        0x2::balance::send_funds<T0>(arg0, arg1);
    }

    public fun set_beneficiary<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &VaultOwnerCap, arg2: address) {
        assert_cap<T0, T1>(arg0, arg1);
        arg0.beneficiary = arg2;
    }

    public fun set_config<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &VaultOwnerCap, arg2: &Registry, arg3: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg4: u32, arg5: u64, arg6: bool, arg7: bool) {
        assert_version(arg2);
        assert_cap<T0, T1>(arg0, arg1);
        assert!(0x2::object::id<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>>(arg3) == arg0.pool_id, 5);
        assert_width_valid(arg4, 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::tick_spacing<T0, T1>(arg3));
        if (arg6 && !arg0.config.auto_rebalance) {
            assert!(!arg2.paused, 2);
            assert!(0x2::vec_map::contains<0x2::object::ID, PoolConfig>(&arg2.allowed_pools, &arg0.pool_id), 4);
            assert!(total_value_in_y<T0, T1>(arg0, 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::sqrt_price<T0, T1>(arg3)) >= pool_min_value(arg2, &arg0.pool_id), 15);
        };
        let v0 = VaultConfig{
            width_ticks    : arg4,
            delay_ms       : arg5,
            auto_rebalance : arg6,
            compound       : arg7,
        };
        arg0.config = v0;
        let v1 = ConfigUpdated{
            vault_id       : 0x2::object::id<Vault<T0, T1>>(arg0),
            width_ticks    : arg4,
            delay_ms       : arg5,
            auto_rebalance : arg6,
            compound       : arg7,
        };
        0x2::event::emit<ConfigUpdated>(v1);
    }

    public fun set_fees(arg0: &mut Registry, arg1: &AdminCap, arg2: u64, arg3: u64, arg4: address) {
        assert_version(arg0);
        assert!(arg2 <= 2000, 17);
        assert!(arg3 <= arg2, 17);
        arg0.fee_bps = arg2;
        arg0.affiliate_bps = arg3;
        arg0.dev_address = arg4;
        let v0 = FeesChanged{
            fee_bps       : arg2,
            affiliate_bps : arg3,
            dev_address   : arg4,
        };
        0x2::event::emit<FeesChanged>(v0);
    }

    public fun set_loss_budget(arg0: &mut Registry, arg1: &AdminCap, arg2: u64) {
        assert_version(arg0);
        assert!(arg2 >= 25 && arg2 <= 500, 35);
        let v0 = LossBudgetConfigKey{dummy_field: false};
        if (0x2::dynamic_field::exists<LossBudgetConfigKey>(&arg0.id, v0)) {
            let v1 = LossBudgetConfigKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<LossBudgetConfigKey, u64>(&mut arg0.id, v1) = arg2;
        } else {
            let v2 = LossBudgetConfigKey{dummy_field: false};
            0x2::dynamic_field::add<LossBudgetConfigKey, u64>(&mut arg0.id, v2, arg2);
        };
        let v3 = LossBudgetChanged{budget_bps: arg2};
        0x2::event::emit<LossBudgetChanged>(v3);
    }

    public fun set_paused(arg0: &mut Registry, arg1: &AdminCap, arg2: bool) {
        assert_version(arg0);
        arg0.paused = arg2;
        let v0 = PausedChanged{paused: arg2};
        0x2::event::emit<PausedChanged>(v0);
    }

    public fun set_risk_params(arg0: &mut Registry, arg1: &AdminCap, arg2: u64, arg3: u64, arg4: u64, arg5: u32) {
        assert_version(arg0);
        assert!(arg2 <= 500, 11);
        assert!(arg5 <= 887272, 25);
        assert!(arg3 >= 60000, 32);
        assert!(arg4 <= 300, 33);
        arg0.max_loss_bps = arg2;
        arg0.min_rebalance_interval_ms = arg3;
        arg0.max_price_drift_bps = arg4;
        arg0.max_range_move_ticks = arg5;
        let v0 = RiskParamsChanged{
            max_loss_bps              : arg2,
            min_rebalance_interval_ms : arg3,
            max_price_drift_bps       : arg4,
        };
        0x2::event::emit<RiskParamsChanged>(v0);
    }

    fun settle_reward_debt<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64) {
        if (arg1 == 0) {
            return
        };
        let v0 = RewardDebtKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<RewardDebtKey>(&arg0.id, v0), 31);
        let v1 = RewardDebtKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<RewardDebtKey, vector<u64>>(&mut arg0.id, v1);
        assert!(remove_first_at_most(v2, arg1), 31);
    }

    public fun skim_yield<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &RebalanceTicket, arg2: &Registry, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>) {
        assert_version(arg2);
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1>>(arg0), 6);
        bank_yield<T0, T1>(arg0, arg2, 0x2::coin::into_balance<T0>(arg3), 0x2::coin::into_balance<T1>(arg4));
    }

    fun split_fee<T0>(arg0: &Registry, arg1: &0x1::option::Option<address>, arg2: &mut 0x2::balance::Balance<T0>) : (u64, u64) {
        let v0 = mul_div_to_u64(0x2::balance::value<T0>(arg2), arg0.fee_bps, 10000);
        if (v0 == 0) {
            return (0, 0)
        };
        let v1 = 0x2::balance::split<T0>(arg2, v0);
        let v2 = 0;
        let v3 = if (0x1::option::is_some<address>(arg1)) {
            if (arg0.affiliate_bps > 0) {
                arg0.fee_bps > 0
            } else {
                false
            }
        } else {
            false
        };
        if (v3) {
            let v4 = mul_div_to_u64(v0, arg0.affiliate_bps, arg0.fee_bps);
            v2 = v4;
            send_balance<T0>(0x2::balance::split<T0>(&mut v1, v4), *0x1::option::borrow<address>(arg1));
        };
        send_balance<T0>(v1, arg0.dev_address);
        (v0, v2)
    }

    public fun sync_range_status<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock) {
        assert!(0x2::object::id<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>>(arg1) == arg0.pool_id, 5);
        assert!(0x1::option::is_some<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::position::Position>(&arg0.position), 16);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = is_in_range<T0, T1>(arg1, 0x1::option::borrow<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::position::Position>(&arg0.position));
        let v2 = BackInRangeKey{dummy_field: false};
        let v3 = if (0x2::dynamic_field::exists<BackInRangeKey>(&arg0.id, v2)) {
            let v4 = BackInRangeKey{dummy_field: false};
            0x1::option::some<u64>(*0x2::dynamic_field::borrow<BackInRangeKey, u64>(&arg0.id, v4))
        } else {
            0x1::option::none<u64>()
        };
        let (v5, v6) = oor_transition(v1, arg0.out_of_range_since_ms, v3, v0);
        if (v5) {
            arg0.out_of_range_since_ms = 0;
        };
        if (arg0.out_of_range_since_ms == 0 && !v1) {
            arg0.out_of_range_since_ms = v0;
        };
        if (v6 == 1) {
            let v7 = BackInRangeKey{dummy_field: false};
            0x2::dynamic_field::add<BackInRangeKey, u64>(&mut arg0.id, v7, v0);
        } else if (v6 == 2) {
            let v8 = BackInRangeKey{dummy_field: false};
            0x2::dynamic_field::remove<BackInRangeKey, u64>(&mut arg0.id, v8);
        };
    }

    public fun take_idle<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &RebalanceTicket, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1>>(arg0), 6);
        (0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.balance_x), arg2), 0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg0.balance_y), arg2))
    }

    fun total_value_in_y<T0, T1>(arg0: &Vault<T0, T1>, arg1: u128) : u256 {
        let v0 = if (0x1::option::is_some<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::position::Position>(&arg0.position)) {
            value_of(0x1::option::borrow<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::position::Position>(&arg0.position), arg1)
        } else {
            0
        };
        v0 + idle_value_in_y<T0, T1>(arg0, arg1)
    }

    fun value_in_y(arg0: u64, arg1: u64, arg2: u128) : u256 {
        let v0 = (arg2 as u256);
        (((arg0 as u256) * v0 >> 64) * v0 >> 64) + (arg1 as u256)
    }

    fun value_of(arg0: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::position::Position, arg1: u128) : u256 {
        let v0 = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::position::liquidity(arg0);
        if (v0 == 0) {
            return 0
        };
        let (v1, v2) = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::liquidity_math::get_amounts_for_liquidity(arg1, 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::tick_math::get_sqrt_price_at_tick(0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::position::tick_lower_index(arg0)), 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::tick_math::get_sqrt_price_at_tick(0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::position::tick_upper_index(arg0)), v0, false);
        value_in_y(v1, v2, arg1)
    }

    public fun width_ticks(arg0: &VaultConfig) : u32 {
        arg0.width_ticks
    }

    public fun withdraw<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &VaultOwnerCap, arg2: &mut 0x2::tx_context::TxContext) : (0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::position::Position, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert_cap<T0, T1>(arg0, arg1);
        assert!(0x1::option::is_some<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::position::Position>(&arg0.position), 16);
        let v0 = 0x1::option::extract<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::position::Position>(&mut arg0.position);
        arg0.config.auto_rebalance = false;
        let v1 = Withdrawn{
            vault_id    : 0x2::object::id<Vault<T0, T1>>(arg0),
            position_id : 0x2::object::id<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::position::Position>(&v0),
            amount_x    : 0x2::balance::value<T0>(&arg0.balance_x),
            amount_y    : 0x2::balance::value<T1>(&arg0.balance_y),
        };
        0x2::event::emit<Withdrawn>(v1);
        (v0, 0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.balance_x), arg2), 0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg0.balance_y), arg2))
    }

    // decompiled from Move bytecode v7
}

