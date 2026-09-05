module 0x8751d82e4a6c0eb08d09db745f0b73d6d7c7876a40ffbead791ed8b64c5e2bc8::vault {
    struct Registry has key {
        id: 0x2::object::UID,
        version: u64,
        controller_id: 0x2::object::ID,
        keeper_epoch: u64,
        allowed_pools: 0x2::vec_map::VecMap<0x2::object::ID, PoolConfig>,
    }

    struct PoolConfig has copy, drop, store {
        min_value_b: u256,
    }

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

    struct RewardDebtV2Key has copy, drop, store {
        dummy_field: bool,
    }

    struct OorSinceKey has copy, drop, store {
        dummy_field: bool,
    }

    struct RewardDebt has copy, drop, store {
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
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

    struct VaultConfig has copy, drop, store {
        width_ticks: u32,
        delay_ms: u64,
        auto_rebalance: bool,
        compound: bool,
    }

    struct Vault<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        version: u64,
        pool_id: 0x2::object::ID,
        beneficiary: address,
        affiliate: 0x1::option::Option<address>,
        position: 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>,
        balance_a: 0x2::balance::Balance<T0>,
        balance_b: 0x2::balance::Balance<T1>,
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
        old_tick_lower: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        old_tick_upper: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
    }

    struct Rebalanced has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        old_position_id: 0x2::object::ID,
        new_position_id: 0x2::object::ID,
        value_before: u256,
        value_after: u256,
        rebalance_count: u64,
        timestamp_ms: u64,
    }

    struct RegistryCreated has copy, drop {
        registry_id: 0x2::object::ID,
        controller_id: 0x2::object::ID,
    }

    struct PoolAllowed has copy, drop {
        pool_id: 0x2::object::ID,
        min_value_b: u256,
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

    struct Migrated has copy, drop {
        from_version: u64,
        to_version: u64,
    }

    struct VaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        owner: address,
        width_ticks: u32,
        delay_ms: u64,
        auto_rebalance: bool,
        compound: bool,
    }

    struct Withdrawn has copy, drop {
        vault_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
    }

    struct ConfigUpdated has copy, drop {
        vault_id: 0x2::object::ID,
        width_ticks: u32,
        delay_ms: u64,
        auto_rebalance: bool,
        compound: bool,
    }

    struct YieldSkimmed has copy, drop {
        vault_id: 0x2::object::ID,
        fee_a: u64,
        fee_b: u64,
        affiliate_a: u64,
        affiliate_b: u64,
        compounded: bool,
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
        is_token_a: bool,
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

    public fun config<T0, T1>(arg0: &Vault<T0, T1>) : VaultConfig {
        arg0.config
    }

    public fun pool_id<T0, T1>(arg0: &Vault<T0, T1>) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun affiliate<T0, T1>(arg0: &Vault<T0, T1>) : 0x1::option::Option<address> {
        arg0.affiliate
    }

    public fun allow_pool(arg0: &mut Registry, arg1: &AdminCap, arg2: &0xd439d1dd0ba68aea0b616c13af682a3f6281db5fc38f582b016655556b31335f::controller::Controller, arg3: 0x2::object::ID, arg4: u256) {
        assert_registry(arg0, arg2);
        assert!(0x2::vec_map::length<0x2::object::ID, PoolConfig>(&arg0.allowed_pools) < 64, 9);
        if (0x2::vec_map::contains<0x2::object::ID, PoolConfig>(&arg0.allowed_pools, &arg3)) {
            let (_, _) = 0x2::vec_map::remove<0x2::object::ID, PoolConfig>(&mut arg0.allowed_pools, &arg3);
        };
        let v2 = PoolConfig{min_value_b: arg4};
        0x2::vec_map::insert<0x2::object::ID, PoolConfig>(&mut arg0.allowed_pools, arg3, v2);
        let v3 = PoolAllowed{
            pool_id     : arg3,
            min_value_b : arg4,
        };
        0x2::event::emit<PoolAllowed>(v3);
    }

    fun assert_above_min_value<T0, T1>(arg0: &Registry, arg1: &Vault<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) {
        let v0 = 0x2::vec_map::get<0x2::object::ID, PoolConfig>(&arg0.allowed_pools, &arg1.pool_id).min_value_b;
        if (v0 == 0) {
            return
        };
        assert!(0x1::option::is_some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg1.position), 6);
        assert!(total_value_in_b<T0, T1>(arg1, arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg2)) >= v0, 28);
    }

    fun assert_cap<T0, T1>(arg0: &Vault<T0, T1>, arg1: &VaultOwnerCap) {
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1>>(arg0), 5);
    }

    public fun assert_keeper_current(arg0: &Registry, arg1: &KeeperCap) {
        assert!(arg1.epoch == arg0.keeper_epoch, 13);
    }

    fun assert_may_rebalance<T0, T1>(arg0: &Registry, arg1: &0xd439d1dd0ba68aea0b616c13af682a3f6281db5fc38f582b016655556b31335f::controller::Controller, arg2: &Vault<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock) {
        assert_registry(arg0, arg1);
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3) == arg2.pool_id, 4);
        assert!(0x2::vec_map::contains<0x2::object::ID, PoolConfig>(&arg0.allowed_pools, &arg2.pool_id), 3);
        assert!(0x1::option::is_some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg2.position), 6);
        assert!(0x2::clock::timestamp_ms(arg4) >= arg2.last_rebalance_ms + 0xd439d1dd0ba68aea0b616c13af682a3f6281db5fc38f582b016655556b31335f::controller::min_rebalance_interval_ms(arg1), 18);
        assert!(!is_in_range<T0, T1>(arg3, 0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg2.position)), 16);
    }

    fun assert_price_stable(arg0: u128, arg1: u128, arg2: u64) {
        let (v0, v1) = if (arg1 >= arg0) {
            (arg0, arg1)
        } else {
            (arg1, arg0)
        };
        assert!(v0 > 0, 21);
        assert!(((v1 - v0) as u256) * 10000 / (v0 as u256) <= (arg2 as u256), 21);
    }

    fun assert_registry(arg0: &Registry, arg1: &0xd439d1dd0ba68aea0b616c13af682a3f6281db5fc38f582b016655556b31335f::controller::Controller) {
        assert!(arg0.version == 7, 1);
        assert!(arg0.controller_id == 0x2::object::id<0xd439d1dd0ba68aea0b616c13af682a3f6281db5fc38f582b016655556b31335f::controller::Controller>(arg1), 11);
        0xd439d1dd0ba68aea0b616c13af682a3f6281db5fc38f582b016655556b31335f::controller::assert_active(arg1);
    }

    fun assert_width_valid(arg0: u32, arg1: u32) {
        assert!(arg0 > 0 && arg1 > 0, 7);
        assert!(arg0 % arg1 == 0, 7);
        assert!(arg0 <= 887272, 8);
    }

    public fun auto_rebalance(arg0: &VaultConfig) : bool {
        arg0.auto_rebalance
    }

    fun bank_yield<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0xd439d1dd0ba68aea0b616c13af682a3f6281db5fc38f582b016655556b31335f::controller::Controller, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>) {
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
            fee_a       : v1,
            fee_b       : v4,
            affiliate_a : v2,
            affiliate_b : v5,
            compounded  : arg0.config.compound,
        };
        0x2::event::emit<YieldSkimmed>(v6);
        if (arg0.config.compound) {
            0x2::balance::join<T0>(&mut arg0.balance_a, arg2);
            0x2::balance::join<T1>(&mut arg0.balance_b, arg3);
        } else {
            let v7 = arg0.beneficiary;
            send_balance<T0>(arg2, v7);
            send_balance<T1>(arg3, v7);
        };
    }

    public fun begin_rebalance<T0, T1>(arg0: &Registry, arg1: &0xd439d1dd0ba68aea0b616c13af682a3f6281db5fc38f582b016655556b31335f::controller::Controller, arg2: &mut Vault<T0, T1>, arg3: &KeeperCap, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &0x2::clock::Clock) : (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, RebalanceTicket) {
        abort 25
    }

    public fun begin_rebalance_as_owner<T0, T1>(arg0: &Registry, arg1: &0xd439d1dd0ba68aea0b616c13af682a3f6281db5fc38f582b016655556b31335f::controller::Controller, arg2: &mut Vault<T0, T1>, arg3: &VaultOwnerCap, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &0x2::clock::Clock) : (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, RebalanceTicket) {
        abort 25
    }

    public fun begin_rebalance_as_owner_v2<T0, T1>(arg0: &Registry, arg1: &0xd439d1dd0ba68aea0b616c13af682a3f6281db5fc38f582b016655556b31335f::controller::Controller, arg2: &mut Vault<T0, T1>, arg3: &VaultOwnerCap, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: &0x2::clock::Clock) : (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, RebalanceTicket) {
        assert_cap<T0, T1>(arg2, arg3);
        let v0 = oor_since<T0, T1>(arg2);
        assert!(v0 != 0, 17);
        assert!(0x2::clock::timestamp_ms(arg6) >= v0 + 300000, 17);
        begin_rebalance_inner<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg6)
    }

    fun begin_rebalance_inner<T0, T1>(arg0: &Registry, arg1: &0xd439d1dd0ba68aea0b616c13af682a3f6281db5fc38f582b016655556b31335f::controller::Controller, arg2: &mut Vault<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &0x2::clock::Clock) : (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, RebalanceTicket) {
        assert_may_rebalance<T0, T1>(arg0, arg1, arg2, arg4, arg5);
        let v0 = 0x1::option::extract<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg2.position);
        let v1 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v0);
        let (v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg3, arg4, &v0, true);
        bank_yield<T0, T1>(arg2, arg1, v2, v3);
        let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_and_update_rewards<T0, T1>(arg3, arg4, v1, arg5);
        let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::rewarders(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::rewarder_manager<T0, T1>(arg4));
        let v6 = 0x1::vector::empty<RewardDebt>();
        let v7 = 0;
        while (v7 < 0x1::vector::length<u64>(&v4)) {
            let v8 = *0x1::vector::borrow<u64>(&v4, v7);
            if (v8 > 0) {
                let v9 = RewardDebt{
                    coin_type : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::reward_coin(0x1::vector::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::Rewarder>(&v5, v7)),
                    amount    : v8,
                };
                0x1::vector::push_back<RewardDebt>(&mut v6, v9);
            };
            v7 = v7 + 1;
        };
        let v10 = RewardDebtKey{dummy_field: false};
        if (0x2::dynamic_field::exists<RewardDebtKey>(&arg2.id, v10)) {
            let v11 = RewardDebtKey{dummy_field: false};
            0x2::dynamic_field::remove<RewardDebtKey, vector<u64>>(&mut arg2.id, v11);
        };
        let v12 = RewardDebtV2Key{dummy_field: false};
        if (0x2::dynamic_field::exists<RewardDebtV2Key>(&arg2.id, v12)) {
            let v13 = RewardDebtV2Key{dummy_field: false};
            0x2::dynamic_field::remove<RewardDebtV2Key, vector<RewardDebt>>(&mut arg2.id, v13);
        };
        let v14 = RewardDebtV2Key{dummy_field: false};
        0x2::dynamic_field::add<RewardDebtV2Key, vector<RewardDebt>>(&mut arg2.id, v14, v6);
        let v15 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg4);
        let (v16, v17) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(&v0);
        let v18 = RebalanceTicket{
            vault_id            : 0x2::object::id<Vault<T0, T1>>(arg2),
            pool_id             : arg2.pool_id,
            old_position_id     : v1,
            value_before        : position_value_in_b<T0, T1>(arg4, &v0, v15) + idle_value_in_b<T0, T1>(arg2, v15),
            sqrt_price_snapshot : v15,
            width_ticks         : arg2.config.width_ticks,
            tick_spacing        : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<T0, T1>(arg4),
            old_tick_lower      : v16,
            old_tick_upper      : v17,
        };
        (v0, v18)
    }

    public fun begin_rebalance_v2<T0, T1>(arg0: &Registry, arg1: &0xd439d1dd0ba68aea0b616c13af682a3f6281db5fc38f582b016655556b31335f::controller::Controller, arg2: &mut Vault<T0, T1>, arg3: &KeeperCap, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: &0x2::clock::Clock) : (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, RebalanceTicket) {
        assert_keeper_current(arg0, arg3);
        assert!(arg2.config.auto_rebalance, 15);
        let v0 = oor_since<T0, T1>(arg2);
        assert!(v0 != 0, 17);
        assert!(0x2::clock::timestamp_ms(arg6) >= v0 + keeper_wait_ms(arg2.config.delay_ms), 17);
        assert_above_min_value<T0, T1>(arg0, arg2, arg5);
        begin_rebalance_inner<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg6)
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
        let v6 = mul_div(v0, v5, 86400000);
        let v7 = if (v6 >= v4.spent_bps) {
            0
        } else {
            v4.spent_bps - v6
        };
        assert!(v7 + arg2 <= v0, 30);
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

    fun claim_into_balance<T0, T1, T2>(arg0: &Vault<T0, T1>, arg1: &VaultOwnerCap, arg2: &Registry, arg3: &0xd439d1dd0ba68aea0b616c13af682a3f6281db5fc38f582b016655556b31335f::controller::Controller, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg7: &0x2::clock::Clock) : 0x2::balance::Balance<T2> {
        assert_registry(arg2, arg3);
        assert_cap<T0, T1>(arg0, arg1);
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg5) == arg0.pool_id, 4);
        assert!(0x1::option::is_some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position), 6);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T2>(arg4, arg5, 0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position), arg6, true, arg7)
    }

    public fun claim_reward<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: &VaultOwnerCap, arg2: &Registry, arg3: &0xd439d1dd0ba68aea0b616c13af682a3f6281db5fc38f582b016655556b31335f::controller::Controller, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg7: &0x2::clock::Clock) {
        assert!(!reward_is_pool_token<T0, T1, T2>(), 12);
        let v0 = claim_into_balance<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v1 = &mut v0;
        let (v2, v3) = split_fee<T2>(arg3, &arg0.affiliate, v1);
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

    public fun claim_reward_a<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &VaultOwnerCap, arg2: &Registry, arg3: &0xd439d1dd0ba68aea0b616c13af682a3f6281db5fc38f582b016655556b31335f::controller::Controller, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg7: &0x2::clock::Clock) {
        let v0 = claim_into_balance<T0, T1, T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v1 = &mut v0;
        let (v2, v3) = split_fee<T0>(arg3, &arg0.affiliate, v1);
        if (arg0.config.compound) {
            let v4 = RewardCompounded{
                vault_id   : 0x2::object::id<Vault<T0, T1>>(arg0),
                is_token_a : true,
                compounded : 0x2::balance::value<T0>(&v0),
                fee        : v2,
                affiliate  : v3,
            };
            0x2::event::emit<RewardCompounded>(v4);
            0x2::balance::join<T0>(&mut arg0.balance_a, v0);
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

    public fun claim_reward_b<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &VaultOwnerCap, arg2: &Registry, arg3: &0xd439d1dd0ba68aea0b616c13af682a3f6281db5fc38f582b016655556b31335f::controller::Controller, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg7: &0x2::clock::Clock) {
        let v0 = claim_into_balance<T0, T1, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v1 = &mut v0;
        let (v2, v3) = split_fee<T1>(arg3, &arg0.affiliate, v1);
        if (arg0.config.compound) {
            let v4 = RewardCompounded{
                vault_id   : 0x2::object::id<Vault<T0, T1>>(arg0),
                is_token_a : false,
                compounded : 0x2::balance::value<T1>(&v0),
                fee        : v2,
                affiliate  : v3,
            };
            0x2::event::emit<RewardCompounded>(v4);
            0x2::balance::join<T1>(&mut arg0.balance_b, v0);
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

    public fun compound_reward_a<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &RebalanceTicket, arg2: &0xd439d1dd0ba68aea0b616c13af682a3f6281db5fc38f582b016655556b31335f::controller::Controller, arg3: 0x2::coin::Coin<T0>) {
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1>>(arg0), 22);
        settle_reward_debt<T0, T1>(arg0, 0x1::type_name::with_defining_ids<T0>(), 0x2::coin::value<T0>(&arg3));
        let v0 = 0x2::coin::into_balance<T0>(arg3);
        let v1 = &mut v0;
        let (v2, v3) = split_fee<T0>(arg2, &arg0.affiliate, v1);
        if (arg0.config.compound) {
            let v4 = RewardCompounded{
                vault_id   : 0x2::object::id<Vault<T0, T1>>(arg0),
                is_token_a : true,
                compounded : 0x2::balance::value<T0>(&v0),
                fee        : v2,
                affiliate  : v3,
            };
            0x2::event::emit<RewardCompounded>(v4);
            0x2::balance::join<T0>(&mut arg0.balance_a, v0);
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

    public fun compound_reward_b<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &RebalanceTicket, arg2: &0xd439d1dd0ba68aea0b616c13af682a3f6281db5fc38f582b016655556b31335f::controller::Controller, arg3: 0x2::coin::Coin<T1>) {
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1>>(arg0), 22);
        settle_reward_debt<T0, T1>(arg0, 0x1::type_name::with_defining_ids<T1>(), 0x2::coin::value<T1>(&arg3));
        let v0 = 0x2::coin::into_balance<T1>(arg3);
        let v1 = &mut v0;
        let (v2, v3) = split_fee<T1>(arg2, &arg0.affiliate, v1);
        if (arg0.config.compound) {
            let v4 = RewardCompounded{
                vault_id   : 0x2::object::id<Vault<T0, T1>>(arg0),
                is_token_a : false,
                compounded : 0x2::balance::value<T1>(&v0),
                fee        : v2,
                affiliate  : v3,
            };
            0x2::event::emit<RewardCompounded>(v4);
            0x2::balance::join<T1>(&mut arg0.balance_b, v0);
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

    public fun create_registry(arg0: &AdminCap, arg1: &0xd439d1dd0ba68aea0b616c13af682a3f6281db5fc38f582b016655556b31335f::controller::Controller, arg2: &mut 0x2::tx_context::TxContext) {
        0xd439d1dd0ba68aea0b616c13af682a3f6281db5fc38f582b016655556b31335f::controller::assert_active(arg1);
        let v0 = Registry{
            id            : 0x2::object::new(arg2),
            version       : 7,
            controller_id : 0x2::object::id<0xd439d1dd0ba68aea0b616c13af682a3f6281db5fc38f582b016655556b31335f::controller::Controller>(arg1),
            keeper_epoch  : 0,
            allowed_pools : 0x2::vec_map::empty<0x2::object::ID, PoolConfig>(),
        };
        let v1 = RegistryCreated{
            registry_id   : 0x2::object::id<Registry>(&v0),
            controller_id : 0x2::object::id<0xd439d1dd0ba68aea0b616c13af682a3f6281db5fc38f582b016655556b31335f::controller::Controller>(arg1),
        };
        0x2::event::emit<RegistryCreated>(v1);
        0x2::transfer::share_object<Registry>(v0);
    }

    public fun delay_ms(arg0: &VaultConfig) : u64 {
        arg0.delay_ms
    }

    public fun deposit<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>) {
        0x2::balance::join<T0>(&mut arg0.balance_a, 0x2::coin::into_balance<T0>(arg1));
        0x2::balance::join<T1>(&mut arg0.balance_b, 0x2::coin::into_balance<T1>(arg2));
    }

    public fun destroy_admin_cap(arg0: AdminCap, arg1: &AdminCap) {
        let AdminCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public fun destroy_empty_vault<T0, T1>(arg0: Vault<T0, T1>, arg1: VaultOwnerCap) {
        assert_cap<T0, T1>(&arg0, &arg1);
        assert!(0x1::option::is_none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position), 10);
        assert!(0x2::balance::value<T0>(&arg0.balance_a) == 0 && 0x2::balance::value<T1>(&arg0.balance_b) == 0, 10);
        let v0 = &mut arg0;
        drop_dynamic_state<T0, T1>(v0);
        let Vault {
            id                    : v1,
            version               : _,
            pool_id               : _,
            beneficiary           : _,
            affiliate             : _,
            position              : v6,
            balance_a             : v7,
            balance_b             : v8,
            config                : _,
            out_of_range_since_ms : _,
            last_rebalance_ms     : _,
            rebalance_count       : _,
        } = arg0;
        0x1::option::destroy_none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v6);
        0x2::balance::destroy_zero<T0>(v7);
        0x2::balance::destroy_zero<T1>(v8);
        0x2::object::delete(v1);
        let VaultOwnerCap {
            id       : v13,
            vault_id : _,
        } = arg1;
        0x2::object::delete(v13);
        let v15 = VaultDestroyed{vault_id: 0x2::object::id<Vault<T0, T1>>(&arg0)};
        0x2::event::emit<VaultDestroyed>(v15);
    }

    public fun destroy_empty_vault_v2<T0, T1>(arg0: Vault<T0, T1>, arg1: VaultOwnerCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert_cap<T0, T1>(&arg0, &arg1);
        assert!(0x1::option::is_none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position), 10);
        let v0 = &mut arg0;
        drop_dynamic_state<T0, T1>(v0);
        let Vault {
            id                    : v1,
            version               : _,
            pool_id               : _,
            beneficiary           : _,
            affiliate             : _,
            position              : v6,
            balance_a             : v7,
            balance_b             : v8,
            config                : _,
            out_of_range_since_ms : _,
            last_rebalance_ms     : _,
            rebalance_count       : _,
        } = arg0;
        0x1::option::destroy_none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v6);
        let v13 = 0x2::tx_context::sender(arg2);
        send_balance<T0>(v7, v13);
        send_balance<T1>(v8, v13);
        0x2::object::delete(v1);
        let VaultOwnerCap {
            id       : v14,
            vault_id : _,
        } = arg1;
        0x2::object::delete(v14);
        let v16 = VaultDestroyed{vault_id: 0x2::object::id<Vault<T0, T1>>(&arg0)};
        0x2::event::emit<VaultDestroyed>(v16);
    }

    public fun destroy_keeper_cap(arg0: KeeperCap) {
        let KeeperCap {
            id    : v0,
            epoch : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun disallow_pool(arg0: &mut Registry, arg1: &AdminCap, arg2: &0xd439d1dd0ba68aea0b616c13af682a3f6281db5fc38f582b016655556b31335f::controller::Controller, arg3: 0x2::object::ID) {
        assert_registry(arg0, arg2);
        let (_, _) = 0x2::vec_map::remove<0x2::object::ID, PoolConfig>(&mut arg0.allowed_pools, &arg3);
        let v2 = PoolDisallowed{pool_id: arg3};
        0x2::event::emit<PoolDisallowed>(v2);
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
        let v4 = RewardDebtV2Key{dummy_field: false};
        if (0x2::dynamic_field::exists<RewardDebtV2Key>(&arg0.id, v4)) {
            let v5 = RewardDebtV2Key{dummy_field: false};
            0x2::dynamic_field::remove<RewardDebtV2Key, vector<RewardDebt>>(&mut arg0.id, v5);
        };
        let v6 = OorSinceKey{dummy_field: false};
        if (0x2::dynamic_field::exists<OorSinceKey>(&arg0.id, v6)) {
            let v7 = OorSinceKey{dummy_field: false};
            0x2::dynamic_field::remove<OorSinceKey, u64>(&mut arg0.id, v7);
        };
        let v8 = LossBudgetKey{dummy_field: false};
        if (0x2::dynamic_field::exists<LossBudgetKey>(&arg0.id, v8)) {
            let v9 = LossBudgetKey{dummy_field: false};
            0x2::dynamic_field::remove<LossBudgetKey, LossBudget>(&mut arg0.id, v9);
        };
    }

    public fun end_rebalance<T0, T1>(arg0: &Registry, arg1: &0xd439d1dd0ba68aea0b616c13af682a3f6281db5fc38f582b016655556b31335f::controller::Controller, arg2: &mut Vault<T0, T1>, arg3: RebalanceTicket, arg4: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: &0x2::clock::Clock) {
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
        } = arg3;
        assert_registry(arg0, arg1);
        assert!(v0 == 0x2::object::id<Vault<T0, T1>>(arg2), 22);
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg5) == v1, 4);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&arg4) == v1, 4);
        assert_price_stable(v4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg5), 0xd439d1dd0ba68aea0b616c13af682a3f6281db5fc38f582b016655556b31335f::controller::max_price_drift_bps(arg1));
        let (v9, v10) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(&arg4);
        let v11 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::abs_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v10, v9));
        assert!(v11 == v5, 20);
        assert!(v11 % v6 == 0, 7);
        assert!(!range_unchanged(v9, v10, v7, v8), 23);
        let v12 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg5);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v12, v9) || 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v12, v10), 24);
        assert!(range_is_at_market(v9, v10, v12, v6), 27);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::abs_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v9, v7)) <= 20000 && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::abs_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v10, v8)) <= 20000, 29);
        let v13 = RewardDebtV2Key{dummy_field: false};
        let v14 = 0x2::dynamic_field::remove<RewardDebtV2Key, vector<RewardDebt>>(&mut arg2.id, v13);
        assert!(0x1::vector::is_empty<RewardDebt>(&v14), 26);
        let v15 = position_value_in_b<T0, T1>(arg5, &arg4, v4) + idle_value_in_b<T0, T1>(arg2, v4);
        let v16 = 0xd439d1dd0ba68aea0b616c13af682a3f6281db5fc38f582b016655556b31335f::controller::bps();
        assert!(v15 >= v3 * ((v16 - 0xd439d1dd0ba68aea0b616c13af682a3f6281db5fc38f582b016655556b31335f::controller::max_loss_bps(arg1)) as u256) / (v16 as u256), 19);
        let v17 = 0x2::clock::timestamp_ms(arg6);
        charge_loss_budget<T0, T1>(arg0, arg2, loss_bps(v3, v15), v17);
        0x1::option::fill<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg2.position, arg4);
        arg2.last_rebalance_ms = v17;
        arg2.rebalance_count = arg2.rebalance_count + 1;
        let v18 = if (is_in_range<T0, T1>(arg5, 0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg2.position))) {
            0
        } else {
            v17
        };
        set_oor_since<T0, T1>(arg2, v18);
        let v19 = BackInRangeKey{dummy_field: false};
        if (0x2::dynamic_field::exists<BackInRangeKey>(&arg2.id, v19)) {
            let v20 = BackInRangeKey{dummy_field: false};
            0x2::dynamic_field::remove<BackInRangeKey, u64>(&mut arg2.id, v20);
        };
        let v21 = Rebalanced{
            vault_id        : v0,
            pool_id         : v1,
            old_position_id : v2,
            new_position_id : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg4),
            value_before    : v3,
            value_after     : v15,
            rebalance_count : arg2.rebalance_count,
            timestamp_ms    : v17,
        };
        0x2::event::emit<Rebalanced>(v21);
    }

    public fun harvest<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &VaultOwnerCap, arg2: &Registry, arg3: &0xd439d1dd0ba68aea0b616c13af682a3f6281db5fc38f582b016655556b31335f::controller::Controller, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) {
        assert_registry(arg2, arg3);
        assert_cap<T0, T1>(arg0, arg1);
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg5) == arg0.pool_id, 4);
        assert!(0x1::option::is_some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position), 6);
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg4, arg5, 0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position), true);
        let v2 = v1;
        let v3 = v0;
        let v4 = &mut v3;
        let (v5, v6) = split_fee<T0>(arg3, &arg0.affiliate, v4);
        let v7 = &mut v2;
        let (v8, v9) = split_fee<T1>(arg3, &arg0.affiliate, v7);
        let v10 = YieldSkimmed{
            vault_id    : 0x2::object::id<Vault<T0, T1>>(arg0),
            fee_a       : v5,
            fee_b       : v8,
            affiliate_a : v6,
            affiliate_b : v9,
            compounded  : arg0.config.compound,
        };
        0x2::event::emit<YieldSkimmed>(v10);
        if (arg0.config.compound) {
            0x2::balance::join<T0>(&mut arg0.balance_a, v3);
            0x2::balance::join<T1>(&mut arg0.balance_b, v2);
        } else {
            let v11 = arg0.beneficiary;
            send_balance<T0>(v3, v11);
            send_balance<T1>(v2, v11);
        };
    }

    public fun idle_balances<T0, T1>(arg0: &Vault<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.balance_a), 0x2::balance::value<T1>(&arg0.balance_b))
    }

    fun idle_value_in_b<T0, T1>(arg0: &Vault<T0, T1>, arg1: u128) : u256 {
        value_in_b(0x2::balance::value<T0>(&arg0.balance_a), 0x2::balance::value<T1>(&arg0.balance_b), arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    fun is_in_range<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position) : bool {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg0);
        let (v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(arg1);
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v0, v1) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v0, v2)
    }

    public fun is_pool_allowed(arg0: &Registry, arg1: 0x2::object::ID) : bool {
        0x2::vec_map::contains<0x2::object::ID, PoolConfig>(&arg0.allowed_pools, &arg1)
    }

    public fun keeper_cap_epoch(arg0: &KeeperCap) : u64 {
        arg0.epoch
    }

    public fun keeper_epoch(arg0: &Registry) : u64 {
        arg0.keeper_epoch
    }

    fun keeper_wait_ms(arg0: u64) : u64 {
        if (arg0 > 300000) {
            arg0
        } else {
            300000
        }
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
        let v4 = mul_div(loss_budget_bps(arg1), v3, 86400000);
        if (v4 >= v2.spent_bps) {
            0
        } else {
            v2.spent_bps - v4
        }
    }

    public fun migrate(arg0: &mut Registry, arg1: &AdminCap) {
        assert!(arg0.version < 7, 2);
        arg0.version = 7;
        let v0 = Migrated{
            from_version : arg0.version,
            to_version   : 7,
        };
        0x2::event::emit<Migrated>(v0);
    }

    public fun mint_admin_cap(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) : AdminCap {
        AdminCap{id: 0x2::object::new(arg1)}
    }

    public fun mint_keeper_cap(arg0: &Registry, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) : KeeperCap {
        assert!(arg0.version == 7, 1);
        KeeperCap{
            id    : 0x2::object::new(arg2),
            epoch : arg0.keeper_epoch,
        }
    }

    fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg2 == 0) {
            return 0
        };
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun new_vault<T0, T1>(arg0: &Registry, arg1: &0xd439d1dd0ba68aea0b616c13af682a3f6281db5fc38f582b016655556b31335f::controller::Controller, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg4: u32, arg5: u64, arg6: bool, arg7: bool, arg8: 0x1::option::Option<address>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : VaultOwnerCap {
        assert_registry(arg0, arg1);
        let v0 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg2);
        assert!(0x2::vec_map::contains<0x2::object::ID, PoolConfig>(&arg0.allowed_pools, &v0), 3);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&arg3) == v0, 4);
        assert_width_valid(arg4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<T0, T1>(arg2));
        let v1 = if (0x1::option::is_some<address>(&arg8) && *0x1::option::borrow<address>(&arg8) == 0x2::tx_context::sender(arg10)) {
            0x1::option::none<address>()
        } else {
            arg8
        };
        let v2 = is_in_range<T0, T1>(arg2, &arg3);
        let v3 = 0x2::clock::timestamp_ms(arg9);
        let v4 = 0x2::vec_map::get<0x2::object::ID, PoolConfig>(&arg0.allowed_pools, &v0).min_value_b;
        if (arg6 && v4 > 0) {
            assert!(position_value_in_b<T0, T1>(arg2, &arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg2)) >= v4, 28);
        };
        let v5 = VaultConfig{
            width_ticks    : arg4,
            delay_ms       : arg5,
            auto_rebalance : arg6,
            compound       : arg7,
        };
        let v6 = if (v2) {
            0
        } else {
            v3
        };
        let v7 = Vault<T0, T1>{
            id                    : 0x2::object::new(arg10),
            version               : 7,
            pool_id               : v0,
            beneficiary           : 0x2::tx_context::sender(arg10),
            affiliate             : v1,
            position              : 0x1::option::some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg3),
            balance_a             : 0x2::balance::zero<T0>(),
            balance_b             : 0x2::balance::zero<T1>(),
            config                : v5,
            out_of_range_since_ms : v6,
            last_rebalance_ms     : v3,
            rebalance_count       : 0,
        };
        let v8 = if (v2) {
            0
        } else {
            v3
        };
        let v9 = OorSinceKey{dummy_field: false};
        0x2::dynamic_field::add<OorSinceKey, u64>(&mut v7.id, v9, v8);
        let v10 = 0x2::object::id<Vault<T0, T1>>(&v7);
        let v11 = VaultOwnerCap{
            id       : 0x2::object::new(arg10),
            vault_id : v10,
        };
        let v12 = VaultCreated{
            vault_id       : v10,
            pool_id        : v0,
            position_id    : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg3),
            owner          : 0x2::tx_context::sender(arg10),
            width_ticks    : arg4,
            delay_ms       : arg5,
            auto_rebalance : arg6,
            compound       : arg7,
        };
        0x2::event::emit<VaultCreated>(v12);
        if (0x1::option::is_some<address>(&v7.affiliate)) {
            let v13 = ReferralRecorded{
                vault_id  : v10,
                owner     : 0x2::tx_context::sender(arg10),
                affiliate : *0x1::option::borrow<address>(&v7.affiliate),
            };
            0x2::event::emit<ReferralRecorded>(v13);
        };
        0x2::transfer::share_object<Vault<T0, T1>>(v7);
        v11
    }

    fun oor_since<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        let v0 = OorSinceKey{dummy_field: false};
        if (0x2::dynamic_field::exists<OorSinceKey>(&arg0.id, v0)) {
            let v2 = OorSinceKey{dummy_field: false};
            *0x2::dynamic_field::borrow<OorSinceKey, u64>(&arg0.id, v2)
        } else {
            arg0.out_of_range_since_ms
        }
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
        oor_since<T0, T1>(arg0)
    }

    public fun payout_reward<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: &RebalanceTicket, arg2: &0xd439d1dd0ba68aea0b616c13af682a3f6281db5fc38f582b016655556b31335f::controller::Controller, arg3: 0x2::coin::Coin<T2>) {
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1>>(arg0), 22);
        assert!(!reward_is_pool_token<T0, T1, T2>(), 12);
        settle_reward_debt<T0, T1>(arg0, 0x1::type_name::with_defining_ids<T2>(), 0x2::coin::value<T2>(&arg3));
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

    fun position_value_in_b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg2: u128) : u256 {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(arg1);
        if (v0 == 0) {
            return 0
        };
        let (v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(arg1);
        let (v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_amount_by_liquidity(v1, v2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_tick_index<T0, T1>(arg0), arg2, v0, false);
        value_in_b(v3, v4, arg2)
    }

    fun range_is_at_market(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg3: u32) : bool {
        let v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(arg3);
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lte(arg0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(arg2, v0)) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(arg1, v0), arg2)
    }

    fun range_unchanged(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg3: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : bool {
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(arg0, arg2) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(arg1, arg3)
    }

    public fun rebalance_count<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.rebalance_count
    }

    public fun registry_controller_id(arg0: &Registry) : 0x2::object::ID {
        arg0.controller_id
    }

    fun remove_first_matching(arg0: &mut vector<RewardDebt>, arg1: 0x1::type_name::TypeName, arg2: u64) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<RewardDebt>(arg0)) {
            let v1 = 0x1::vector::borrow<RewardDebt>(arg0, v0);
            if (v1.coin_type == arg1 && v1.amount <= arg2) {
                0x1::vector::remove<RewardDebt>(arg0, v0);
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun return_idle<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &RebalanceTicket, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>) {
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1>>(arg0), 22);
        0x2::balance::join<T0>(&mut arg0.balance_a, 0x2::coin::into_balance<T0>(arg2));
        0x2::balance::join<T1>(&mut arg0.balance_b, 0x2::coin::into_balance<T1>(arg3));
    }

    public fun revoke_keepers(arg0: &mut Registry, arg1: &AdminCap, arg2: &0xd439d1dd0ba68aea0b616c13af682a3f6281db5fc38f582b016655556b31335f::controller::Controller) {
        assert_registry(arg0, arg2);
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
        } else {
            0x2::balance::send_funds<T0>(arg0, arg1);
        };
    }

    public fun set_beneficiary<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &VaultOwnerCap, arg2: address) {
        assert_cap<T0, T1>(arg0, arg1);
        arg0.beneficiary = arg2;
    }

    public fun set_config<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &VaultOwnerCap, arg2: &Registry, arg3: &0xd439d1dd0ba68aea0b616c13af682a3f6281db5fc38f582b016655556b31335f::controller::Controller, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: u32, arg6: u64, arg7: bool, arg8: bool) {
        assert_registry(arg2, arg3);
        assert_cap<T0, T1>(arg0, arg1);
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg4) == arg0.pool_id, 4);
        assert_width_valid(arg5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<T0, T1>(arg4));
        let v0 = VaultConfig{
            width_ticks    : arg5,
            delay_ms       : arg6,
            auto_rebalance : arg7,
            compound       : arg8,
        };
        arg0.config = v0;
        let v1 = ConfigUpdated{
            vault_id       : 0x2::object::id<Vault<T0, T1>>(arg0),
            width_ticks    : arg5,
            delay_ms       : arg6,
            auto_rebalance : arg7,
            compound       : arg8,
        };
        0x2::event::emit<ConfigUpdated>(v1);
    }

    public fun set_loss_budget(arg0: &mut Registry, arg1: &AdminCap, arg2: &0xd439d1dd0ba68aea0b616c13af682a3f6281db5fc38f582b016655556b31335f::controller::Controller, arg3: u64) {
        assert_registry(arg0, arg2);
        assert!(arg3 >= 25 && arg3 <= 500, 31);
        let v0 = LossBudgetConfigKey{dummy_field: false};
        if (0x2::dynamic_field::exists<LossBudgetConfigKey>(&arg0.id, v0)) {
            let v1 = LossBudgetConfigKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<LossBudgetConfigKey, u64>(&mut arg0.id, v1) = arg3;
        } else {
            let v2 = LossBudgetConfigKey{dummy_field: false};
            0x2::dynamic_field::add<LossBudgetConfigKey, u64>(&mut arg0.id, v2, arg3);
        };
        let v3 = LossBudgetChanged{budget_bps: arg3};
        0x2::event::emit<LossBudgetChanged>(v3);
    }

    fun set_oor_since<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64) {
        let v0 = OorSinceKey{dummy_field: false};
        if (0x2::dynamic_field::exists<OorSinceKey>(&arg0.id, v0)) {
            let v1 = OorSinceKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<OorSinceKey, u64>(&mut arg0.id, v1) = arg1;
        } else {
            let v2 = OorSinceKey{dummy_field: false};
            0x2::dynamic_field::add<OorSinceKey, u64>(&mut arg0.id, v2, arg1);
        };
        arg0.out_of_range_since_ms = arg1;
    }

    fun settle_reward_debt<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x1::type_name::TypeName, arg2: u64) {
        if (arg2 == 0) {
            return
        };
        let v0 = RewardDebtV2Key{dummy_field: false};
        assert!(0x2::dynamic_field::exists<RewardDebtV2Key>(&arg0.id, v0), 26);
        let v1 = RewardDebtV2Key{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<RewardDebtV2Key, vector<RewardDebt>>(&mut arg0.id, v1);
        assert!(remove_first_matching(v2, arg1, arg2), 26);
    }

    public fun skim_yield<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &RebalanceTicket, arg2: &0xd439d1dd0ba68aea0b616c13af682a3f6281db5fc38f582b016655556b31335f::controller::Controller, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>) {
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1>>(arg0), 22);
        bank_yield<T0, T1>(arg0, arg2, 0x2::coin::into_balance<T0>(arg3), 0x2::coin::into_balance<T1>(arg4));
    }

    fun split_fee<T0>(arg0: &0xd439d1dd0ba68aea0b616c13af682a3f6281db5fc38f582b016655556b31335f::controller::Controller, arg1: &0x1::option::Option<address>, arg2: &mut 0x2::balance::Balance<T0>) : (u64, u64) {
        let v0 = 0xd439d1dd0ba68aea0b616c13af682a3f6281db5fc38f582b016655556b31335f::controller::fee_bps(arg0);
        let v1 = mul_div(0x2::balance::value<T0>(arg2), v0, 0xd439d1dd0ba68aea0b616c13af682a3f6281db5fc38f582b016655556b31335f::controller::bps());
        if (v1 == 0) {
            return (0, 0)
        };
        let v2 = 0x2::balance::split<T0>(arg2, v1);
        let v3 = 0xd439d1dd0ba68aea0b616c13af682a3f6281db5fc38f582b016655556b31335f::controller::affiliate_bps(arg0);
        let v4 = 0;
        let v5 = if (0x1::option::is_some<address>(arg1)) {
            if (v3 > 0) {
                v0 > 0
            } else {
                false
            }
        } else {
            false
        };
        if (v5) {
            let v6 = mul_div(v1, v3, v0);
            v4 = v6;
            send_balance<T0>(0x2::balance::split<T0>(&mut v2, v6), *0x1::option::borrow<address>(arg1));
        };
        send_balance<T0>(v2, 0xd439d1dd0ba68aea0b616c13af682a3f6281db5fc38f582b016655556b31335f::controller::dev_address(arg0));
        (v1, v4)
    }

    public fun sync_range_status<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock) {
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1) == arg0.pool_id, 4);
        if (0x1::option::is_none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position)) {
            return
        };
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = is_in_range<T0, T1>(arg1, 0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position));
        let v2 = BackInRangeKey{dummy_field: false};
        let v3 = if (0x2::dynamic_field::exists<BackInRangeKey>(&arg0.id, v2)) {
            let v4 = BackInRangeKey{dummy_field: false};
            0x1::option::some<u64>(*0x2::dynamic_field::borrow<BackInRangeKey, u64>(&arg0.id, v4))
        } else {
            0x1::option::none<u64>()
        };
        let v5 = oor_since<T0, T1>(arg0);
        let (v6, v7) = oor_transition(v1, v5, v3, v0);
        let v8 = v5;
        if (v6) {
            v8 = 0;
        };
        if (v8 == 0 && !v1) {
            v8 = v0;
        };
        set_oor_since<T0, T1>(arg0, v8);
        if (v7 == 1) {
            let v9 = BackInRangeKey{dummy_field: false};
            0x2::dynamic_field::add<BackInRangeKey, u64>(&mut arg0.id, v9, v0);
        } else if (v7 == 2) {
            let v10 = BackInRangeKey{dummy_field: false};
            0x2::dynamic_field::remove<BackInRangeKey, u64>(&mut arg0.id, v10);
        };
    }

    public fun take_idle<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &RebalanceTicket, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1>>(arg0), 22);
        (0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.balance_a), arg2), 0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg0.balance_b), arg2))
    }

    public fun ticket_value_before(arg0: &RebalanceTicket) : u256 {
        arg0.value_before
    }

    public fun ticket_vault_id(arg0: &RebalanceTicket) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun ticket_width_ticks(arg0: &RebalanceTicket) : u32 {
        arg0.width_ticks
    }

    fun total_value_in_b<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: u128) : u256 {
        let v0 = if (0x1::option::is_some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position)) {
            position_value_in_b<T0, T1>(arg1, 0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position), arg2)
        } else {
            0
        };
        v0 + idle_value_in_b<T0, T1>(arg0, arg2)
    }

    fun value_in_b(arg0: u64, arg1: u64, arg2: u128) : u256 {
        let v0 = (arg2 as u256);
        (((arg0 as u256) * v0 >> 64) * v0 >> 64) + (arg1 as u256)
    }

    public fun width_ticks(arg0: &VaultConfig) : u32 {
        arg0.width_ticks
    }

    public fun withdraw<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &VaultOwnerCap, arg2: &mut 0x2::tx_context::TxContext) : (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert_cap<T0, T1>(arg0, arg1);
        assert!(0x1::option::is_some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position), 6);
        let v0 = 0x1::option::extract<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.position);
        arg0.config.auto_rebalance = false;
        let v1 = Withdrawn{
            vault_id    : 0x2::object::id<Vault<T0, T1>>(arg0),
            position_id : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v0),
            amount_a    : 0x2::balance::value<T0>(&arg0.balance_a),
            amount_b    : 0x2::balance::value<T1>(&arg0.balance_b),
        };
        0x2::event::emit<Withdrawn>(v1);
        (v0, 0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.balance_a), arg2), 0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg0.balance_b), arg2))
    }

    // decompiled from Move bytecode v7
}

