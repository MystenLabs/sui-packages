module 0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_pool {
    struct MarginPool<phantom T0> has store, key {
        id: 0x2::object::UID,
        vault: 0x2::balance::Balance<T0>,
        state: 0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_state::State,
        config: 0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::protocol_config::ProtocolConfig,
        protocol_fees: 0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::protocol_fees::ProtocolFees,
        positions: 0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::position_manager::PositionManager,
        allowed_deepbook_pools: 0x2::vec_set::VecSet<0x2::object::ID>,
        rate_limiter: 0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::rate_limiter::RateLimiter,
        extra_fields: 0x2::vec_map::VecMap<0x1::string::String, u64>,
    }

    struct SupplierCap has store, key {
        id: 0x2::object::UID,
    }

    struct MarginPoolCreated has copy, drop {
        margin_pool_id: 0x2::object::ID,
        maintainer_cap_id: 0x2::object::ID,
        asset_type: 0x1::type_name::TypeName,
        config: 0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::protocol_config::ProtocolConfig,
        timestamp: u64,
    }

    struct MaintainerFeesWithdrawn has copy, drop {
        margin_pool_id: 0x2::object::ID,
        margin_pool_cap_id: 0x2::object::ID,
        maintainer_fees: u64,
        timestamp: u64,
    }

    struct ProtocolFeesWithdrawn has copy, drop {
        margin_pool_id: 0x2::object::ID,
        protocol_fees: u64,
        timestamp: u64,
    }

    struct DeepbookPoolUpdated has copy, drop {
        margin_pool_id: 0x2::object::ID,
        deepbook_pool_id: 0x2::object::ID,
        pool_cap_id: 0x2::object::ID,
        enabled: bool,
        timestamp: u64,
    }

    struct InterestParamsUpdated has copy, drop {
        margin_pool_id: 0x2::object::ID,
        pool_cap_id: 0x2::object::ID,
        interest_config: 0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::protocol_config::InterestConfig,
        timestamp: u64,
    }

    struct MarginPoolConfigUpdated has copy, drop {
        margin_pool_id: 0x2::object::ID,
        pool_cap_id: 0x2::object::ID,
        margin_pool_config: 0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::protocol_config::MarginPoolConfig,
        timestamp: u64,
    }

    struct AssetSupplied has copy, drop {
        margin_pool_id: 0x2::object::ID,
        asset_type: 0x1::type_name::TypeName,
        supplier_cap_id: 0x2::object::ID,
        supply_amount: u64,
        supply_shares: u64,
        timestamp: u64,
    }

    struct AssetWithdrawn has copy, drop {
        margin_pool_id: 0x2::object::ID,
        asset_type: 0x1::type_name::TypeName,
        supplier_cap_id: 0x2::object::ID,
        withdraw_amount: u64,
        withdraw_shares: u64,
        timestamp: u64,
    }

    struct SupplierCapMinted has copy, drop {
        supplier_cap_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct SupplyReferralMinted has copy, drop {
        margin_pool_id: 0x2::object::ID,
        supply_referral_id: 0x2::object::ID,
        owner: address,
        timestamp: u64,
    }

    public(friend) fun borrow<T0>(arg0: &mut MarginPool<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        assert!(arg1 <= 0x2::balance::value<T0>(&arg0.vault), 1);
        assert!(arg1 >= 0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::protocol_config::min_borrow(&arg0.config), 7);
        let (v0, v1) = 0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_state::increase_borrow(&mut arg0.state, &arg0.config, arg1, arg2);
        0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::protocol_fees::increase_fees_accrued(&mut arg0.protocol_fees, id<T0>(arg0), v1);
        assert!(0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_state::utilization_rate(&arg0.state) <= 0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::protocol_config::max_utilization_rate(&arg0.config), 3);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.vault, arg1), arg3), v0)
    }

    public fun admin_withdraw_default_referral_fees<T0>(arg0: &mut MarginPool<T0>, arg1: &0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_registry::MarginRegistry, arg2: &0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_registry::MarginAdminCap, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_registry::load_inner(arg1);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.vault, 0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::protocol_fees::claim_default_referral_fees(&mut arg0.protocol_fees)), arg3)
    }

    public fun borrow_ratio<T0>(arg0: &MarginPool<T0>) : u64 {
        0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_state::borrow_ratio(&arg0.state)
    }

    public fun borrow_shares<T0>(arg0: &MarginPool<T0>) : u64 {
        0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_state::borrow_shares(&arg0.state)
    }

    public(friend) fun borrow_shares_to_amount<T0>(arg0: &MarginPool<T0>, arg1: u64, arg2: &0x2::clock::Clock) : u64 {
        0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_state::borrow_shares_to_amount(&arg0.state, arg1, &arg0.config, arg2)
    }

    public fun create_margin_pool<T0>(arg0: &mut 0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_registry::MarginRegistry, arg1: 0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::protocol_config::ProtocolConfig, arg2: &0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_registry::MaintainerCap, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::new(arg4);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = MarginPool<T0>{
            id                     : v0,
            vault                  : 0x2::balance::zero<T0>(),
            state                  : 0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_state::default(arg3),
            config                 : arg1,
            protocol_fees          : 0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::protocol_fees::default_protocol_fees(arg4),
            positions              : 0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::position_manager::create_position_manager(arg4),
            allowed_deepbook_pools : 0x2::vec_set::empty<0x2::object::ID>(),
            rate_limiter           : 0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::rate_limiter::new(0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::protocol_config::rate_limit_capacity(&arg1), 0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::protocol_config::rate_limit_refill_rate_per_ms(&arg1), 0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::protocol_config::rate_limit_enabled(&arg1), arg3),
            extra_fields           : 0x2::vec_map::empty<0x1::string::String, u64>(),
        };
        0x2::transfer::share_object<MarginPool<T0>>(v2);
        let v3 = 0x1::type_name::with_defining_ids<T0>();
        0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_registry::register_margin_pool(arg0, v3, v1, arg2, arg4);
        let v4 = MarginPoolCreated{
            margin_pool_id    : v1,
            maintainer_cap_id : 0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_registry::maintainer_cap_id(arg2),
            asset_type        : v3,
            config            : arg1,
            timestamp         : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<MarginPoolCreated>(v4);
        v1
    }

    public fun deepbook_pool_allowed<T0>(arg0: &MarginPool<T0>, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_deepbook_pools, &arg1)
    }

    public fun disable_deepbook_pool_for_loan<T0>(arg0: &mut MarginPool<T0>, arg1: &0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_registry::MarginRegistry, arg2: 0x2::object::ID, arg3: &0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_registry::MarginPoolCap, arg4: &0x2::clock::Clock) {
        0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_registry::load_inner(arg1);
        assert!(0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_registry::margin_pool_id(arg3) == id<T0>(arg0), 6);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_deepbook_pools, &arg2), 5);
        0x2::vec_set::remove<0x2::object::ID>(&mut arg0.allowed_deepbook_pools, &arg2);
        let v0 = DeepbookPoolUpdated{
            margin_pool_id   : id<T0>(arg0),
            deepbook_pool_id : arg2,
            pool_cap_id      : 0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_registry::pool_cap_id(arg3),
            enabled          : false,
            timestamp        : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<DeepbookPoolUpdated>(v0);
    }

    public fun enable_deepbook_pool_for_loan<T0>(arg0: &mut MarginPool<T0>, arg1: &0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_registry::MarginRegistry, arg2: 0x2::object::ID, arg3: &0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_registry::MarginPoolCap, arg4: &0x2::clock::Clock) {
        0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_registry::load_inner(arg1);
        assert!(0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_registry::margin_pool_id(arg3) == id<T0>(arg0), 6);
        assert!(!0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_deepbook_pools, &arg2), 4);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.allowed_deepbook_pools, arg2);
        let v0 = DeepbookPoolUpdated{
            margin_pool_id   : id<T0>(arg0),
            deepbook_pool_id : arg2,
            pool_cap_id      : 0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_registry::pool_cap_id(arg3),
            enabled          : true,
            timestamp        : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<DeepbookPoolUpdated>(v0);
    }

    public fun get_available_withdrawal<T0>(arg0: &MarginPool<T0>, arg1: &0x2::clock::Clock) : u64 {
        0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::rate_limiter::get_available_withdrawal(&arg0.rate_limiter, arg1)
    }

    public fun id<T0>(arg0: &MarginPool<T0>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun interest_rate<T0>(arg0: &MarginPool<T0>) : u64 {
        0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::protocol_config::interest_rate(&arg0.config, 0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_state::utilization_rate(&arg0.state))
    }

    public fun is_rate_limit_enabled<T0>(arg0: &MarginPool<T0>) : bool {
        0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::rate_limiter::is_enabled(&arg0.rate_limiter)
    }

    public fun last_update_timestamp<T0>(arg0: &MarginPool<T0>) : u64 {
        0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_state::last_update_timestamp(&arg0.state)
    }

    public fun max_utilization_rate<T0>(arg0: &MarginPool<T0>) : u64 {
        0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::protocol_config::max_utilization_rate(&arg0.config)
    }

    public fun min_borrow<T0>(arg0: &MarginPool<T0>) : u64 {
        0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::protocol_config::min_borrow(&arg0.config)
    }

    public fun mint_supplier_cap(arg0: &0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_registry::MarginRegistry, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : SupplierCap {
        0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_registry::load_inner(arg0);
        let v0 = 0x2::object::new(arg2);
        let v1 = SupplierCapMinted{
            supplier_cap_id : 0x2::object::uid_to_inner(&v0),
            timestamp       : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<SupplierCapMinted>(v1);
        SupplierCap{id: v0}
    }

    public fun mint_supply_referral<T0>(arg0: &mut MarginPool<T0>, arg1: &0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_registry::MarginRegistry, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_registry::load_inner(arg1);
        let v0 = 0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::protocol_fees::mint_supply_referral(&mut arg0.protocol_fees, arg3);
        let v1 = SupplyReferralMinted{
            margin_pool_id     : id<T0>(arg0),
            supply_referral_id : v0,
            owner              : 0x2::tx_context::sender(arg3),
            timestamp          : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<SupplyReferralMinted>(v1);
        v0
    }

    public fun protocol_fees<T0>(arg0: &MarginPool<T0>) : &0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::protocol_fees::ProtocolFees {
        &arg0.protocol_fees
    }

    public fun protocol_spread<T0>(arg0: &MarginPool<T0>) : u64 {
        0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::protocol_config::protocol_spread(&arg0.config)
    }

    public fun rate_limit_capacity<T0>(arg0: &MarginPool<T0>) : u64 {
        0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::rate_limiter::capacity(&arg0.rate_limiter)
    }

    public fun rate_limit_refill_rate_per_ms<T0>(arg0: &MarginPool<T0>) : u64 {
        0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::rate_limiter::refill_rate_per_ms(&arg0.rate_limiter)
    }

    public(friend) fun repay<T0>(arg0: &mut MarginPool<T0>, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock) {
        let (_, v1) = 0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_state::decrease_borrow_shares(&mut arg0.state, &arg0.config, arg1, arg3);
        0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::protocol_fees::increase_fees_accrued(&mut arg0.protocol_fees, id<T0>(arg0), v1);
        0x2::balance::join<T0>(&mut arg0.vault, 0x2::coin::into_balance<T0>(arg2));
    }

    public(friend) fun repay_liquidation<T0>(arg0: &mut MarginPool<T0>, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock) : (u64, u64, u64) {
        let (v0, v1) = 0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_state::decrease_borrow_shares(&mut arg0.state, &arg0.config, arg1, arg3);
        0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::protocol_fees::increase_fees_accrued(&mut arg0.protocol_fees, id<T0>(arg0), v1);
        let v2 = 0x2::coin::value<T0>(&arg2);
        let (v3, v4) = if (v2 > v0) {
            0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_state::increase_supply_absolute(&mut arg0.state, v2 - v0);
            (v2 - v0, 0)
        } else {
            0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_state::decrease_supply_absolute(&mut arg0.state, v0 - v2);
            (0, v0 - v2)
        };
        0x2::balance::join<T0>(&mut arg0.vault, 0x2::coin::into_balance<T0>(arg2));
        (v0, v3, v4)
    }

    public fun supply<T0>(arg0: &mut MarginPool<T0>, arg1: &0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_registry::MarginRegistry, arg2: &SupplierCap, arg3: 0x2::coin::Coin<T0>, arg4: 0x1::option::Option<0x2::object::ID>, arg5: &0x2::clock::Clock) : u64 {
        0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_registry::load_inner(arg1);
        let v0 = 0x2::object::uid_to_inner(&arg2.id);
        let v1 = 0x2::coin::value<T0>(&arg3);
        let (v2, v3) = 0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_state::increase_supply(&mut arg0.state, &arg0.config, v1, arg5);
        0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::protocol_fees::increase_fees_accrued(&mut arg0.protocol_fees, id<T0>(arg0), v3);
        let (v4, v5) = 0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::position_manager::increase_user_supply(&mut arg0.positions, v0, arg4, v2);
        0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::protocol_fees::decrease_shares(&mut arg0.protocol_fees, v5, v4 - v2);
        0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::protocol_fees::increase_shares(&mut arg0.protocol_fees, arg4, v4);
        0x2::balance::join<T0>(&mut arg0.vault, 0x2::coin::into_balance<T0>(arg3));
        assert!(0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_state::total_supply(&arg0.state) <= 0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::protocol_config::supply_cap(&arg0.config), 2);
        let v6 = AssetSupplied{
            margin_pool_id  : id<T0>(arg0),
            asset_type      : 0x1::type_name::with_defining_ids<T0>(),
            supplier_cap_id : v0,
            supply_amount   : v1,
            supply_shares   : v2,
            timestamp       : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<AssetSupplied>(v6);
        v4
    }

    public fun supply_cap<T0>(arg0: &MarginPool<T0>) : u64 {
        0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::protocol_config::supply_cap(&arg0.config)
    }

    public fun supply_ratio<T0>(arg0: &MarginPool<T0>) : u64 {
        0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_state::supply_ratio(&arg0.state)
    }

    public fun supply_shares<T0>(arg0: &MarginPool<T0>) : u64 {
        0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_state::supply_shares(&arg0.state)
    }

    public fun total_borrow<T0>(arg0: &MarginPool<T0>) : u64 {
        0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_state::total_borrow(&arg0.state)
    }

    public fun total_supply<T0>(arg0: &MarginPool<T0>) : u64 {
        0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_state::total_supply(&arg0.state)
    }

    public fun total_supply_with_interest<T0>(arg0: &MarginPool<T0>, arg1: &0x2::clock::Clock) : u64 {
        0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_state::total_supply_with_interest(&arg0.state, &arg0.config, arg1)
    }

    public fun true_interest_rate<T0>(arg0: &MarginPool<T0>) : u64 {
        0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::math::mul(0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::math::mul(interest_rate<T0>(arg0), 0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_state::utilization_rate(&arg0.state)), 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::constants::float_scaling() - protocol_spread<T0>(arg0))
    }

    public fun update_interest_params<T0>(arg0: &mut MarginPool<T0>, arg1: &0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_registry::MarginRegistry, arg2: 0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::protocol_config::InterestConfig, arg3: &0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_registry::MarginPoolCap, arg4: &0x2::clock::Clock) {
        0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_registry::load_inner(arg1);
        assert!(0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_registry::margin_pool_id(arg3) == id<T0>(arg0), 6);
        let v0 = id<T0>(arg0);
        0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::protocol_fees::increase_fees_accrued(&mut arg0.protocol_fees, v0, 0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_state::update(&mut arg0.state, &arg0.config, arg4));
        0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::protocol_config::set_interest_config(&mut arg0.config, arg2);
        let v1 = InterestParamsUpdated{
            margin_pool_id  : v0,
            pool_cap_id     : 0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_registry::pool_cap_id(arg3),
            interest_config : arg2,
            timestamp       : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<InterestParamsUpdated>(v1);
    }

    public fun update_margin_pool_config<T0>(arg0: &mut MarginPool<T0>, arg1: &0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_registry::MarginRegistry, arg2: 0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::protocol_config::MarginPoolConfig, arg3: &0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_registry::MarginPoolCap, arg4: &0x2::clock::Clock) {
        0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_registry::load_inner(arg1);
        assert!(0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_registry::margin_pool_id(arg3) == id<T0>(arg0), 6);
        0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::protocol_config::set_margin_pool_config(&mut arg0.config, arg2);
        0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::rate_limiter::update_config(&mut arg0.rate_limiter, 0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::protocol_config::rate_limit_capacity_from_config(&arg2), 0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::protocol_config::rate_limit_refill_rate_per_ms_from_config(&arg2), 0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::protocol_config::rate_limit_enabled_from_config(&arg2), arg4);
        let v0 = MarginPoolConfigUpdated{
            margin_pool_id     : id<T0>(arg0),
            pool_cap_id        : 0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_registry::pool_cap_id(arg3),
            margin_pool_config : arg2,
            timestamp          : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<MarginPoolConfigUpdated>(v0);
    }

    public fun user_supply_amount<T0>(arg0: &MarginPool<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : u64 {
        0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_state::supply_shares_to_amount(&arg0.state, user_supply_shares<T0>(arg0, arg1), &arg0.config, arg2)
    }

    public fun user_supply_shares<T0>(arg0: &MarginPool<T0>, arg1: 0x2::object::ID) : u64 {
        0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::position_manager::user_supply_shares(&arg0.positions, arg1)
    }

    public fun vault_balance<T0>(arg0: &MarginPool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.vault)
    }

    public fun withdraw<T0>(arg0: &mut MarginPool<T0>, arg1: &0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_registry::MarginRegistry, arg2: &SupplierCap, arg3: 0x1::option::Option<u64>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_registry::load_inner(arg1);
        let v0 = 0x2::object::uid_to_inner(&arg2.id);
        let v1 = 0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::position_manager::user_supply_shares(&arg0.positions, v0);
        let v2 = 0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_state::supply_shares_to_amount(&arg0.state, v1, &arg0.config, arg4);
        let v3 = 0x1::option::destroy_with_default<u64>(arg3, v2);
        let v4 = 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::math::mul_round_up(v1, 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::math::div(v3, v2));
        assert!(0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::rate_limiter::check_and_record_withdrawal(&mut arg0.rate_limiter, v3, arg4), 8);
        let (_, v6) = 0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_state::decrease_supply_shares(&mut arg0.state, &arg0.config, v4, arg4);
        0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::protocol_fees::increase_fees_accrued(&mut arg0.protocol_fees, id<T0>(arg0), v6);
        let (_, v8) = 0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::position_manager::decrease_user_supply(&mut arg0.positions, v0, v4);
        0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::protocol_fees::decrease_shares(&mut arg0.protocol_fees, v8, v4);
        assert!(v3 <= 0x2::balance::value<T0>(&arg0.vault), 1);
        let v9 = AssetWithdrawn{
            margin_pool_id  : id<T0>(arg0),
            asset_type      : 0x1::type_name::with_defining_ids<T0>(),
            supplier_cap_id : v0,
            withdraw_amount : v3,
            withdraw_shares : v4,
            timestamp       : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<AssetWithdrawn>(v9);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.vault, v3), arg5)
    }

    public fun withdraw_maintainer_fees<T0>(arg0: &mut MarginPool<T0>, arg1: &0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_registry::MarginRegistry, arg2: &0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_registry::MarginPoolCap, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_registry::load_inner(arg1);
        assert!(0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_registry::margin_pool_id(arg2) == id<T0>(arg0), 6);
        let v0 = 0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::protocol_fees::claim_maintainer_fees(&mut arg0.protocol_fees);
        let v1 = MaintainerFeesWithdrawn{
            margin_pool_id     : id<T0>(arg0),
            margin_pool_cap_id : 0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_registry::pool_cap_id(arg2),
            maintainer_fees    : v0,
            timestamp          : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<MaintainerFeesWithdrawn>(v1);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.vault, v0), arg4)
    }

    public fun withdraw_protocol_fees<T0>(arg0: &mut MarginPool<T0>, arg1: &0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_registry::MarginRegistry, arg2: &0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_registry::MarginAdminCap, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_registry::load_inner(arg1);
        let v0 = 0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::protocol_fees::claim_protocol_fees(&mut arg0.protocol_fees);
        let v1 = ProtocolFeesWithdrawn{
            margin_pool_id : id<T0>(arg0),
            protocol_fees  : v0,
            timestamp      : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<ProtocolFeesWithdrawn>(v1);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.vault, v0), arg4)
    }

    public fun withdraw_referral_fees<T0>(arg0: &mut MarginPool<T0>, arg1: &0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_registry::MarginRegistry, arg2: &0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::protocol_fees::SupplyReferral, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_registry::load_inner(arg1);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.vault, 0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::protocol_fees::calculate_and_claim(&mut arg0.protocol_fees, arg2, arg3)), arg3)
    }

    // decompiled from Move bytecode v6
}

