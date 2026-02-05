module 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_core {
    struct Vault<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        vault_name: 0x1::string::String,
        asset_decimals: u8,
        total_shares: u64,
        htoken_treasury: 0x2::coin::TreasuryCap<T1>,
        lost_assets: u128,
        asset_reserve: 0x2::balance::Balance<T0>,
        governance: 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_governance::Governance,
        strategy: 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_strategy::Strategy,
        allocator: 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_allocator::AllocatorState,
        fees: 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_fees::FeeConfig,
    }

    public(friend) fun withdraw<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::market::Hearn, arg2: 0x2::coin::Coin<T1>, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x1::option::Option<0x2::coin::Coin<T1>>) {
        assert_withdraw_not_paused<T0, T1>(arg0, arg1);
        0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_strategy::check_withdraw_cooldown(&arg0.strategy, 0x2::tx_context::sender(arg5), 0x2::clock::timestamp_ms(arg4));
        let v0 = calculate_total_assets<T0, T1>(arg0, arg1);
        assert!(arg3 <= convert_to_assets_down((0x2::coin::value<T1>(&arg2) as u128), (arg0.total_shares as u128), v0, arg0.asset_decimals), 8);
        let v1 = convert_to_shares_up(arg3, (arg0.total_shares as u128), v0, arg0.asset_decimals);
        let v2 = v1;
        let v3 = (0x2::coin::value<T1>(&arg2) as u128);
        if (v1 > v3) {
            v2 = v3;
        };
        let v4 = 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::math::to_u64(v2);
        let v5 = withdraw_assets_internal<T0, T1>(arg0, arg1, arg3, v2, arg4, arg5);
        let v6 = if (v4 == 0x2::coin::value<T1>(&arg2)) {
            0x2::coin::burn<T1>(&mut arg0.htoken_treasury, arg2);
            0x1::option::none<0x2::coin::Coin<T1>>()
        } else {
            0x2::coin::burn<T1>(&mut arg0.htoken_treasury, 0x2::coin::split<T1>(&mut arg2, v4, arg5));
            0x1::option::some<0x2::coin::Coin<T1>>(arg2)
        };
        (v5, v6)
    }

    public(friend) fun accrue_fees_internal<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::market::Hearn, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = calculate_total_assets<T0, T1>(arg0, arg1);
        let (v1, v2, v3, v4, v5, v6) = 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_fees::accrue_fees<T1>(&mut arg0.fees, v0, arg0.total_shares, 0x2::clock::timestamp_ms(arg2), &mut arg0.htoken_treasury, arg3);
        arg0.total_shares = arg0.total_shares + v1;
        if (v1 > 0 || v4 != v0) {
            0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_events::emit_accrue_fees(0x2::object::uid_to_address(&arg0.id), v2, v3, v4, v5, v6, (v1 as u128), v0, arg0.total_shares, 0x1::type_name::with_defining_ids<T0>(), 0x1::type_name::with_defining_ids<T1>(), arg3);
        };
    }

    fun add_unique_markets(arg0: &mut vector<u64>, arg1: &vector<u64>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(arg1)) {
            let v1 = *0x1::vector::borrow<u64>(arg1, v0);
            if (!contains_market(arg0, v1)) {
                0x1::vector::push_back<u64>(arg0, v1);
            };
            v0 = v0 + 1;
        };
    }

    public(friend) fun allocator_mut<T0, T1>(arg0: &mut Vault<T0, T1>) : &mut 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_allocator::AllocatorState {
        &mut arg0.allocator
    }

    fun assert_deposit_not_paused<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::market::Hearn) {
        assert!(!0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_governance::is_deposit_paused(&arg0.governance), 12);
        assert!(!0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::market::is_global_paused(arg1), 14);
    }

    fun assert_withdraw_not_paused<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::market::Hearn) {
        assert!(!0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_governance::is_withdraw_paused(&arg0.governance), 13);
        assert!(!0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::market::is_global_paused(arg1), 14);
    }

    public(friend) fun asset_reserve_mut<T0, T1>(arg0: &mut Vault<T0, T1>) : &mut 0x2::balance::Balance<T0> {
        &mut arg0.asset_reserve
    }

    fun calculate_total_assets<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::market::Hearn) : u128 {
        let v0 = (0x2::balance::value<T0>(&arg0.asset_reserve) as u128);
        let v1 = collect_ordered_markets(&arg0.strategy);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&v1)) {
            v0 = v0 + 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::market::user_position_supply_assets(arg1, *0x1::vector::borrow<u64>(&v1, v2), 0x2::object::uid_to_address(&arg0.id));
            v2 = v2 + 1;
        };
        v0
    }

    public fun calculate_total_weight<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_strategy::calculate_total_weight(&arg0.strategy)
    }

    public fun calculate_user_earnings<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::market::Hearn, arg2: u128, arg3: u128) : u128 {
        let v0 = get_user_asset_value<T0, T1>(arg0, arg1, arg2);
        if (v0 > arg3) {
            v0 - arg3
        } else {
            0
        }
    }

    public fun can_user_withdraw<T0, T1>(arg0: &Vault<T0, T1>, arg1: address, arg2: &0x2::clock::Clock) : bool {
        let v0 = 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_strategy::get_withdraw_cooldown(&arg0.strategy);
        if (v0 == 0) {
            return true
        };
        let v1 = 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_strategy::get_user_last_deposit(&arg0.strategy, arg1);
        if (v1 == 0) {
            return true
        };
        0x2::clock::timestamp_ms(arg2) - v1 >= v0
    }

    public fun check_deposit_limits<T0, T1>(arg0: &Vault<T0, T1>, arg1: u128) {
        0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_strategy::check_deposit_limits(&arg0.strategy, arg1);
    }

    fun collect_ordered_markets(arg0: &0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_strategy::Strategy) : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = &mut v0;
        add_unique_markets(v1, 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_strategy::borrow_withdraw_queue(arg0));
        let v2 = &mut v0;
        add_unique_markets(v2, 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_strategy::borrow_supply_queue(arg0));
        v0
    }

    fun contains_market(arg0: &vector<u64>, arg1: u64) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(arg0)) {
            if (*0x1::vector::borrow<u64>(arg0, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    fun convert_to_assets_down(arg0: u128, arg1: u128, arg2: u128, arg3: u8) : u128 {
        0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::math::mul_div_down(arg0, arg2 + 1, arg1 + meta_vault_virtual_shares(arg3))
    }

    fun convert_to_shares_down(arg0: u128, arg1: u128, arg2: u128, arg3: u8) : u128 {
        0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::math::mul_div_down(arg0, arg1 + meta_vault_virtual_shares(arg3), arg2 + 1)
    }

    fun convert_to_shares_up(arg0: u128, arg1: u128, arg2: u128, arg3: u8) : u128 {
        0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::math::mul_div_up(arg0, arg1 + meta_vault_virtual_shares(arg3), arg2 + 1)
    }

    public(friend) fun create<T0, T1>(arg0: 0x1::string::String, arg1: address, arg2: address, arg3: address, arg4: address, arg5: &0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::market::Hearn, arg6: u8, arg7: u128, arg8: 0x2::coin::TreasuryCap<T1>, arg9: &mut 0x2::tx_context::TxContext) : address {
        let v0 = Vault<T0, T1>{
            id              : 0x2::object::new(arg9),
            vault_name      : arg0,
            asset_decimals  : arg6,
            total_shares    : 0,
            htoken_treasury : arg8,
            lost_assets     : 0,
            asset_reserve   : 0x2::balance::zero<T0>(),
            governance      : 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_governance::new(arg1, arg2, arg3, arg4),
            strategy        : 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_strategy::new(arg7, arg9),
            allocator       : 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_allocator::new(),
            fees            : 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_fees::new(arg1),
        };
        let v1 = 0x2::object::uid_to_address(&v0.id);
        0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_events::emit_vault(v1, arg1, arg2, arg3, arg4, arg6, 0x1::type_name::with_defining_ids<T0>(), 0x1::type_name::with_defining_ids<T1>());
        0x2::transfer::share_object<Vault<T0, T1>>(v0);
        v1
    }

    public(friend) fun deposit<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::market::Hearn, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_deposit_not_paused<T0, T1>(arg0, arg1);
        deposit_assets_internal<T0, T1>(arg0, arg1, arg2, arg3, arg4)
    }

    fun deposit_assets_internal<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::market::Hearn, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        accrue_fees_internal<T0, T1>(arg0, arg1, arg3, arg4);
        let v0 = (0x2::coin::value<T0>(&arg2) as u128);
        0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_strategy::check_deposit_limits(&arg0.strategy, v0);
        let v1 = calculate_total_assets<T0, T1>(arg0, arg1);
        if (0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_strategy::get_supply_cap(&arg0.strategy) > 0) {
            assert!(v1 + v0 <= 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_strategy::get_supply_cap(&arg0.strategy), 5);
        };
        let v2 = convert_to_shares_down(v0, (arg0.total_shares as u128), v1, arg0.asset_decimals);
        let v3 = v0 > 0 && v2 == 0;
        assert!(!v3, 8);
        let v4 = 0x2::tx_context::sender(arg4);
        0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_strategy::record_deposit_time(&mut arg0.strategy, v4, 0x2::clock::timestamp_ms(arg3));
        0x2::balance::join<T0>(&mut arg0.asset_reserve, 0x2::coin::into_balance<T0>(arg2));
        let v5 = 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::math::to_u64(v2);
        arg0.total_shares = arg0.total_shares + v5;
        let v6 = 0x2::object::uid_to_address(&arg0.id);
        supply_to_markets<T0, T1>(arg0, arg1, v6, v0, arg3, arg4);
        0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_fees::update_last_total_assets(&mut arg0.fees, v1 + v0);
        0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_events::emit_vault_deposit(v6, v4, v0, v2, 0x1::type_name::with_defining_ids<T0>(), 0x1::type_name::with_defining_ids<T1>(), arg4);
        0x2::coin::mint<T1>(&mut arg0.htoken_treasury, v5, arg4)
    }

    public(friend) fun fees_mut<T0, T1>(arg0: &mut Vault<T0, T1>) : &mut 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_fees::FeeConfig {
        &mut arg0.fees
    }

    public fun get_allocations<T0, T1>(arg0: &Vault<T0, T1>) : vector<0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_strategy::MarketAllocation> {
        0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_strategy::get_allocations(&arg0.strategy)
    }

    public fun get_asset_reserve<T0, T1>(arg0: &Vault<T0, T1>) : u128 {
        (0x2::balance::value<T0>(&arg0.asset_reserve) as u128)
    }

    public fun get_deposit_limits<T0, T1>(arg0: &Vault<T0, T1>) : (u128, u128) {
        0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_strategy::get_deposit_limits(&arg0.strategy)
    }

    public fun get_estimated_apy<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::market::Hearn, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_fees::get_last_total_assets(&arg0.fees);
        if (0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_fees::get_last_fee_collection_ms(&arg0.fees) == 0 || v0 == 0) {
            return 0
        };
        let v1 = 0x2::clock::timestamp_ms(arg2) - 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_fees::get_last_fee_collection_ms(&arg0.fees);
        if (v1 < 3600000) {
            return 0
        };
        let v2 = calculate_total_assets<T0, T1>(arg0, arg1);
        if (v2 <= v0) {
            return 0
        };
        let v3 = 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::math::mul_div_down(0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::math::mul_div_down(v2 - v0, (10000 as u128), v0), 31536000000, (v1 as u128));
        if (v3 > 18446744073709551615) {
            18446744073709551615
        } else {
            (v3 as u64)
        }
    }

    public fun get_exchange_rate<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::market::Hearn) : u128 {
        let v0 = arg0.asset_decimals;
        convert_to_assets_down(power_of_10(v0) * meta_vault_virtual_shares(v0), (arg0.total_shares as u128), calculate_total_assets<T0, T1>(arg0, arg1), v0)
    }

    public fun get_fee_recipient<T0, T1>(arg0: &Vault<T0, T1>) : address {
        0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_fees::get_fee_recipient(&arg0.fees)
    }

    public fun get_governance_addresses<T0, T1>(arg0: &Vault<T0, T1>) : (address, address, address, address) {
        0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_governance::get_addresses(&arg0.governance)
    }

    public fun get_last_fee_collection<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_fees::get_last_fee_collection_ms(&arg0.fees)
    }

    public fun get_last_rebalance_time<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_allocator::get_last_rebalance(&arg0.allocator)
    }

    public fun get_lost_assets<T0, T1>(arg0: &Vault<T0, T1>) : u128 {
        arg0.lost_assets
    }

    public fun get_market_allocation<T0, T1>(arg0: &Vault<T0, T1>, arg1: u64) : (u128, u64) {
        0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_strategy::get_market_allocation(&arg0.strategy, arg1)
    }

    public fun get_min_rebalance_interval<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_allocator::get_min_interval(&arg0.allocator)
    }

    public fun get_queues<T0, T1>(arg0: &Vault<T0, T1>) : (vector<u64>, vector<u64>) {
        (*0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_strategy::borrow_supply_queue(&arg0.strategy), *0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_strategy::borrow_withdraw_queue(&arg0.strategy))
    }

    public fun get_supply_cap<T0, T1>(arg0: &Vault<T0, T1>) : u128 {
        0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_strategy::get_supply_cap(&arg0.strategy)
    }

    public fun get_total_assets<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::market::Hearn) : u128 {
        calculate_total_assets<T0, T1>(arg0, arg1)
    }

    public fun get_user_asset_value<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::market::Hearn, arg2: u128) : u128 {
        convert_to_assets_down(arg2, (arg0.total_shares as u128), calculate_total_assets<T0, T1>(arg0, arg1), arg0.asset_decimals)
    }

    public fun get_user_last_deposit<T0, T1>(arg0: &Vault<T0, T1>, arg1: address) : u64 {
        0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_strategy::get_user_last_deposit(&arg0.strategy, arg1)
    }

    public fun get_vault_config<T0, T1>(arg0: &Vault<T0, T1>) : (u128, u64, u64, u64, bool, bool) {
        (0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_strategy::get_supply_cap(&arg0.strategy), 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_fees::get_performance_fee_bps(&arg0.fees), 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_fees::get_management_fee_bps(&arg0.fees), 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_governance::get_timelock(&arg0.governance), 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_governance::is_deposit_paused(&arg0.governance), 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_governance::is_withdraw_paused(&arg0.governance))
    }

    public fun get_vault_name<T0, T1>(arg0: &Vault<T0, T1>) : 0x1::string::String {
        arg0.vault_name
    }

    public fun get_withdraw_cooldown<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_strategy::get_withdraw_cooldown(&arg0.strategy)
    }

    public(friend) fun governance<T0, T1>(arg0: &Vault<T0, T1>) : &0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_governance::Governance {
        &arg0.governance
    }

    public(friend) fun governance_and_allocator_mut<T0, T1>(arg0: &mut Vault<T0, T1>) : (&mut 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_governance::Governance, &mut 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_allocator::AllocatorState) {
        (&mut arg0.governance, &mut arg0.allocator)
    }

    public(friend) fun governance_and_fees_mut<T0, T1>(arg0: &mut Vault<T0, T1>) : (&mut 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_governance::Governance, &mut 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_fees::FeeConfig) {
        (&mut arg0.governance, &mut arg0.fees)
    }

    public(friend) fun governance_and_strategy_mut<T0, T1>(arg0: &mut Vault<T0, T1>) : (&mut 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_governance::Governance, &mut 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_strategy::Strategy) {
        (&mut arg0.governance, &mut arg0.strategy)
    }

    public(friend) fun governance_lost_reserve_mut<T0, T1>(arg0: &mut Vault<T0, T1>) : (&mut 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_governance::Governance, &mut u128, &mut 0x2::balance::Balance<T0>) {
        (&mut arg0.governance, &mut arg0.lost_assets, &mut arg0.asset_reserve)
    }

    public(friend) fun governance_mut<T0, T1>(arg0: &mut Vault<T0, T1>) : &mut 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_governance::Governance {
        &mut arg0.governance
    }

    public(friend) fun governance_strategy_lost_mut<T0, T1>(arg0: &mut Vault<T0, T1>) : (&mut 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_governance::Governance, &mut 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_strategy::Strategy, &mut u128) {
        (&mut arg0.governance, &mut arg0.strategy, &mut arg0.lost_assets)
    }

    public fun has_market<T0, T1>(arg0: &Vault<T0, T1>, arg1: u64) : bool {
        0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_strategy::has_market(&arg0.strategy, arg1)
    }

    public(friend) fun lost_assets_mut<T0, T1>(arg0: &mut Vault<T0, T1>) : &mut u128 {
        &mut arg0.lost_assets
    }

    public fun max_deposit<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::market::Hearn, arg2: address) : u128 {
        if (0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_governance::is_deposit_paused(&arg0.governance)) {
            return 0
        };
        let v0 = 0;
        let v1 = 0;
        let v2 = 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_strategy::borrow_supply_queue(&arg0.strategy);
        while (v1 < 0x1::vector::length<u64>(v2)) {
            let v3 = *0x1::vector::borrow<u64>(v2, v1);
            if (0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::market::market_is_paused(arg1, v3) || 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::market::market_is_supply_paused(arg1, v3)) {
                v1 = v1 + 1;
                continue
            };
            if (!0x2::table::contains<u64, 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_strategy::MarketAllocation>(0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_strategy::borrow_allocations(&arg0.strategy), v3)) {
                v1 = v1 + 1;
                continue
            };
            let (v4, _) = 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_strategy::get_market_allocation(&arg0.strategy, v3);
            if (v4 == 0) {
                v1 = v1 + 1;
                continue
            };
            let v6 = 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::market::user_position_supply_assets(arg1, v3, 0x2::object::uid_to_address(&arg0.id));
            if (v6 < v4) {
                v0 = v0 + v4 - v6;
            };
            v1 = v1 + 1;
        };
        if (0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_strategy::get_supply_cap(&arg0.strategy) > 0) {
            let v7 = calculate_total_assets<T0, T1>(arg0, arg1);
            if (v7 < 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_strategy::get_supply_cap(&arg0.strategy)) {
                let v8 = 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_strategy::get_supply_cap(&arg0.strategy) - v7;
                let v9 = if (v0 < v8) {
                    v0
                } else {
                    v8
                };
                v0 = v9;
            } else {
                return 0
            };
        };
        let (_, v11) = 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_strategy::get_deposit_limits(&arg0.strategy);
        if (v11 > 0 && v0 > v11) {
            v0 = v11;
        };
        v0
    }

    public fun max_mint<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::market::Hearn, arg2: address) : u128 {
        let v0 = max_deposit<T0, T1>(arg0, arg1, arg2);
        if (v0 == 0) {
            return 0
        };
        convert_to_shares_down(v0, (arg0.total_shares as u128), calculate_total_assets<T0, T1>(arg0, arg1), arg0.asset_decimals)
    }

    public fun max_redeem<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::market::Hearn, arg2: address, arg3: u128) : u128 {
        if (0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_governance::is_withdraw_paused(&arg0.governance)) {
            return 0
        };
        let v0 = (0x2::balance::value<T0>(&arg0.asset_reserve) as u128);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_strategy::borrow_withdraw_queue(&arg0.strategy))) {
            v0 = v0 + 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::market::user_withdrawable_assets(arg1, *0x1::vector::borrow<u64>(0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_strategy::borrow_withdraw_queue(&arg0.strategy), v1), 0x2::object::uid_to_address(&arg0.id));
            v1 = v1 + 1;
        };
        let v2 = calculate_total_assets<T0, T1>(arg0, arg1);
        if (v2 == 0) {
            return 0
        };
        let v3 = convert_to_shares_down(v0, (arg0.total_shares as u128), v2, arg0.asset_decimals);
        if (arg3 < v3) {
            arg3
        } else {
            v3
        }
    }

    public fun max_withdraw<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::market::Hearn, arg2: address, arg3: u128) : u128 {
        if (0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_governance::is_withdraw_paused(&arg0.governance) || 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::market::is_global_paused(arg1)) {
            return 0
        };
        let v0 = convert_to_assets_down(arg3, (arg0.total_shares as u128), calculate_total_assets<T0, T1>(arg0, arg1), arg0.asset_decimals);
        let v1 = (0x2::balance::value<T0>(&arg0.asset_reserve) as u128);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_strategy::borrow_withdraw_queue(&arg0.strategy))) {
            let v3 = *0x1::vector::borrow<u64>(0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_strategy::borrow_withdraw_queue(&arg0.strategy), v2);
            if (!0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::market::market_is_paused(arg1, v3) && !0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::market::market_is_withdraw_paused(arg1, v3)) {
                v1 = v1 + 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::market::user_withdrawable_assets(arg1, v3, 0x2::object::uid_to_address(&arg0.id));
            };
            v2 = v2 + 1;
        };
        if (v0 < v1) {
            v0
        } else {
            v1
        }
    }

    fun meta_vault_virtual_shares(arg0: u8) : u128 {
        let v0 = if (arg0 < 9) {
            9 - arg0
        } else {
            0
        };
        power_of_10(v0)
    }

    fun power_of_10(arg0: u8) : u128 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    public fun preview_deposit<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::market::Hearn, arg2: u128) : u128 {
        convert_to_shares_down(arg2, (arg0.total_shares as u128), calculate_total_assets<T0, T1>(arg0, arg1), arg0.asset_decimals)
    }

    public fun preview_redeem<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::market::Hearn, arg2: u128) : u128 {
        convert_to_assets_down(arg2, (arg0.total_shares as u128), calculate_total_assets<T0, T1>(arg0, arg1), arg0.asset_decimals)
    }

    public fun preview_withdraw<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::market::Hearn, arg2: u128) : u128 {
        convert_to_shares_up(arg2, (arg0.total_shares as u128), calculate_total_assets<T0, T1>(arg0, arg1), arg0.asset_decimals)
    }

    public(friend) fun rebalance<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::market::Hearn, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_governance::ensure_allocator(&arg0.governance, 0x2::tx_context::sender(arg3));
        accrue_fees_internal<T0, T1>(arg0, arg1, arg2, arg3);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_allocator::assert_rebalance_interval(&arg0.allocator, v0 / 1000);
        let v1 = calculate_total_assets<T0, T1>(arg0, arg1);
        if (v1 == 0) {
            return
        };
        let v2 = 0x2::object::uid_to_address(&arg0.id);
        let v3 = 0;
        let v4 = 0;
        let v5 = 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_strategy::borrow_supply_queue(&arg0.strategy);
        let v6 = 0x1::vector::length<u64>(v5);
        while (v4 < v6) {
            let v7 = *0x1::vector::borrow<u64>(v5, v4);
            if (0x2::table::contains<u64, 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_strategy::MarketAllocation>(0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_strategy::borrow_allocations(&arg0.strategy), v7)) {
                let (_, v9) = 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_strategy::get_market_allocation(&arg0.strategy, v7);
                v3 = v3 + v9;
            };
            v4 = v4 + 1;
        };
        if (v3 == 0) {
            return
        };
        assert!(v3 <= 10000, 27);
        let v10 = 0;
        let v11 = 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_strategy::borrow_withdraw_queue(&arg0.strategy);
        while (v10 < 0x1::vector::length<u64>(v11)) {
            let v12 = *0x1::vector::borrow<u64>(v11, v10);
            if (0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::market::market_is_paused(arg1, v12) || 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::market::market_is_withdraw_paused(arg1, v12)) {
                v10 = v10 + 1;
                continue
            };
            if (0x2::table::contains<u64, 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_strategy::MarketAllocation>(0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_strategy::borrow_allocations(&arg0.strategy), v12)) {
                let (v13, v14) = 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_strategy::get_market_allocation(&arg0.strategy, v12);
                let v15 = 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::math::mul_div_down(v1, (v14 as u128), (10000 as u128));
                let v16 = if (v13 > 0 && v15 > v13) {
                    v13
                } else {
                    v15
                };
                let v17 = 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::market::user_position_supply_assets(arg1, v12, v2);
                if (v17 > v16) {
                    let v18 = v17 - v16;
                    let v19 = if (v16 > 0) {
                        0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::math::mul_div_down(v18, (10000 as u128), v16)
                    } else {
                        (10000 as u128)
                    };
                    if ((v19 as u64) >= 500) {
                        let (v20, _, _) = 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::market::withdraw<T0>(arg1, v12, v2, v2, v18, 0, arg2, 0x1::option::some<address>(v2), arg3);
                        0x2::balance::join<T0>(&mut arg0.asset_reserve, 0x2::coin::into_balance<T0>(v20));
                    };
                };
            };
            v10 = v10 + 1;
        };
        let v23 = 0;
        while (v23 < v6) {
            let v24 = *0x1::vector::borrow<u64>(v5, v23);
            if (0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::market::market_is_paused(arg1, v24) || 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::market::market_is_supply_paused(arg1, v24)) {
                v23 = v23 + 1;
                continue
            };
            if (0x2::table::contains<u64, 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_strategy::MarketAllocation>(0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_strategy::borrow_allocations(&arg0.strategy), v24)) {
                let (v25, v26) = 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_strategy::get_market_allocation(&arg0.strategy, v24);
                let v27 = 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::math::mul_div_down(calculate_total_assets<T0, T1>(arg0, arg1), (v26 as u128), (10000 as u128));
                let v28 = if (v25 > 0 && v27 > v25) {
                    v25
                } else {
                    v27
                };
                let v29 = 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::market::user_position_supply_assets(arg1, v24, v2);
                if (v29 < v28) {
                    let v30 = v28 - v29;
                    let v31 = if (v28 > 0) {
                        0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::math::mul_div_down(v30, (10000 as u128), v28)
                    } else {
                        0
                    };
                    if ((v31 as u64) >= 500) {
                        let v32 = (0x2::balance::value<T0>(&arg0.asset_reserve) as u128);
                        let v33 = if (v30 > v32) {
                            v32
                        } else {
                            v30
                        };
                        if (v33 > 0) {
                            let (_, _, v36) = 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::market::supply<T0>(arg1, v24, v2, v33, 0, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.asset_reserve, 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::math::to_u64(v33)), arg3), arg2, arg3);
                            let v37 = v36;
                            if (0x2::coin::value<T0>(&v37) > 0) {
                                0x2::balance::join<T0>(&mut arg0.asset_reserve, 0x2::coin::into_balance<T0>(v37));
                            } else {
                                0x2::coin::destroy_zero<T0>(v37);
                            };
                        };
                    };
                };
            };
            v23 = v23 + 1;
        };
        let v38 = calculate_total_assets<T0, T1>(arg0, arg1);
        0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_fees::update_last_total_assets(&mut arg0.fees, v38);
        let v39 = 0x2::object::uid_to_address(&arg0.id);
        0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_allocator::update_last_rebalance(&mut arg0.allocator, v0 / 1000, v39, arg3);
        0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_events::emit_rebalance(v39, v1, v38, 0x1::type_name::with_defining_ids<T0>(), 0x1::type_name::with_defining_ids<T1>(), arg3);
    }

    public(friend) fun set_vault_name<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x1::string::String, arg2: &0x2::tx_context::TxContext) {
        0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_governance::ensure_curator(&arg0.governance, 0x2::tx_context::sender(arg2));
        arg0.vault_name = arg1;
        0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_events::emit_set_vault_name(0x2::object::uid_to_address(&arg0.id), arg0.vault_name, arg1, 0x1::type_name::with_defining_ids<T0>(), 0x1::type_name::with_defining_ids<T1>(), arg2);
    }

    public(friend) fun strategy_mut<T0, T1>(arg0: &mut Vault<T0, T1>) : &mut 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_strategy::Strategy {
        &mut arg0.strategy
    }

    fun supply_to_markets<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::market::Hearn, arg2: address, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_strategy::borrow_supply_queue(&arg0.strategy);
        let v2 = 0x1::vector::length<u64>(v1);
        if (arg3 > 0) {
            assert!(v2 > 0, 5);
        };
        while (arg3 > 0 && v0 < v2) {
            let v3 = *0x1::vector::borrow<u64>(v1, v0);
            if (0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::market::market_is_paused(arg1, v3) || 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::market::market_is_supply_paused(arg1, v3)) {
                v0 = v0 + 1;
                continue
            };
            let v4 = 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::market::user_position_supply_assets(arg1, v3, arg2);
            let v5 = if (0x2::table::contains<u64, 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_strategy::MarketAllocation>(0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_strategy::borrow_allocations(&arg0.strategy), v3)) {
                let (v6, _) = 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_strategy::get_market_allocation(&arg0.strategy, v3);
                v6
            } else {
                0
            };
            if (v5 > 0 && v4 < v5) {
                let v8 = v5 - v4;
                let v9 = if (arg3 < v8) {
                    arg3
                } else {
                    v8
                };
                let (v10, _, v12) = 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::market::supply<T0>(arg1, v3, arg2, v9, 0, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.asset_reserve, 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::math::to_u64(v9)), arg5), arg4, arg5);
                let v13 = v12;
                if (0x2::coin::value<T0>(&v13) > 0) {
                    0x2::balance::join<T0>(&mut arg0.asset_reserve, 0x2::coin::into_balance<T0>(v13));
                } else {
                    0x2::coin::destroy_zero<T0>(v13);
                };
                arg3 = arg3 - v10;
            };
            v0 = v0 + 1;
        };
        assert!(arg3 == 0, 5);
    }

    public(friend) fun vault_id<T0, T1>(arg0: &Vault<T0, T1>) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun vault_total_shares<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.total_shares
    }

    fun withdraw_assets_internal<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::market::Hearn, arg2: u128, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        accrue_fees_internal<T0, T1>(arg0, arg1, arg4, arg5);
        arg0.total_shares = arg0.total_shares - (arg3 as u64);
        let v0 = 0x2::object::uid_to_address(&arg0.id);
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = withdraw_from_markets<T0, T1>(arg0, arg1, v0, arg2, arg4, arg5);
        0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_fees::update_last_total_assets(&mut arg0.fees, calculate_total_assets<T0, T1>(arg0, arg1));
        0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::meta_vault_events::emit_vault_withdraw(v0, v1, arg2, arg3, 0x1::type_name::with_defining_ids<T0>(), 0x1::type_name::with_defining_ids<T1>(), arg5);
        v2
    }

    fun withdraw_from_markets<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::market::Hearn, arg2: address, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::balance::zero<T0>();
        let v1 = 0;
        let v2 = collect_ordered_markets(&arg0.strategy);
        while (arg3 > 0 && v1 < 0x1::vector::length<u64>(&v2)) {
            let v3 = *0x1::vector::borrow<u64>(&v2, v1);
            if (0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::market::market_is_paused(arg1, v3) || 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::market::market_is_withdraw_paused(arg1, v3)) {
                v1 = v1 + 1;
                continue
            };
            let v4 = 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::market::user_withdrawable_assets(arg1, v3, arg2);
            if (v4 > 0) {
                let v5 = if (arg3 < v4) {
                    arg3
                } else {
                    v4
                };
                let (v6, v7, _) = 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::market::withdraw<T0>(arg1, v3, arg2, arg2, v5, 0, arg4, 0x1::option::some<address>(arg2), arg5);
                0x2::balance::join<T0>(&mut v0, 0x2::coin::into_balance<T0>(v6));
                arg3 = arg3 - v7;
            };
            v1 = v1 + 1;
        };
        if (arg3 > 0) {
            if ((0x2::balance::value<T0>(&arg0.asset_reserve) as u128) >= arg3) {
                0x2::balance::join<T0>(&mut v0, 0x2::balance::split<T0>(&mut arg0.asset_reserve, 0x8e705be3061f82161293ac93c61a620e17b5a07739d83ab19e9bf0153669f7d6::math::to_u64(arg3)));
                arg3 = 0;
            };
        };
        assert!(arg3 == 0, 6);
        0x2::coin::from_balance<T0>(v0, arg5)
    }

    // decompiled from Move bytecode v6
}

