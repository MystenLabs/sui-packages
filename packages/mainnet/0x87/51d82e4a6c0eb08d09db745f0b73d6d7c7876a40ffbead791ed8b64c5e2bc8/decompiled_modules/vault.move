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

    fun assert_cap<T0, T1>(arg0: &Vault<T0, T1>, arg1: &VaultOwnerCap) {
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1>>(arg0), 5);
    }

    public fun assert_keeper_current(arg0: &Registry, arg1: &KeeperCap) {
        assert!(arg1.epoch == arg0.keeper_epoch, 13);
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
        assert!(arg0.version == 1, 1);
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

    public fun begin_rebalance<T0, T1>(arg0: &Registry, arg1: &0xd439d1dd0ba68aea0b616c13af682a3f6281db5fc38f582b016655556b31335f::controller::Controller, arg2: &mut Vault<T0, T1>, arg3: &KeeperCap, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &0x2::clock::Clock) : (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, RebalanceTicket) {
        assert_keeper_current(arg0, arg3);
        assert!(arg2.config.auto_rebalance, 15);
        assert!(arg2.out_of_range_since_ms != 0, 17);
        assert!(0x2::clock::timestamp_ms(arg5) >= arg2.out_of_range_since_ms + arg2.config.delay_ms, 17);
        begin_rebalance_inner<T0, T1>(arg0, arg1, arg2, arg4, arg5)
    }

    public fun begin_rebalance_as_owner<T0, T1>(arg0: &Registry, arg1: &0xd439d1dd0ba68aea0b616c13af682a3f6281db5fc38f582b016655556b31335f::controller::Controller, arg2: &mut Vault<T0, T1>, arg3: &VaultOwnerCap, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: &0x2::clock::Clock) : (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, RebalanceTicket) {
        assert_cap<T0, T1>(arg2, arg3);
        assert!(arg2.out_of_range_since_ms != 0, 17);
        assert!(0x2::clock::timestamp_ms(arg5) >= arg2.out_of_range_since_ms + 300000, 17);
        begin_rebalance_inner<T0, T1>(arg0, arg1, arg2, arg4, arg5)
    }

    fun begin_rebalance_inner<T0, T1>(arg0: &Registry, arg1: &0xd439d1dd0ba68aea0b616c13af682a3f6281db5fc38f582b016655556b31335f::controller::Controller, arg2: &mut Vault<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock) : (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, RebalanceTicket) {
        assert_registry(arg0, arg1);
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg3) == arg2.pool_id, 4);
        assert!(0x2::vec_map::contains<0x2::object::ID, PoolConfig>(&arg0.allowed_pools, &arg2.pool_id), 3);
        assert!(0x1::option::is_some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg2.position), 6);
        assert!(0x2::clock::timestamp_ms(arg4) >= arg2.last_rebalance_ms + 0xd439d1dd0ba68aea0b616c13af682a3f6281db5fc38f582b016655556b31335f::controller::min_rebalance_interval_ms(arg1), 18);
        assert!(!is_in_range<T0, T1>(arg3, 0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg2.position)), 16);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg3);
        let v1 = 0x1::option::extract<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg2.position);
        let (v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(&v1);
        let v4 = RebalanceTicket{
            vault_id            : 0x2::object::id<Vault<T0, T1>>(arg2),
            pool_id             : arg2.pool_id,
            old_position_id     : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v1),
            value_before        : total_value_in_b<T0, T1>(arg2, arg3, v0),
            sqrt_price_snapshot : v0,
            width_ticks         : arg2.config.width_ticks,
            tick_spacing        : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::tick_spacing<T0, T1>(arg3),
            old_tick_lower      : v2,
            old_tick_upper      : v3,
        };
        (v1, v4)
    }

    public fun beneficiary<T0, T1>(arg0: &Vault<T0, T1>) : address {
        arg0.beneficiary
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

    public fun create_registry(arg0: &AdminCap, arg1: &0xd439d1dd0ba68aea0b616c13af682a3f6281db5fc38f582b016655556b31335f::controller::Controller, arg2: &mut 0x2::tx_context::TxContext) {
        0xd439d1dd0ba68aea0b616c13af682a3f6281db5fc38f582b016655556b31335f::controller::assert_active(arg1);
        let v0 = Registry{
            id            : 0x2::object::new(arg2),
            version       : 1,
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
        let Vault {
            id                    : v0,
            version               : _,
            pool_id               : _,
            beneficiary           : _,
            affiliate             : _,
            position              : v5,
            balance_a             : v6,
            balance_b             : v7,
            config                : _,
            out_of_range_since_ms : _,
            last_rebalance_ms     : _,
            rebalance_count       : _,
        } = arg0;
        0x1::option::destroy_none<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v5);
        0x2::balance::destroy_zero<T0>(v6);
        0x2::balance::destroy_zero<T1>(v7);
        0x2::object::delete(v0);
        let VaultOwnerCap {
            id       : v12,
            vault_id : _,
        } = arg1;
        0x2::object::delete(v12);
        let v14 = VaultDestroyed{vault_id: 0x2::object::id<Vault<T0, T1>>(&arg0)};
        0x2::event::emit<VaultDestroyed>(v14);
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
        let v13 = position_value_in_b<T0, T1>(arg5, &arg4, v4) + idle_value_in_b<T0, T1>(arg2, v4);
        let v14 = 0xd439d1dd0ba68aea0b616c13af682a3f6281db5fc38f582b016655556b31335f::controller::bps();
        assert!(v13 >= v3 * ((v14 - 0xd439d1dd0ba68aea0b616c13af682a3f6281db5fc38f582b016655556b31335f::controller::max_loss_bps(arg1)) as u256) / (v14 as u256), 19);
        let v15 = 0x2::clock::timestamp_ms(arg6);
        0x1::option::fill<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg2.position, arg4);
        arg2.last_rebalance_ms = v15;
        arg2.rebalance_count = arg2.rebalance_count + 1;
        let v16 = if (is_in_range<T0, T1>(arg5, 0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg2.position))) {
            0
        } else {
            v15
        };
        arg2.out_of_range_since_ms = v16;
        let v17 = Rebalanced{
            vault_id        : v0,
            pool_id         : v1,
            old_position_id : v2,
            new_position_id : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg4),
            value_before    : v3,
            value_after     : v13,
            rebalance_count : arg2.rebalance_count,
            timestamp_ms    : v15,
        };
        0x2::event::emit<Rebalanced>(v17);
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

    public fun migrate(arg0: &mut Registry, arg1: &AdminCap) {
        assert!(arg0.version < 1, 2);
        arg0.version = 1;
        let v0 = Migrated{
            from_version : arg0.version,
            to_version   : 1,
        };
        0x2::event::emit<Migrated>(v0);
    }

    public fun mint_admin_cap(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) : AdminCap {
        AdminCap{id: 0x2::object::new(arg1)}
    }

    public fun mint_keeper_cap(arg0: &Registry, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) : KeeperCap {
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
        let v1 = 0x2::clock::timestamp_ms(arg9);
        let v2 = VaultConfig{
            width_ticks    : arg4,
            delay_ms       : arg5,
            auto_rebalance : arg6,
            compound       : arg7,
        };
        let v3 = if (is_in_range<T0, T1>(arg2, &arg3)) {
            0
        } else {
            v1
        };
        let v4 = Vault<T0, T1>{
            id                    : 0x2::object::new(arg10),
            version               : 1,
            pool_id               : v0,
            beneficiary           : 0x2::tx_context::sender(arg10),
            affiliate             : arg8,
            position              : 0x1::option::some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg3),
            balance_a             : 0x2::balance::zero<T0>(),
            balance_b             : 0x2::balance::zero<T1>(),
            config                : v2,
            out_of_range_since_ms : v3,
            last_rebalance_ms     : v1,
            rebalance_count       : 0,
        };
        let v5 = 0x2::object::id<Vault<T0, T1>>(&v4);
        let v6 = VaultOwnerCap{
            id       : 0x2::object::new(arg10),
            vault_id : v5,
        };
        let v7 = VaultCreated{
            vault_id       : v5,
            pool_id        : v0,
            position_id    : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg3),
            owner          : 0x2::tx_context::sender(arg10),
            width_ticks    : arg4,
            delay_ms       : arg5,
            auto_rebalance : arg6,
            compound       : arg7,
        };
        0x2::event::emit<VaultCreated>(v7);
        v4.last_rebalance_ms = v1;
        0x2::transfer::share_object<Vault<T0, T1>>(v4);
        v6
    }

    public fun out_of_range_since_ms<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.out_of_range_since_ms
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

    fun range_unchanged(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg3: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : bool {
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(arg0, arg2) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(arg1, arg3)
    }

    public fun rebalance_count<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.rebalance_count
    }

    public fun registry_controller_id(arg0: &Registry) : 0x2::object::ID {
        arg0.controller_id
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

    public fun skim_yield<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &RebalanceTicket, arg2: &0xd439d1dd0ba68aea0b616c13af682a3f6281db5fc38f582b016655556b31335f::controller::Controller, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>) {
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1>>(arg0), 22);
        let v0 = 0x2::coin::into_balance<T0>(arg3);
        let v1 = 0x2::coin::into_balance<T1>(arg4);
        let v2 = &mut v0;
        let (v3, v4) = split_fee<T0>(arg2, &arg0.affiliate, v2);
        let v5 = &mut v1;
        let (v6, v7) = split_fee<T1>(arg2, &arg0.affiliate, v5);
        let v8 = YieldSkimmed{
            vault_id    : 0x2::object::id<Vault<T0, T1>>(arg0),
            fee_a       : v3,
            fee_b       : v6,
            affiliate_a : v4,
            affiliate_b : v7,
            compounded  : arg0.config.compound,
        };
        0x2::event::emit<YieldSkimmed>(v8);
        if (arg0.config.compound) {
            0x2::balance::join<T0>(&mut arg0.balance_a, v0);
            0x2::balance::join<T1>(&mut arg0.balance_b, v1);
        } else {
            let v9 = arg0.beneficiary;
            send_balance<T0>(v0, v9);
            send_balance<T1>(v1, v9);
        };
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
        if (!is_in_range<T0, T1>(arg1, 0x1::option::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.position))) {
            if (arg0.out_of_range_since_ms == 0) {
                arg0.out_of_range_since_ms = 0x2::clock::timestamp_ms(arg2);
            };
        } else if (arg0.out_of_range_since_ms != 0 && 0x2::clock::timestamp_ms(arg2) >= arg0.out_of_range_since_ms + 300000) {
            arg0.out_of_range_since_ms = 0;
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

