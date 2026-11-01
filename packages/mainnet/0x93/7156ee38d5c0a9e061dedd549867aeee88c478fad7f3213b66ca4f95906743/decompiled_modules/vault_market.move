module 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market {
    struct ColCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct DebtCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct VaultMarket<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        vault_id: u64,
        risk: 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::risk_config::RiskConfig,
        supply_rate_magnifier: 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::structs::RateMagnifier,
        borrow_rate_magnifier: 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::structs::RateMagnifier,
        vault_type: u8,
        oracle: 0x2::object::ID,
        liquidity_program: 0x2::object::ID,
        col_decimals: u8,
        debt_decimals: u8,
        branch_liquidated: bool,
        topmost_tick: 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::Tick,
        current_branch_id: u64,
        total_branch_id: u64,
        total_supply: u64,
        total_borrow: u64,
        absorbed_debt_amount: u128,
        absorbed_col_amount: u128,
        absorbed_dust_debt: u64,
        liquidity_supply_exchange_price: u64,
        liquidity_borrow_exchange_price: u64,
        vault_supply_exchange_price: u64,
        vault_borrow_exchange_price: u64,
        last_update_timestamp: 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::units::TimestampS,
        ticks: 0x2::table::Table<0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::Tick, 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::tick::Tick>,
        branches: 0x2::table::Table<u64, 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::branch::Branch>,
        liq_snaps: 0x2::table::Table<0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::tick::TickIdLiquidationKey, 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::tick::TickIdLiquidation>,
        tick_bitmap: 0x2::table::Table<u16, u256>,
    }

    public fun load_exchange_prices<T0, T1>(arg0: &VaultMarket<T0, T1>, arg1: u128, arg2: u128, arg3: 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::units::TimestampS) : (u128, u128, u128, u128) {
        let (v0, v1) = 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::exchange_price::load_exchange_prices((arg0.vault_supply_exchange_price as u128), (arg0.vault_borrow_exchange_price as u128), (arg0.liquidity_supply_exchange_price as u128), (arg0.liquidity_borrow_exchange_price as u128), arg1, arg2, ((0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::units::raw_ts(arg3) - 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::units::raw_ts(arg0.last_update_timestamp)) as u128), arg0.supply_rate_magnifier, arg0.borrow_rate_magnifier);
        (arg1, arg2, v0, v1)
    }

    public(friend) fun uid_mut<T0, T1>(arg0: &mut VaultMarket<T0, T1>) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun risk_config<T0, T1>(arg0: &VaultMarket<T0, T1>) : 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::risk_config::RiskConfig {
        arg0.risk
    }

    public fun borrow_fee<T0, T1>(arg0: &VaultMarket<T0, T1>) : u8 {
        0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::risk_config::borrow_fee(&arg0.risk)
    }

    public fun collateral_factor<T0, T1>(arg0: &VaultMarket<T0, T1>) : u16 {
        0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::risk_config::collateral_factor(&arg0.risk)
    }

    public fun liquidation_max_limit<T0, T1>(arg0: &VaultMarket<T0, T1>) : u16 {
        0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::risk_config::liquidation_max_limit(&arg0.risk)
    }

    public fun liquidation_penalty<T0, T1>(arg0: &VaultMarket<T0, T1>) : u16 {
        0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::risk_config::liquidation_penalty(&arg0.risk)
    }

    public fun liquidation_threshold<T0, T1>(arg0: &VaultMarket<T0, T1>) : u16 {
        0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::risk_config::liquidation_threshold(&arg0.risk)
    }

    public fun withdraw_gap<T0, T1>(arg0: &VaultMarket<T0, T1>) : u16 {
        0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::risk_config::withdraw_gap(&arg0.risk)
    }

    public fun absorbed_col_amount<T0, T1>(arg0: &VaultMarket<T0, T1>) : u128 {
        arg0.absorbed_col_amount
    }

    public fun absorbed_debt_amount<T0, T1>(arg0: &VaultMarket<T0, T1>) : u128 {
        arg0.absorbed_debt_amount
    }

    public fun absorbed_dust_debt<T0, T1>(arg0: &VaultMarket<T0, T1>) : u64 {
        arg0.absorbed_dust_debt
    }

    public(friend) fun add_absorbed_col_amount<T0, T1>(arg0: &mut VaultMarket<T0, T1>, arg1: u128) {
        arg0.absorbed_col_amount = arg0.absorbed_col_amount + arg1;
    }

    public(friend) fun add_absorbed_debt_amount<T0, T1>(arg0: &mut VaultMarket<T0, T1>, arg1: u128) {
        arg0.absorbed_debt_amount = arg0.absorbed_debt_amount + arg1;
    }

    public(friend) fun add_caps<T0, T1>(arg0: &mut VaultMarket<T0, T1>, arg1: 0x1::option::Option<0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::user_cap::UserCap<T0>>, arg2: 0x1::option::Option<0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::user_cap::UserCap<T1>>) {
        assert!(0x1::option::is_some<0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::user_cap::UserCap<T0>>(&arg1) || 0x1::option::is_some<0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::user_cap::UserCap<T1>>(&arg2), 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::errors::vault_no_caps_supplied());
        let v0 = 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::keys::holder_object(0x2::object::uid_to_inner(&arg0.id));
        if (0x1::option::is_some<0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::user_cap::UserCap<T0>>(&arg1)) {
            let v1 = 0x1::option::destroy_some<0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::user_cap::UserCap<T0>>(arg1);
            assert!(0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::user_cap::get_user_cap_holder<T0>(&v1) == v0, 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::errors::vault_cap_holder_mismatch());
            let v2 = ColCapKey{dummy_field: false};
            0x2::dynamic_field::add<ColCapKey, 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::user_cap::UserCap<T0>>(&mut arg0.id, v2, v1);
        } else {
            0x1::option::destroy_none<0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::user_cap::UserCap<T0>>(arg1);
        };
        if (0x1::option::is_some<0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::user_cap::UserCap<T1>>(&arg2)) {
            let v3 = 0x1::option::destroy_some<0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::user_cap::UserCap<T1>>(arg2);
            assert!(0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::user_cap::get_user_cap_holder<T1>(&v3) == v0, 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::errors::vault_cap_holder_mismatch());
            let v4 = DebtCapKey{dummy_field: false};
            0x2::dynamic_field::add<DebtCapKey, 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::user_cap::UserCap<T1>>(&mut arg0.id, v4, v3);
        } else {
            0x1::option::destroy_none<0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::user_cap::UserCap<T1>>(arg2);
        };
    }

    public(friend) fun assert_caps_installed<T0, T1>(arg0: &VaultMarket<T0, T1>) {
        assert!(caps_installed<T0, T1>(arg0), 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::errors::vault_caps_not_installed());
    }

    public(friend) fun assert_magnifier(arg0: &0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::structs::RateMagnifier) {
        let v0 = if (0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::structs::magnifier_is_negative(arg0)) {
            0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::constants::max_negative_magnifier()
        } else {
            0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::constants::four_decimals()
        };
        assert!((0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::structs::magnifier_magnitude(arg0) as u128) <= v0, 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::errors::vault_admin_value_above_limit());
    }

    public(friend) fun borrow_col_cap<T0, T1>(arg0: &VaultMarket<T0, T1>) : &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::user_cap::UserCap<T0> {
        let v0 = ColCapKey{dummy_field: false};
        0x2::dynamic_field::borrow<ColCapKey, 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::user_cap::UserCap<T0>>(&arg0.id, v0)
    }

    public(friend) fun borrow_debt_cap<T0, T1>(arg0: &VaultMarket<T0, T1>) : &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::user_cap::UserCap<T1> {
        let v0 = DebtCapKey{dummy_field: false};
        0x2::dynamic_field::borrow<DebtCapKey, 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::user_cap::UserCap<T1>>(&arg0.id, v0)
    }

    public fun borrow_rate_magnifier<T0, T1>(arg0: &VaultMarket<T0, T1>) : 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::structs::RateMagnifier {
        arg0.borrow_rate_magnifier
    }

    public fun branches<T0, T1>(arg0: &VaultMarket<T0, T1>) : &0x2::table::Table<u64, 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::branch::Branch> {
        &arg0.branches
    }

    public(friend) fun branches_mut<T0, T1>(arg0: &mut VaultMarket<T0, T1>) : &mut 0x2::table::Table<u64, 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::branch::Branch> {
        &mut arg0.branches
    }

    public fun caps_installed<T0, T1>(arg0: &VaultMarket<T0, T1>) : bool {
        let v0 = ColCapKey{dummy_field: false};
        if (0x2::dynamic_field::exists_with_type<ColCapKey, 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::user_cap::UserCap<T0>>(&arg0.id, v0)) {
            let v2 = DebtCapKey{dummy_field: false};
            0x2::dynamic_field::exists_with_type<DebtCapKey, 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::user_cap::UserCap<T1>>(&arg0.id, v2)
        } else {
            false
        }
    }

    public fun col_decimals<T0, T1>(arg0: &VaultMarket<T0, T1>) : u8 {
        arg0.col_decimals
    }

    public(friend) fun create<T0, T1>(arg0: &mut 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::registry::VaultRegistry, arg1: 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::risk_config::RiskConfig, arg2: 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::structs::RateMagnifier, arg3: 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::structs::RateMagnifier, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: u8, arg7: u8, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : VaultMarket<T0, T1> {
        let v0 = if (arg6 >= 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::constants::min_token_decimals()) {
            if (arg6 <= 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::constants::max_token_decimals()) {
                if (arg7 >= 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::constants::min_token_decimals()) {
                    arg7 <= 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::constants::max_token_decimals()
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::errors::vault_invalid_decimals());
        assert!(0x1::type_name::with_defining_ids<T0>() != 0x1::type_name::with_defining_ids<T1>(), 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::errors::vault_same_col_debt_type());
        assert_magnifier(&arg2);
        assert_magnifier(&arg3);
        let v1 = 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::registry::allocate_vault_id(arg0);
        let v2 = VaultMarket<T0, T1>{
            id                              : 0x2::derived_object::claim<0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::keys::VaultKey>(0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::registry::uid_mut(arg0), 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::keys::vault_key(v1)),
            vault_id                        : v1,
            risk                            : arg1,
            supply_rate_magnifier           : arg2,
            borrow_rate_magnifier           : arg3,
            vault_type                      : 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::constants::vault_t1_type(),
            oracle                          : arg4,
            liquidity_program               : arg5,
            col_decimals                    : arg6,
            debt_decimals                   : arg7,
            branch_liquidated               : false,
            topmost_tick                    : 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::cold_tick(),
            current_branch_id               : 1,
            total_branch_id                 : 1,
            total_supply                    : 0,
            total_borrow                    : 0,
            absorbed_debt_amount            : 0,
            absorbed_col_amount             : 0,
            absorbed_dust_debt              : 0,
            liquidity_supply_exchange_price : 0,
            liquidity_borrow_exchange_price : 0,
            vault_supply_exchange_price     : 0,
            vault_borrow_exchange_price     : 0,
            last_update_timestamp           : 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::units::from_clock(arg8),
            ticks                           : 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::tick::new_ticks(arg9),
            branches                        : 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::branch::new_branches(arg9),
            liq_snaps                       : 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::tick::new_snaps(arg9),
            tick_bitmap                     : 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::tick::new_bitmap(arg9),
        };
        0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::branch::ensure_branch(&mut v2.branches, 1);
        v2
    }

    public fun current_branch_id<T0, T1>(arg0: &VaultMarket<T0, T1>) : u64 {
        arg0.current_branch_id
    }

    public fun debt_decimals<T0, T1>(arg0: &VaultMarket<T0, T1>) : u8 {
        arg0.debt_decimals
    }

    public(friend) fun engine_mut<T0, T1>(arg0: &mut VaultMarket<T0, T1>) : (&mut 0x2::table::Table<0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::Tick, 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::tick::Tick>, &mut 0x2::table::Table<u64, 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::branch::Branch>, &mut 0x2::table::Table<0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::tick::TickIdLiquidationKey, 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::tick::TickIdLiquidation>, &mut 0x2::table::Table<u16, u256>) {
        (&mut arg0.ticks, &mut arg0.branches, &mut arg0.liq_snaps, &mut arg0.tick_bitmap)
    }

    public fun exchange_prices<T0, T1>(arg0: &VaultMarket<T0, T1>) : (u128, u128, u128, u128) {
        ((arg0.liquidity_supply_exchange_price as u128), (arg0.liquidity_borrow_exchange_price as u128), (arg0.vault_supply_exchange_price as u128), (arg0.vault_borrow_exchange_price as u128))
    }

    public fun get_tick_status<T0, T1>(arg0: &VaultMarket<T0, T1>) : 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::tick::TickStatus {
        if (is_branch_liquidated<T0, T1>(arg0)) {
            0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::tick::tick_status_liquidated()
        } else {
            0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::tick::tick_status_perfect()
        }
    }

    public fun get_top_tick<T0, T1>(arg0: &VaultMarket<T0, T1>) : 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::Tick {
        arg0.topmost_tick
    }

    public fun get_total_borrow<T0, T1>(arg0: &VaultMarket<T0, T1>) : u128 {
        (arg0.total_borrow as u128)
    }

    public fun get_total_supply<T0, T1>(arg0: &VaultMarket<T0, T1>) : u128 {
        (arg0.total_supply as u128)
    }

    public(friend) fun init_vault_state<T0, T1>(arg0: &mut VaultMarket<T0, T1>, arg1: u128, arg2: u128, arg3: 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::units::TimestampS) {
        assert!(arg0.vault_supply_exchange_price == 0, 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::errors::vault_state_already_initialized());
        let v0 = 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::constants::exchange_prices_precision();
        assert!(arg1 >= v0 && arg2 >= v0, 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::errors::vault_token_not_initialized());
        arg0.liquidity_supply_exchange_price = (arg1 as u64);
        arg0.liquidity_borrow_exchange_price = (arg2 as u64);
        arg0.vault_supply_exchange_price = (v0 as u64);
        arg0.vault_borrow_exchange_price = (v0 as u64);
        arg0.last_update_timestamp = arg3;
    }

    public fun is_branch_liquidated<T0, T1>(arg0: &VaultMarket<T0, T1>) : bool {
        arg0.branch_liquidated
    }

    public fun last_update_timestamp<T0, T1>(arg0: &VaultMarket<T0, T1>) : 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::units::TimestampS {
        arg0.last_update_timestamp
    }

    public fun liq_snaps<T0, T1>(arg0: &VaultMarket<T0, T1>) : &0x2::table::Table<0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::tick::TickIdLiquidationKey, 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::tick::TickIdLiquidation> {
        &arg0.liq_snaps
    }

    public(friend) fun liq_snaps_mut<T0, T1>(arg0: &mut VaultMarket<T0, T1>) : &mut 0x2::table::Table<0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::tick::TickIdLiquidationKey, 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::tick::TickIdLiquidation> {
        &mut arg0.liq_snaps
    }

    public fun liquidity_program<T0, T1>(arg0: &VaultMarket<T0, T1>) : 0x2::object::ID {
        arg0.liquidity_program
    }

    public fun oracle<T0, T1>(arg0: &VaultMarket<T0, T1>) : 0x2::object::ID {
        arg0.oracle
    }

    public(friend) fun reduce_total_borrow<T0, T1>(arg0: &mut VaultMarket<T0, T1>, arg1: u128) {
        let v0 = get_total_borrow<T0, T1>(arg0) - arg1;
        set_total_borrow<T0, T1>(arg0, v0);
    }

    public(friend) fun reduce_total_supply<T0, T1>(arg0: &mut VaultMarket<T0, T1>, arg1: u128) {
        let v0 = get_total_supply<T0, T1>(arg0) - arg1;
        set_total_supply<T0, T1>(arg0, v0);
    }

    public(friend) fun reset_absorbed_amounts<T0, T1>(arg0: &mut VaultMarket<T0, T1>) {
        arg0.absorbed_debt_amount = 0;
        arg0.absorbed_col_amount = 0;
    }

    public(friend) fun reset_branch_liquidated<T0, T1>(arg0: &mut VaultMarket<T0, T1>) {
        arg0.branch_liquidated = false;
    }

    public(friend) fun reset_top_tick<T0, T1>(arg0: &mut VaultMarket<T0, T1>) {
        arg0.topmost_tick = 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::cold_tick();
    }

    public(friend) fun set_absorbed_amounts<T0, T1>(arg0: &mut VaultMarket<T0, T1>, arg1: u128, arg2: u128) {
        arg0.absorbed_debt_amount = arg1;
        arg0.absorbed_col_amount = arg2;
    }

    public(friend) fun set_borrow_rate_magnifier<T0, T1>(arg0: &mut VaultMarket<T0, T1>, arg1: 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::structs::RateMagnifier) {
        assert_magnifier(&arg1);
        arg0.borrow_rate_magnifier = arg1;
    }

    public(friend) fun set_branch_liquidated<T0, T1>(arg0: &mut VaultMarket<T0, T1>) {
        arg0.branch_liquidated = true;
    }

    public(friend) fun set_current_branch_id<T0, T1>(arg0: &mut VaultMarket<T0, T1>, arg1: u64) {
        arg0.current_branch_id = arg1;
    }

    public(friend) fun set_oracle<T0, T1>(arg0: &mut VaultMarket<T0, T1>, arg1: 0x2::object::ID) {
        arg0.oracle = arg1;
    }

    public(friend) fun set_risk_config<T0, T1>(arg0: &mut VaultMarket<T0, T1>, arg1: 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::risk_config::RiskConfig) {
        arg0.risk = arg1;
    }

    public(friend) fun set_supply_rate_magnifier<T0, T1>(arg0: &mut VaultMarket<T0, T1>, arg1: 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::structs::RateMagnifier) {
        assert_magnifier(&arg1);
        arg0.supply_rate_magnifier = arg1;
    }

    public(friend) fun set_top_tick<T0, T1>(arg0: &mut VaultMarket<T0, T1>) : 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::Tick {
        let v0 = arg0.current_branch_id;
        let v1 = 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::branch::connected_minima_tick(0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::branch::load_branch(&arg0.branches, v0));
        let v2 = 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::tick::fetch_next_top_tick(&mut arg0.tick_bitmap, get_top_tick<T0, T1>(arg0));
        let v3 = if (0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::gt(v1, v2)) {
            v1
        } else {
            v2
        };
        if (v3 == 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::cold_tick()) {
            reset_top_tick<T0, T1>(arg0);
            reset_branch_liquidated<T0, T1>(arg0);
        } else if (v3 == v2) {
            arg0.topmost_tick = v3;
            reset_branch_liquidated<T0, T1>(arg0);
        } else {
            set_branch_liquidated<T0, T1>(arg0);
            let v4 = 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::branch::load_branch_mut(&mut arg0.branches, v0);
            0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::branch::reset_branch_data(v4);
            arg0.topmost_tick = 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::branch::connected_minima_tick(v4);
            arg0.current_branch_id = 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::branch::connected_branch_id(v4);
            arg0.total_branch_id = v0 - 1;
        };
        v3
    }

    public(friend) fun set_topmost_tick<T0, T1>(arg0: &mut VaultMarket<T0, T1>, arg1: 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::Tick) {
        arg0.topmost_tick = arg1;
    }

    public(friend) fun set_total_borrow<T0, T1>(arg0: &mut VaultMarket<T0, T1>, arg1: u128) {
        assert!(arg1 <= 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::constants::max_u64(), 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::errors::overflow());
        arg0.total_borrow = (arg1 as u64);
    }

    public(friend) fun set_total_branch_id<T0, T1>(arg0: &mut VaultMarket<T0, T1>, arg1: u64) {
        arg0.total_branch_id = arg1;
    }

    public(friend) fun set_total_supply<T0, T1>(arg0: &mut VaultMarket<T0, T1>, arg1: u128) {
        assert!(arg1 <= 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::constants::max_u64(), 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::errors::overflow());
        arg0.total_supply = (arg1 as u64);
    }

    public(friend) fun share<T0, T1>(arg0: VaultMarket<T0, T1>) {
        0x2::transfer::share_object<VaultMarket<T0, T1>>(arg0);
    }

    public fun supply_rate_magnifier<T0, T1>(arg0: &VaultMarket<T0, T1>) : 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::structs::RateMagnifier {
        arg0.supply_rate_magnifier
    }

    public fun tick_bitmap<T0, T1>(arg0: &VaultMarket<T0, T1>) : &0x2::table::Table<u16, u256> {
        &arg0.tick_bitmap
    }

    public(friend) fun tick_bitmap_mut<T0, T1>(arg0: &mut VaultMarket<T0, T1>) : &mut 0x2::table::Table<u16, u256> {
        &mut arg0.tick_bitmap
    }

    public fun ticks<T0, T1>(arg0: &VaultMarket<T0, T1>) : &0x2::table::Table<0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::Tick, 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::tick::Tick> {
        &arg0.ticks
    }

    public(friend) fun ticks_mut<T0, T1>(arg0: &mut VaultMarket<T0, T1>) : &mut 0x2::table::Table<0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::Tick, 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::tick::Tick> {
        &mut arg0.ticks
    }

    public fun topmost_tick<T0, T1>(arg0: &VaultMarket<T0, T1>) : 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::Tick {
        arg0.topmost_tick
    }

    public fun total_branch_id<T0, T1>(arg0: &VaultMarket<T0, T1>) : u64 {
        arg0.total_branch_id
    }

    public(friend) fun update_absorbed_dust_debt_amount<T0, T1>(arg0: &mut VaultMarket<T0, T1>, arg1: u64) {
        arg0.absorbed_dust_debt = arg0.absorbed_dust_debt + arg1;
    }

    public(friend) fun update_branch_info_by_one<T0, T1>(arg0: &mut VaultMarket<T0, T1>) {
        arg0.total_branch_id = arg0.total_branch_id + 1;
        reset_branch_liquidated<T0, T1>(arg0);
        arg0.current_branch_id = arg0.total_branch_id;
    }

    public(friend) fun update_exchange_prices<T0, T1>(arg0: &mut VaultMarket<T0, T1>, arg1: u128, arg2: u128, arg3: 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::units::TimestampS) {
        let (v0, v1, v2, v3) = load_exchange_prices<T0, T1>(arg0, arg1, arg2, arg3);
        arg0.liquidity_supply_exchange_price = (v0 as u64);
        arg0.liquidity_borrow_exchange_price = (v1 as u64);
        arg0.vault_supply_exchange_price = (v2 as u64);
        arg0.vault_borrow_exchange_price = (v3 as u64);
        arg0.last_update_timestamp = arg3;
        0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::events::emit_log_update_exchange_prices(arg0.vault_id, v2, v3, v0, v1);
    }

    public(friend) fun update_state_at_liq_end<T0, T1>(arg0: &mut VaultMarket<T0, T1>, arg1: 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::Tick, arg2: u64) {
        set_branch_liquidated<T0, T1>(arg0);
        arg0.topmost_tick = arg1;
        arg0.current_branch_id = arg2;
    }

    public(friend) fun update_topmost_tick<T0, T1>(arg0: &mut VaultMarket<T0, T1>, arg1: 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::tick_math::Tick) {
        if (is_branch_liquidated<T0, T1>(arg0)) {
            let v0 = arg0.total_branch_id + 1;
            0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::branch::ensure_branch(&mut arg0.branches, v0);
            0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::branch::set_new_branch_state(0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::branch::load_branch_mut(&mut arg0.branches, v0), arg0.current_branch_id, arg0.topmost_tick);
            update_branch_info_by_one<T0, T1>(arg0);
        };
        arg0.topmost_tick = arg1;
    }

    public(friend) fun update_total_borrow<T0, T1>(arg0: &mut VaultMarket<T0, T1>, arg1: u128, arg2: u128) {
        let v0 = get_total_borrow<T0, T1>(arg0) + arg1 - arg2;
        set_total_borrow<T0, T1>(arg0, v0);
    }

    public(friend) fun update_total_supply<T0, T1>(arg0: &mut VaultMarket<T0, T1>, arg1: u128, arg2: u128) {
        let v0 = get_total_supply<T0, T1>(arg0) + arg1 - arg2;
        set_total_supply<T0, T1>(arg0, v0);
    }

    public fun vault_id<T0, T1>(arg0: &VaultMarket<T0, T1>) : u64 {
        arg0.vault_id
    }

    public fun vault_object_id<T0, T1>(arg0: &VaultMarket<T0, T1>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun vault_type<T0, T1>(arg0: &VaultMarket<T0, T1>) : u8 {
        arg0.vault_type
    }

    // decompiled from Move bytecode v7
}

