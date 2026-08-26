module 0xdfd9733acd8ea1ea00a1b924cb559750f06366d54ccaf4feaee805c0e364f181::vault {
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
        allowed_pools: 0x2::vec_set::VecSet<0x2::object::ID>,
        fee_bps: u64,
        affiliate_bps: u64,
        dev_address: address,
        max_loss_bps: u64,
        min_rebalance_interval_ms: u64,
        min_vault_value_y: u256,
        max_price_drift_bps: u64,
    }

    struct VaultConfig has copy, drop, store {
        width_ticks: u32,
        delay_ms: u64,
        auto_rebalance: bool,
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
    }

    struct VaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        width_ticks: u32,
        delay_ms: u64,
        auto_rebalance: bool,
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
    }

    struct PoolDisallowed has copy, drop {
        pool_id: 0x2::object::ID,
    }

    struct KeepersRevoked has copy, drop {
        new_epoch: u64,
    }

    struct FeesChanged has copy, drop {
        fee_bps: u64,
        affiliate_bps: u64,
        dev_address: address,
    }

    struct RiskParamsChanged has copy, drop {
        max_loss_bps: u64,
        min_rebalance_interval_ms: u64,
        min_vault_value_y: u256,
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

    struct Migrated has copy, drop {
        from_version: u64,
        to_version: u64,
    }

    struct ConfigUpdated has copy, drop {
        vault_id: 0x2::object::ID,
        width_ticks: u32,
        delay_ms: u64,
        auto_rebalance: bool,
    }

    public fun pool_id<T0, T1>(arg0: &Vault<T0, T1>) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun affiliate<T0, T1>(arg0: &Vault<T0, T1>) : 0x1::option::Option<address> {
        arg0.affiliate
    }

    public fun allow_pool(arg0: &mut Registry, arg1: &AdminCap, arg2: 0x2::object::ID) {
        assert!(0x2::vec_set::length<0x2::object::ID>(&arg0.allowed_pools) < 64, 19);
        if (!0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_pools, &arg2)) {
            0x2::vec_set::insert<0x2::object::ID>(&mut arg0.allowed_pools, arg2);
            let v0 = PoolAllowed{pool_id: arg2};
            0x2::event::emit<PoolAllowed>(v0);
        };
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
        assert!(((v1 - v0) as u256) * (10000 as u256) / (v0 as u256) <= (arg2 as u256), 14);
    }

    fun assert_version(arg0: &Registry) {
        assert!(arg0.version == 1, 23);
    }

    fun assert_width_valid(arg0: u32, arg1: u32) {
        assert!(arg1 > 0, 18);
        assert!(arg0 > 0 && arg0 % arg1 == 0, 18);
        assert!(arg0 <= 887272, 25);
    }

    public fun auto_rebalance(arg0: &VaultConfig) : bool {
        arg0.auto_rebalance
    }

    public fun begin_rebalance<T0, T1>(arg0: &Registry, arg1: &mut Vault<T0, T1>, arg2: &KeeperCap, arg3: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock) : (0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::position::Position, RebalanceTicket) {
        assert_version(arg0);
        assert!(!arg0.paused, 2);
        assert!(arg2.epoch == arg0.keeper_epoch, 3);
        assert!(0x2::object::id<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>>(arg3) == arg1.pool_id, 5);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_pools, &arg1.pool_id), 4);
        assert!(arg1.config.auto_rebalance, 7);
        assert!(0x1::option::is_some<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::position::Position>(&arg1.position), 16);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 >= arg1.last_rebalance_ms + arg0.min_rebalance_interval_ms, 10);
        assert!(!is_in_range<T0, T1>(arg3, 0x1::option::borrow<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::position::Position>(&arg1.position)), 8);
        assert!(arg1.out_of_range_since_ms != 0, 9);
        assert!(v0 >= arg1.out_of_range_since_ms + arg1.config.delay_ms, 9);
        let v1 = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::sqrt_price<T0, T1>(arg3);
        let v2 = 0x1::option::extract<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::position::Position>(&mut arg1.position);
        let v3 = RebalanceTicket{
            vault_id            : 0x2::object::id<Vault<T0, T1>>(arg1),
            pool_id             : arg1.pool_id,
            old_position_id     : 0x2::object::id<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::position::Position>(&v2),
            value_before        : total_value_in_y<T0, T1>(arg1, v1),
            sqrt_price_snapshot : v1,
            width_ticks         : arg1.config.width_ticks,
            tick_spacing        : 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::tick_spacing<T0, T1>(arg3),
        };
        (v2, v3)
    }

    public fun beneficiary<T0, T1>(arg0: &Vault<T0, T1>) : address {
        arg0.beneficiary
    }

    public fun compound_reward_x<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &RebalanceTicket, arg2: &Registry, arg3: 0x2::coin::Coin<T0>) {
        assert_version(arg2);
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1>>(arg0), 6);
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
        0x2::balance::join<T0>(&mut arg0.balance_x, v0);
    }

    public fun compound_reward_y<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &RebalanceTicket, arg2: &Registry, arg3: 0x2::coin::Coin<T1>) {
        assert_version(arg2);
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1>>(arg0), 6);
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
        0x2::balance::join<T1>(&mut arg0.balance_y, v0);
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

    public fun destroy_empty_vault<T0, T1>(arg0: Vault<T0, T1>, arg1: VaultOwnerCap) {
        let v0 = 0x2::object::id<Vault<T0, T1>>(&arg0);
        assert!(arg1.vault_id == v0, 20);
        let Vault {
            id                    : v1,
            version               : _,
            beneficiary           : _,
            affiliate             : _,
            pool_id               : _,
            position              : v6,
            balance_x             : v7,
            balance_y             : v8,
            config                : _,
            out_of_range_since_ms : _,
            last_rebalance_ms     : _,
            rebalance_count       : _,
        } = arg0;
        let v13 = v8;
        let v14 = v7;
        let v15 = v6;
        assert!(0x1::option::is_none<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::position::Position>(&v15), 21);
        assert!(0x2::balance::value<T0>(&v14) == 0 && 0x2::balance::value<T1>(&v13) == 0, 21);
        0x1::option::destroy_none<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::position::Position>(v15);
        0x2::balance::destroy_zero<T0>(v14);
        0x2::balance::destroy_zero<T1>(v13);
        let v16 = VaultDestroyed{vault_id: v0};
        0x2::event::emit<VaultDestroyed>(v16);
        0x2::object::delete(v1);
        let VaultOwnerCap {
            id       : v17,
            vault_id : _,
        } = arg1;
        0x2::object::delete(v17);
    }

    public fun disallow_pool(arg0: &mut Registry, arg1: &AdminCap, arg2: 0x2::object::ID) {
        if (0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_pools, &arg2)) {
            0x2::vec_set::remove<0x2::object::ID>(&mut arg0.allowed_pools, &arg2);
            let v0 = PoolDisallowed{pool_id: arg2};
            0x2::event::emit<PoolDisallowed>(v0);
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
        } = arg2;
        assert_version(arg0);
        assert!(v0 == 0x2::object::id<Vault<T0, T1>>(arg1), 6);
        assert!(0x2::object::id<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>>(arg4) == v1, 5);
        assert!(0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::position::pool_id(&arg3) == v1, 5);
        assert_price_stable(v4, 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::sqrt_price<T0, T1>(arg4), arg0.max_price_drift_bps);
        let v7 = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::position::tick_lower_index(&arg3);
        let v8 = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::position::tick_upper_index(&arg3);
        assert!(0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::i32::abs_u32(0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::i32::sub(v8, v7)) == v5, 12);
        let v9 = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::tick_index_current<T0, T1>(arg4);
        let v10 = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::i32::from(v6);
        assert!(0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::i32::lte(v7, 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::i32::add(v9, v10)), 13);
        assert!(0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::i32::gte(0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::i32::add(v8, v10), v9), 13);
        assert!(0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::i32::lt(v9, v7) || 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::i32::gte(v9, v8), 22);
        let v11 = value_of(&arg3, v4) + idle_value_in_y<T0, T1>(arg1, v4);
        assert!(v11 >= v3 * ((10000 - arg0.max_loss_bps) as u256) / (10000 as u256), 11);
        let v12 = 0x2::clock::timestamp_ms(arg5);
        0x1::option::fill<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::position::Position>(&mut arg1.position, arg3);
        arg1.last_rebalance_ms = v12;
        arg1.rebalance_count = arg1.rebalance_count + 1;
        let v13 = if (is_in_range<T0, T1>(arg4, 0x1::option::borrow<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::position::Position>(&arg1.position))) {
            0
        } else {
            v12
        };
        arg1.out_of_range_since_ms = v13;
        let v14 = Rebalanced{
            vault_id        : v0,
            pool_id         : v1,
            old_position_id : v2,
            new_position_id : 0x2::object::id<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::position::Position>(&arg3),
            value_before    : v3,
            value_after     : v11,
            tick_lower      : v7,
            tick_upper      : v8,
            rebalance_count : arg1.rebalance_count,
            timestamp_ms    : v12,
        };
        0x2::event::emit<Rebalanced>(v14);
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
            version                   : 1,
            paused                    : false,
            keeper_epoch              : 0,
            allowed_pools             : 0x2::vec_set::empty<0x2::object::ID>(),
            fee_bps                   : 800,
            affiliate_bps             : 300,
            dev_address               : 0x2::tx_context::sender(arg0),
            max_loss_bps              : 100,
            min_rebalance_interval_ms : 3600000,
            min_vault_value_y         : 0,
            max_price_drift_bps       : 100,
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

    public fun migrate(arg0: &mut Registry, arg1: &AdminCap) {
        assert!(arg0.version < 1, 24);
        arg0.version = 1;
        let v0 = Migrated{
            from_version : arg0.version,
            to_version   : 1,
        };
        0x2::event::emit<Migrated>(v0);
    }

    public fun migrate_vault<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &AdminCap) {
        assert!(arg0.version < 1, 24);
        arg0.version = 1;
    }

    public fun mint_keeper_cap(arg0: &Registry, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) : KeeperCap {
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

    public fun new_vault<T0, T1>(arg0: &Registry, arg1: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg2: 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::position::Position, arg3: u32, arg4: u64, arg5: bool, arg6: 0x1::option::Option<address>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : VaultOwnerCap {
        assert_version(arg0);
        assert!(!arg0.paused, 2);
        let v0 = 0x2::object::id<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>>(arg1);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_pools, &v0), 4);
        assert!(0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::position::pool_id(&arg2) == v0, 5);
        assert_width_valid(arg3, 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::tick_spacing<T0, T1>(arg1));
        let v1 = if (0x1::option::is_some<address>(&arg6) && *0x1::option::borrow<address>(&arg6) == 0x2::tx_context::sender(arg8)) {
            0x1::option::none<address>()
        } else {
            arg6
        };
        if (arg5) {
            assert!(position_value_in_y(0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::sqrt_price<T0, T1>(arg1), &arg2) >= arg0.min_vault_value_y, 15);
        };
        let v2 = VaultConfig{
            width_ticks    : arg3,
            delay_ms       : arg4,
            auto_rebalance : arg5,
        };
        let v3 = Vault<T0, T1>{
            id                    : 0x2::object::new(arg8),
            version               : 1,
            beneficiary           : 0x2::tx_context::sender(arg8),
            affiliate             : v1,
            pool_id               : v0,
            position              : 0x1::option::some<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::position::Position>(arg2),
            balance_x             : 0x2::balance::zero<T0>(),
            balance_y             : 0x2::balance::zero<T1>(),
            config                : v2,
            out_of_range_since_ms : 0,
            last_rebalance_ms     : 0x2::clock::timestamp_ms(arg7),
            rebalance_count       : 0,
        };
        let v4 = 0x2::object::id<Vault<T0, T1>>(&v3);
        let v5 = VaultOwnerCap{
            id       : 0x2::object::new(arg8),
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
        };
        0x2::event::emit<VaultCreated>(v6);
        0x2::transfer::share_object<Vault<T0, T1>>(v3);
        v5
    }

    public fun out_of_range_since_ms<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.out_of_range_since_ms
    }

    public fun payout_reward<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: &RebalanceTicket, arg2: &Registry, arg3: 0x2::coin::Coin<T2>) {
        assert_version(arg2);
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1>>(arg0), 6);
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

    fun position_value_in_y(arg0: u128, arg1: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::position::Position) : u256 {
        value_of(arg1, arg0)
    }

    public fun rebalance_count<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.rebalance_count
    }

    public fun return_idle<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &RebalanceTicket, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>) {
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1>>(arg0), 6);
        0x2::balance::join<T0>(&mut arg0.balance_x, 0x2::coin::into_balance<T0>(arg2));
        0x2::balance::join<T1>(&mut arg0.balance_y, 0x2::coin::into_balance<T1>(arg3));
    }

    public fun revoke_keepers(arg0: &mut Registry, arg1: &AdminCap) {
        arg0.keeper_epoch = arg0.keeper_epoch + 1;
        let v0 = KeepersRevoked{new_epoch: arg0.keeper_epoch};
        0x2::event::emit<KeepersRevoked>(v0);
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

    public fun set_config<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &VaultOwnerCap, arg2: &Registry, arg3: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg4: u32, arg5: u64, arg6: bool) {
        assert_version(arg2);
        assert_cap<T0, T1>(arg0, arg1);
        assert!(0x2::object::id<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>>(arg3) == arg0.pool_id, 5);
        assert_width_valid(arg4, 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::tick_spacing<T0, T1>(arg3));
        if (arg6 && !arg0.config.auto_rebalance) {
            assert!(!arg2.paused, 2);
            assert!(total_value_in_y<T0, T1>(arg0, 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::sqrt_price<T0, T1>(arg3)) >= arg2.min_vault_value_y, 15);
        };
        let v0 = VaultConfig{
            width_ticks    : arg4,
            delay_ms       : arg5,
            auto_rebalance : arg6,
        };
        arg0.config = v0;
        let v1 = ConfigUpdated{
            vault_id       : 0x2::object::id<Vault<T0, T1>>(arg0),
            width_ticks    : arg4,
            delay_ms       : arg5,
            auto_rebalance : arg6,
        };
        0x2::event::emit<ConfigUpdated>(v1);
    }

    public fun set_fees(arg0: &mut Registry, arg1: &AdminCap, arg2: u64, arg3: u64, arg4: address) {
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

    public fun set_paused(arg0: &mut Registry, arg1: &AdminCap, arg2: bool) {
        arg0.paused = arg2;
        let v0 = PausedChanged{paused: arg2};
        0x2::event::emit<PausedChanged>(v0);
    }

    public fun set_risk_params(arg0: &mut Registry, arg1: &AdminCap, arg2: u64, arg3: u64, arg4: u256, arg5: u64) {
        assert!(arg2 <= 500, 11);
        arg0.max_loss_bps = arg2;
        arg0.min_rebalance_interval_ms = arg3;
        arg0.min_vault_value_y = arg4;
        arg0.max_price_drift_bps = arg5;
        let v0 = RiskParamsChanged{
            max_loss_bps              : arg2,
            min_rebalance_interval_ms : arg3,
            min_vault_value_y         : arg4,
            max_price_drift_bps       : arg5,
        };
        0x2::event::emit<RiskParamsChanged>(v0);
    }

    public fun skim_yield<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &RebalanceTicket, arg2: &Registry, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>) {
        assert_version(arg2);
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0, T1>>(arg0), 6);
        let v0 = 0x2::coin::into_balance<T0>(arg3);
        let v1 = 0x2::coin::into_balance<T1>(arg4);
        let v2 = &mut v0;
        let (v3, v4) = split_fee<T0>(arg2, &arg0.affiliate, v2);
        let v5 = &mut v1;
        let (v6, v7) = split_fee<T1>(arg2, &arg0.affiliate, v5);
        let v8 = YieldSkimmed{
            vault_id    : 0x2::object::id<Vault<T0, T1>>(arg0),
            fee_x       : v3,
            fee_y       : v6,
            affiliate_x : v4,
            affiliate_y : v7,
        };
        0x2::event::emit<YieldSkimmed>(v8);
        0x2::balance::join<T0>(&mut arg0.balance_x, v0);
        0x2::balance::join<T1>(&mut arg0.balance_y, v1);
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
        if (is_in_range<T0, T1>(arg1, 0x1::option::borrow<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::position::Position>(&arg0.position))) {
            arg0.out_of_range_since_ms = 0;
        } else if (arg0.out_of_range_since_ms == 0) {
            arg0.out_of_range_since_ms = 0x2::clock::timestamp_ms(arg2);
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

