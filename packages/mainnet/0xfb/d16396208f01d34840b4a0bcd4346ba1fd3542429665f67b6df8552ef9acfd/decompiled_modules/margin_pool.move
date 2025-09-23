module 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_pool {
    struct MarginPool<phantom T0> has store, key {
        id: 0x2::object::UID,
        vault: 0x2::balance::Balance<T0>,
        state: 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_state::State,
        config: 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::protocol_config::ProtocolConfig,
        protocol_fees: 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::protocol_fees::ProtocolFees,
        positions: 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::position_manager::PositionManager,
        allowed_deepbook_pools: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct MarginPoolCreated has copy, drop {
        margin_pool_id: 0x2::object::ID,
        maintainer_cap_id: 0x2::object::ID,
        asset_type: 0x1::type_name::TypeName,
        config: 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::protocol_config::ProtocolConfig,
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
        interest_config: 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::protocol_config::InterestConfig,
        timestamp: u64,
    }

    struct MarginPoolConfigUpdated has copy, drop {
        margin_pool_id: 0x2::object::ID,
        pool_cap_id: 0x2::object::ID,
        margin_pool_config: 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::protocol_config::MarginPoolConfig,
        timestamp: u64,
    }

    struct AssetSupplied has copy, drop {
        margin_pool_id: 0x2::object::ID,
        asset_type: 0x1::type_name::TypeName,
        supplier: address,
        supply_amount: u64,
        supply_shares: u64,
        timestamp: u64,
    }

    struct AssetWithdrawn has copy, drop {
        margin_pool_id: 0x2::object::ID,
        asset_type: 0x1::type_name::TypeName,
        supplier: address,
        withdraw_amount: u64,
        withdraw_shares: u64,
        timestamp: u64,
    }

    public(friend) fun borrow<T0>(arg0: &mut MarginPool<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64, u64) {
        assert!(arg1 <= 0x2::balance::value<T0>(&arg0.vault), 1);
        assert!(arg1 >= 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::protocol_config::min_borrow(&arg0.config), 8);
        let (v0, v1, v2) = 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_state::increase_borrow(&mut arg0.state, &arg0.config, arg1, arg2);
        0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::protocol_fees::increase_fees_per_share(&mut arg0.protocol_fees, 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_state::supply_shares(&arg0.state), v2);
        assert!(0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_state::utilization_rate(&arg0.state) <= 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::protocol_config::max_utilization_rate(&arg0.config), 4);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.vault, arg1), arg3), v0, v1)
    }

    public(friend) fun borrow_shares_to_amount<T0>(arg0: &MarginPool<T0>, arg1: u64, arg2: &0x2::clock::Clock) : u64 {
        0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_state::borrow_shares_to_amount(&arg0.state, arg1, &arg0.config, arg2)
    }

    public fun create_margin_pool<T0>(arg0: &mut 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::MarginRegistry, arg1: 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::protocol_config::ProtocolConfig, arg2: &0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::MaintainerCap, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::new(arg4);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = MarginPool<T0>{
            id                     : v0,
            vault                  : 0x2::balance::zero<T0>(),
            state                  : 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_state::default(arg3),
            config                 : arg1,
            protocol_fees          : 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::protocol_fees::default_protocol_fees(arg4, arg3),
            positions              : 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::position_manager::create_position_manager(arg4),
            allowed_deepbook_pools : 0x2::vec_set::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<MarginPool<T0>>(v2);
        let v3 = 0x1::type_name::with_defining_ids<T0>();
        0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::register_margin_pool(arg0, v3, v1, arg2, arg4);
        let v4 = MarginPoolCreated{
            margin_pool_id    : v1,
            maintainer_cap_id : 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::maintainer_cap_id(arg2),
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

    public fun disable_deepbook_pool_for_loan<T0>(arg0: &mut MarginPool<T0>, arg1: &0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::MarginRegistry, arg2: 0x2::object::ID, arg3: &0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::MarginPoolCap, arg4: &0x2::clock::Clock) {
        0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::load_inner(arg1);
        assert!(0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::margin_pool_id(arg3) == id<T0>(arg0), 7);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_deepbook_pools, &arg2), 6);
        0x2::vec_set::remove<0x2::object::ID>(&mut arg0.allowed_deepbook_pools, &arg2);
        let v0 = DeepbookPoolUpdated{
            margin_pool_id   : id<T0>(arg0),
            deepbook_pool_id : arg2,
            pool_cap_id      : 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::pool_cap_id(arg3),
            enabled          : false,
            timestamp        : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<DeepbookPoolUpdated>(v0);
    }

    public fun enable_deepbook_pool_for_loan<T0>(arg0: &mut MarginPool<T0>, arg1: &0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::MarginRegistry, arg2: 0x2::object::ID, arg3: &0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::MarginPoolCap, arg4: &0x2::clock::Clock) {
        0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::load_inner(arg1);
        assert!(0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::margin_pool_id(arg3) == id<T0>(arg0), 7);
        assert!(!0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_deepbook_pools, &arg2), 5);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.allowed_deepbook_pools, arg2);
        let v0 = DeepbookPoolUpdated{
            margin_pool_id   : id<T0>(arg0),
            deepbook_pool_id : arg2,
            pool_cap_id      : 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::pool_cap_id(arg3),
            enabled          : true,
            timestamp        : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<DeepbookPoolUpdated>(v0);
    }

    public(friend) fun id<T0>(arg0: &MarginPool<T0>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public(friend) fun repay<T0>(arg0: &mut MarginPool<T0>, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock) {
        let (_, v1) = 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_state::decrease_borrow_shares(&mut arg0.state, &arg0.config, arg1, arg3);
        0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::protocol_fees::increase_fees_per_share(&mut arg0.protocol_fees, 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_state::supply_shares(&arg0.state), v1);
        0x2::balance::join<T0>(&mut arg0.vault, 0x2::coin::into_balance<T0>(arg2));
    }

    public(friend) fun repay_liquidation<T0>(arg0: &mut MarginPool<T0>, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock) : (u64, u64, u64) {
        let (v0, v1) = 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_state::decrease_borrow_shares(&mut arg0.state, &arg0.config, arg1, arg3);
        0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::protocol_fees::increase_fees_per_share(&mut arg0.protocol_fees, 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_state::supply_shares(&arg0.state), v1);
        let v2 = 0x2::coin::value<T0>(&arg2);
        let (v3, v4) = if (v2 > v0) {
            0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_state::increase_supply_absolute(&mut arg0.state, v2 - v0);
            (v2 - v0, 0)
        } else {
            0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_state::decrease_supply_absolute(&mut arg0.state, v0 - v2);
            (0, v0 - v2)
        };
        0x2::balance::join<T0>(&mut arg0.vault, 0x2::coin::into_balance<T0>(arg2));
        (v0, v3, v4)
    }

    public fun supply<T0>(arg0: &mut MarginPool<T0>, arg1: &0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::MarginRegistry, arg2: 0x2::coin::Coin<T0>, arg3: 0x1::option::Option<address>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : u64 {
        0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::load_inner(arg1);
        let v0 = 0x2::coin::value<T0>(&arg2);
        let (v1, v2) = 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_state::increase_supply(&mut arg0.state, &arg0.config, v0, arg4);
        0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::protocol_fees::increase_fees_per_share(&mut arg0.protocol_fees, 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_state::supply_shares(&arg0.state), v2);
        let (v3, v4) = 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::position_manager::increase_user_supply(&mut arg0.positions, arg3, v1, arg5);
        0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::protocol_fees::decrease_shares(&mut arg0.protocol_fees, v4, v3 - v1, arg4);
        0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::protocol_fees::increase_shares(&mut arg0.protocol_fees, arg3, v3, arg4);
        0x2::balance::join<T0>(&mut arg0.vault, 0x2::coin::into_balance<T0>(arg2));
        assert!(0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_state::supply(&arg0.state) <= 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::protocol_config::supply_cap(&arg0.config), 2);
        let v5 = AssetSupplied{
            margin_pool_id : id<T0>(arg0),
            asset_type     : 0x1::type_name::with_defining_ids<T0>(),
            supplier       : 0x2::tx_context::sender(arg5),
            supply_amount  : v0,
            supply_shares  : v1,
            timestamp      : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<AssetSupplied>(v5);
        v3
    }

    public fun update_interest_params<T0>(arg0: &mut MarginPool<T0>, arg1: &0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::MarginRegistry, arg2: 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::protocol_config::InterestConfig, arg3: &0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::MarginPoolCap, arg4: &0x2::clock::Clock) {
        0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::load_inner(arg1);
        assert!(0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::margin_pool_id(arg3) == id<T0>(arg0), 7);
        0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::protocol_config::set_interest_config(&mut arg0.config, arg2);
        let v0 = InterestParamsUpdated{
            margin_pool_id  : id<T0>(arg0),
            pool_cap_id     : 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::pool_cap_id(arg3),
            interest_config : arg2,
            timestamp       : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<InterestParamsUpdated>(v0);
    }

    public fun update_margin_pool_config<T0>(arg0: &mut MarginPool<T0>, arg1: &0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::MarginRegistry, arg2: 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::protocol_config::MarginPoolConfig, arg3: &0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::MarginPoolCap, arg4: &0x2::clock::Clock) {
        0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::load_inner(arg1);
        assert!(0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::margin_pool_id(arg3) == id<T0>(arg0), 7);
        0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::protocol_config::set_margin_pool_config(&mut arg0.config, arg2);
        let v0 = MarginPoolConfigUpdated{
            margin_pool_id     : id<T0>(arg0),
            pool_cap_id        : 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::pool_cap_id(arg3),
            margin_pool_config : arg2,
            timestamp          : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<MarginPoolConfigUpdated>(v0);
    }

    public fun withdraw<T0>(arg0: &mut MarginPool<T0>, arg1: &0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::MarginRegistry, arg2: 0x1::option::Option<u64>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_registry::load_inner(arg1);
        let v0 = 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::position_manager::user_supply_shares(&arg0.positions, arg4);
        let v1 = 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_state::supply_shares_to_amount(&arg0.state, v0, &arg0.config, arg3);
        let v2 = 0x1::option::destroy_with_default<u64>(arg2, v1);
        let v3 = 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::math::mul(v0, 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::math::div(v2, v1));
        let (_, v5) = 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_state::decrease_supply_shares(&mut arg0.state, &arg0.config, v3, arg3);
        0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::protocol_fees::increase_fees_per_share(&mut arg0.protocol_fees, 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_state::supply_shares(&arg0.state), v5);
        let (_, v7) = 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::position_manager::decrease_user_supply(&mut arg0.positions, v3, arg4);
        0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::protocol_fees::decrease_shares(&mut arg0.protocol_fees, v7, v3, arg3);
        assert!(v2 <= 0x2::balance::value<T0>(&arg0.vault), 1);
        let v8 = AssetWithdrawn{
            margin_pool_id  : id<T0>(arg0),
            asset_type      : 0x1::type_name::with_defining_ids<T0>(),
            supplier        : 0x2::tx_context::sender(arg4),
            withdraw_amount : v2,
            withdraw_shares : v3,
            timestamp       : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<AssetWithdrawn>(v8);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.vault, v2), arg4)
    }

    public fun withdraw_referral_fees<T0>(arg0: &mut MarginPool<T0>, arg1: &mut 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::protocol_fees::Referral, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.vault, 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::protocol_fees::calculate_and_claim(&mut arg0.protocol_fees, arg1, arg2)), arg3)
    }

    // decompiled from Move bytecode v6
}

