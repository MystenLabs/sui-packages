module 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::market {
    struct MARKET has drop {
        dummy_field: bool,
    }

    struct MarketParams has copy, drop, store {
        loan_token_type: 0x1::type_name::TypeName,
        collateral_token_type: 0x1::type_name::TypeName,
        oracle_id: u64,
        lltv: u64,
        ltv: u64,
        liquidation_bonus: u64,
        recall_ltv: u64,
        llv_pool_id: 0x1::option::Option<0x2::object::ID>,
        has_clm_cap: bool,
    }

    struct CLMCap has drop, store {
        market_id: u64,
    }

    struct Market has store {
        config: MarketParams,
        last_update: u64,
        total_supply_assets: u128,
        total_supply_shares: u128,
        total_borrow_assets: u128,
        total_borrow_shares: u128,
        total_collateral_assets: u128,
        fee: u128,
        flashloan_fee: u128,
        reserves: 0x2::object_bag::ObjectBag,
        is_paused: bool,
        is_supply_pause: bool,
        is_withdraw_pause: bool,
        is_supply_collateral_pause: bool,
        is_withdraw_collateral_pause: bool,
        is_borrow_pause: bool,
        is_repay_pause: bool,
        title: vector<u8>,
        open_position_count: u64,
        base_token_decimals: u64,
        quote_token_decimals: u64,
    }

    struct PositionKey has copy, drop, store {
        market_id: u64,
        owner: address,
    }

    struct Position has store {
        supply_shares: u128,
        borrow_shares: u128,
        collateral: u128,
        llv_shares: u128,
    }

    struct Authorization has copy, drop, store {
        owner: address,
        operator: address,
    }

    struct FlashLoanReceipt<phantom T0> {
        market_id: u64,
        amount: u128,
        token_slot: u64,
    }

    struct UserPositionInfo has copy, drop {
        market_id: u64,
        collateral: u128,
        borrow_shares: u128,
        borrow_assets: u128,
        supply_shares: u128,
        supply_assets: u128,
        health_factor: u128,
        withdrawable_assets: u128,
        max_borrowable: u128,
        max_withdrawable_collateral: u128,
    }

    struct MarketInfo has copy, drop {
        market_id: u64,
        supply_coin_type: 0x1::type_name::TypeName,
        collateral_coin_type: 0x1::type_name::TypeName,
        ltv: u64,
        lltv: u64,
        liquidation_threshold: u64,
        total_supply_assets: u128,
        total_borrow_assets: u128,
        total_collateral_assets: u128,
        fee: u128,
        flashloan_fee: u128,
        supply_rate: u128,
        borrow_rate: u128,
        utilization_rate: u128,
        market_paused: bool,
        global_paused: bool,
        is_supply_pause: bool,
        is_withdraw_pause: bool,
        is_supply_collateral_pause: bool,
        is_withdraw_collateral_pause: bool,
        is_borrow_pause: bool,
        is_repay_pause: bool,
        title: vector<u8>,
    }

    struct Hearn has key {
        id: 0x2::object::UID,
        version: u64,
        owner: address,
        fee_recipient: address,
        markets: 0x2::table::Table<u64, Market>,
        positions: 0x2::table::Table<PositionKey, Position>,
        position_counts: 0x2::table::Table<address, u64>,
        authorizations: 0x2::table::Table<Authorization, bool>,
        enabled_lltvs: 0x2::table::Table<u64, bool>,
        next_market_id: u64,
        irm: 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::adaptive_curve_irm::AdaptiveCurveIrm,
        is_paused: bool,
        user_market_ids: 0x2::table::Table<address, vector<u64>>,
    }

    public(friend) fun borrow<T0, T1>(arg0: &mut Hearn, arg1: u64, arg2: address, arg3: address, arg4: u128, arg5: u128, arg6: &0x2::clock::Clock, arg7: &0x5572e96ecf75923178561fae85ae7bd86810574dab3a403e2a98e681d55fd10::pyth_oracle::Oracle, arg8: 0x1::option::Option<address>, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u128, u128) {
        let v0 = read_oracle_price(arg7, market_oracle_id(&arg0.markets, arg1), arg6);
        borrow_with_price<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v0, arg8, arg9)
    }

    fun accrue_borrow_totals_read_only(arg0: &Hearn, arg1: &Market, arg2: u64, arg3: &0x2::clock::Clock) : (u128, u128) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        if (v0 == arg1.last_update) {
            (arg1.total_borrow_assets, arg1.total_borrow_shares)
        } else {
            (arg1.total_borrow_assets + 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::w_mul_down(arg1.total_borrow_assets, 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::w_taylor_compounded(0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::adaptive_curve_irm::borrow_rate_view(&arg0.irm, arg2, arg1.total_supply_assets, arg1.total_borrow_assets, arg1.last_update, arg3), (((v0 - arg1.last_update) / 1000) as u128))), arg1.total_borrow_shares)
        }
    }

    public(friend) fun accrue_interest(arg0: &mut Hearn, arg1: u64, arg2: &0x2::clock::Clock) {
        assert_version(arg0);
        let v0 = take_market(arg0, arg1);
        let v1 = &mut v0;
        let v2 = &mut arg0.irm;
        let v3 = &mut arg0.positions;
        let v4 = &mut arg0.position_counts;
        let v5 = &mut arg0.markets;
        let v6 = &mut arg0.user_market_ids;
        accrue_interest_internal(v1, v2, arg1, arg2, arg0.fee_recipient, v3, v4, v5, v6);
        store_market(arg0, arg1, v0);
    }

    fun accrue_interest_internal(arg0: &mut Market, arg1: &mut 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::adaptive_curve_irm::AdaptiveCurveIrm, arg2: u64, arg3: &0x2::clock::Clock, arg4: address, arg5: &mut 0x2::table::Table<PositionKey, Position>, arg6: &mut 0x2::table::Table<address, u64>, arg7: &mut 0x2::table::Table<u64, Market>, arg8: &mut 0x2::table::Table<address, vector<u64>>) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        if (v0 == arg0.last_update) {
            return
        };
        let v1 = 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::adaptive_curve_irm::borrow_rate(arg1, arg2, arg0.total_supply_assets, arg0.total_borrow_assets, arg0.last_update, arg3);
        let v2 = 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::w_mul_down(arg0.total_borrow_assets, 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::w_taylor_compounded(v1, (((v0 - arg0.last_update) / 1000) as u128)));
        arg0.total_borrow_assets = arg0.total_borrow_assets + v2;
        arg0.total_supply_assets = arg0.total_supply_assets + v2;
        let v3 = if (arg0.fee != 0 && v2 > 0) {
            let v4 = 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::w_mul_down(v2, arg0.fee);
            let v5 = 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::to_shares_down(v4, arg0.total_supply_assets - v4, arg0.total_supply_shares);
            if (v5 > 0) {
                let v6 = PositionKey{
                    market_id : arg2,
                    owner     : arg4,
                };
                let (v7, _) = borrow_position(arg5, arg6, arg7, arg8, v6);
                v7.supply_shares = v7.supply_shares + v5;
                arg0.total_supply_shares = arg0.total_supply_shares + v5;
            };
            v5
        } else {
            0
        };
        0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::events::emit_accrue_interest(arg2, arg0.config.loan_token_type, arg0.config.collateral_token_type, v1, v2, v3);
        arg0.last_update = v0;
    }

    fun add_to_reserve<T0>(arg0: &mut 0x2::object_bag::ObjectBag, arg1: u64, arg2: 0x2::coin::Coin<T0>) {
        if (0x2::object_bag::contains<u64>(arg0, arg1)) {
            let v0 = 0x2::object_bag::remove<u64, 0x2::coin::Coin<T0>>(arg0, arg1);
            0x2::coin::join<T0>(&mut v0, arg2);
            0x2::object_bag::add<u64, 0x2::coin::Coin<T0>>(arg0, arg1, v0);
        } else {
            0x2::object_bag::add<u64, 0x2::coin::Coin<T0>>(arg0, arg1, arg2);
        };
    }

    fun assert_borrow_not_paused(arg0: &Hearn, arg1: &Market) {
        assert_not_paused(arg0, arg1);
        assert!(!arg1.is_borrow_pause, 24);
    }

    public fun assert_clm_cap_market(arg0: &CLMCap, arg1: u64) {
        assert!(arg0.market_id == arg1, 30);
    }

    fun assert_not_paused(arg0: &Hearn, arg1: &Market) {
        assert!(!arg0.is_paused, 15);
        assert!(!arg1.is_paused, 16);
    }

    fun assert_repay_not_paused(arg0: &Hearn, arg1: &Market) {
        assert_not_paused(arg0, arg1);
        assert!(!arg1.is_repay_pause, 25);
    }

    fun assert_supply_collateral_not_paused(arg0: &Hearn, arg1: &Market) {
        assert_not_paused(arg0, arg1);
        assert!(!arg1.is_supply_collateral_pause, 22);
    }

    fun assert_supply_not_paused(arg0: &Hearn, arg1: &Market) {
        assert_not_paused(arg0, arg1);
        assert!(!arg1.is_supply_pause, 20);
    }

    fun assert_version(arg0: &Hearn) {
        assert!(arg0.version == 1, 14);
    }

    fun assert_withdraw_collateral_not_paused(arg0: &Hearn, arg1: &Market) {
        assert_not_paused(arg0, arg1);
        assert!(!arg1.is_withdraw_collateral_pause, 23);
    }

    fun assert_withdraw_not_paused(arg0: &Hearn, arg1: &Market) {
        assert_not_paused(arg0, arg1);
        assert!(!arg1.is_withdraw_pause, 21);
    }

    fun borrow_position(arg0: &mut 0x2::table::Table<PositionKey, Position>, arg1: &mut 0x2::table::Table<address, u64>, arg2: &mut 0x2::table::Table<u64, Market>, arg3: &mut 0x2::table::Table<address, vector<u64>>, arg4: PositionKey) : (&mut Position, bool) {
        let v0 = if (!0x2::table::contains<PositionKey, Position>(arg0, arg4)) {
            let v1 = Position{
                supply_shares : 0,
                borrow_shares : 0,
                collateral    : 0,
                llv_shares    : 0,
            };
            0x2::table::add<PositionKey, Position>(arg0, arg4, v1);
            increment_position_count(arg1, arg4.owner);
            if (0x2::table::contains<u64, Market>(arg2, arg4.market_id)) {
                let v2 = 0x2::table::borrow_mut<u64, Market>(arg2, arg4.market_id);
                v2.open_position_count = v2.open_position_count + 1;
            };
            if (!0x2::table::contains<address, vector<u64>>(arg3, arg4.owner)) {
                0x2::table::add<address, vector<u64>>(arg3, arg4.owner, 0x1::vector::singleton<u64>(arg4.market_id));
            } else {
                let v3 = 0x2::table::borrow_mut<address, vector<u64>>(arg3, arg4.owner);
                if (!0x1::vector::contains<u64>(v3, &arg4.market_id)) {
                    0x1::vector::push_back<u64>(v3, arg4.market_id);
                };
            };
            true
        } else {
            false
        };
        (0x2::table::borrow_mut<PositionKey, Position>(arg0, arg4), v0)
    }

    fun borrow_with_price<T0, T1>(arg0: &mut Hearn, arg1: u64, arg2: address, arg3: address, arg4: u128, arg5: u128, arg6: &0x2::clock::Clock, arg7: u128, arg8: 0x1::option::Option<address>, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u128, u128) {
        assert_version(arg0);
        ensure_authorized_with_uid_proof(&arg0.authorizations, arg2, 0x2::tx_context::sender(arg9), &arg8);
        exactly_one_zero(arg4, arg5);
        let v0 = take_market(arg0, arg1);
        assert_borrow_not_paused(arg0, &v0);
        ensure_market_types<T0, T1>(&v0);
        let v1 = &mut v0;
        let v2 = &mut arg0.irm;
        let v3 = &mut arg0.positions;
        let v4 = &mut arg0.position_counts;
        let v5 = &mut arg0.markets;
        let v6 = &mut arg0.user_market_ids;
        accrue_interest_internal(v1, v2, arg1, arg6, arg0.fee_recipient, v3, v4, v5, v6);
        let v7 = &mut v0.reserves;
        let (v8, _) = take_reserve_or_zero<T0>(v7, 0, arg9);
        let v10 = v8;
        let (v11, v12) = if (arg4 > 0) {
            (arg4, 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::to_shares_up(arg4, v0.total_borrow_assets, v0.total_borrow_shares))
        } else {
            (0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::to_assets_down(arg5, v0.total_borrow_assets, v0.total_borrow_shares), arg5)
        };
        let v13 = v0.total_borrow_assets + v11;
        let v14 = v0.total_borrow_shares + v12;
        let v15 = &mut arg0.positions;
        let v16 = &mut arg0.position_counts;
        let v17 = &mut arg0.markets;
        let v18 = &mut arg0.user_market_ids;
        let (v19, v20) = borrow_position(v15, v16, v17, v18, new_position_key(arg1, arg2));
        if (v20) {
            v0.open_position_count = v0.open_position_count + 1;
        };
        v19.borrow_shares = v19.borrow_shares + v12;
        if (v13 > v0.total_supply_assets) {
            let v21 = &mut v0.reserves;
            store_reserve<T0>(v21, 0, v10);
            store_market(arg0, arg1, v0);
            abort 4
        };
        if (v11 > (0x2::coin::value<T0>(&v10) as u128)) {
            let v22 = &mut v0.reserves;
            store_reserve<T0>(v22, 0, v10);
            store_market(arg0, arg1, v0);
            abort 4
        };
        let v23 = if (v11 > 0) {
            0x2::coin::split<T0>(&mut v10, 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::to_u64(v11), arg9)
        } else {
            0x2::coin::zero<T0>(arg9)
        };
        let v24 = &mut v0.reserves;
        store_reserve<T0>(v24, 0, v10);
        v0.total_borrow_shares = v14;
        v0.total_borrow_assets = v13;
        store_market(arg0, arg1, v0);
        assert!(is_healthy_internal(v0.base_token_decimals, v0.quote_token_decimals, v19.borrow_shares, v13, v14, v19.collateral, arg7, v0.config.ltv), 11);
        0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::events::emit_borrow(arg1, 0x2::tx_context::sender(arg9), arg2, arg3, v11, v12, v0.config.loan_token_type, v0.config.collateral_token_type);
        (v23, v11, v12)
    }

    fun calculate_health_values(arg0: u64, arg1: u64, arg2: u128, arg3: u128, arg4: u128, arg5: u128, arg6: u128, arg7: u64) : (u128, u128) {
        (0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::mul_div(0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::to_assets_up(arg2, arg3, arg4), 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::wad(), decimal_scale(arg1)), 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::mul_div(0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::mul_div(arg5, arg6, 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::wad()), (arg7 as u128), decimal_scale(arg0)))
    }

    fun cleanup_position_if_empty(arg0: &mut 0x2::table::Table<PositionKey, Position>, arg1: &mut 0x2::table::Table<address, u64>, arg2: &mut 0x2::table::Table<u64, Market>, arg3: &mut 0x2::table::Table<address, vector<u64>>, arg4: PositionKey) {
        if (!0x2::table::contains<PositionKey, Position>(arg0, arg4)) {
            return
        };
        let v0 = 0x2::table::borrow<PositionKey, Position>(arg0, arg4);
        let v1 = if (v0.supply_shares == 0) {
            if (v0.borrow_shares == 0) {
                if (v0.collateral == 0) {
                    v0.llv_shares == 0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        if (v1) {
            let Position {
                supply_shares : _,
                borrow_shares : _,
                collateral    : _,
                llv_shares    : _,
            } = 0x2::table::remove<PositionKey, Position>(arg0, arg4);
            decrement_position_count(arg1, arg4.owner);
            if (0x2::table::contains<u64, Market>(arg2, arg4.market_id)) {
                let v6 = 0x2::table::borrow_mut<u64, Market>(arg2, arg4.market_id);
                assert!(v6.open_position_count > 0, 19);
                v6.open_position_count = v6.open_position_count - 1;
            };
            if (0x2::table::contains<address, vector<u64>>(arg3, arg4.owner)) {
                let v7 = 0x2::table::borrow_mut<address, vector<u64>>(arg3, arg4.owner);
                let (v8, v9) = 0x1::vector::index_of<u64>(v7, &arg4.market_id);
                if (v8) {
                    0x1::vector::remove<u64>(v7, v9);
                };
            };
        };
    }

    public fun clm_cap_market_id(arg0: &CLMCap) : u64 {
        arg0.market_id
    }

    public(friend) fun compute_ltv_with_price(arg0: u64, arg1: u64, arg2: u128, arg3: u128, arg4: u128, arg5: u128, arg6: u128) : u128 {
        if (arg2 == 0) {
            return 0
        };
        if (arg5 == 0) {
            return 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::wad()
        };
        let v0 = 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::mul_div(0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::mul_div(arg5, arg6, 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::wad()), 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::wad(), decimal_scale(arg0));
        if (v0 == 0) {
            return 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::wad()
        };
        0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::mul_div_up(0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::mul_div(0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::to_assets_up(arg2, arg3, arg4), 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::wad(), decimal_scale(arg1)), 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::wad(), v0)
    }

    public fun create_clm_cap(arg0: &mut Hearn, arg1: u64, arg2: &0x2::tx_context::TxContext) : CLMCap {
        assert_version(arg0);
        ensure_owner(arg0, 0x2::tx_context::sender(arg2));
        assert!(0x2::table::contains<u64, Market>(&arg0.markets, arg1), 2);
        let v0 = take_market(arg0, arg1);
        assert!(!v0.config.has_clm_cap, 31);
        v0.config.has_clm_cap = true;
        store_market(arg0, arg1, v0);
        CLMCap{market_id: arg1}
    }

    public(friend) fun create_market(arg0: &mut Hearn, arg1: &0x5572e96ecf75923178561fae85ae7bd86810574dab3a403e2a98e681d55fd10::pyth_oracle::Oracle, arg2: MarketParams, arg3: u128, arg4: u128, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : u64 {
        assert_version(arg0);
        ensure_owner(arg0, 0x2::tx_context::sender(arg7));
        if (!0x2::table::contains<u64, bool>(&arg0.enabled_lltvs, arg2.lltv)) {
            abort 2
        };
        if (arg3 > 250000000000000000) {
            abort 10
        };
        let (v0, v1) = 0x5572e96ecf75923178561fae85ae7bd86810574dab3a403e2a98e681d55fd10::pyth_oracle::market_decimals(arg1, arg2.oracle_id);
        let v2 = arg0.next_market_id;
        arg0.next_market_id = v2 + 1;
        if (0x2::table::contains<u64, Market>(&arg0.markets, v2)) {
            abort 1
        };
        let v3 = Market{
            config                       : arg2,
            last_update                  : 0x2::clock::timestamp_ms(arg6),
            total_supply_assets          : 0,
            total_supply_shares          : 0,
            total_borrow_assets          : 0,
            total_borrow_shares          : 0,
            total_collateral_assets      : 0,
            fee                          : arg3,
            flashloan_fee                : arg4,
            reserves                     : 0x2::object_bag::new(arg7),
            is_paused                    : false,
            is_supply_pause              : false,
            is_withdraw_pause            : false,
            is_supply_collateral_pause   : false,
            is_withdraw_collateral_pause : false,
            is_borrow_pause              : false,
            is_repay_pause               : false,
            title                        : arg5,
            open_position_count          : 0,
            base_token_decimals          : v0,
            quote_token_decimals         : v1,
        };
        0x2::table::add<u64, Market>(&mut arg0.markets, v2, v3);
        0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::events::emit_create_market(v2, arg2.loan_token_type, arg2.collateral_token_type, arg2.oracle_id, arg2.ltv, arg2.lltv, arg3, arg4, 0x2::table::borrow<u64, Market>(&arg0.markets, v2).title, v0, v1);
        v2
    }

    public(friend) fun create_market_typed<T0, T1>(arg0: &mut Hearn, arg1: &0x5572e96ecf75923178561fae85ae7bd86810574dab3a403e2a98e681d55fd10::pyth_oracle::Oracle, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u128, arg7: u128, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : u64 {
        create_market(arg0, arg1, new_market_params<T0, T1>(arg2, arg3, arg4, arg5), arg6, arg7, arg8, arg9, arg10)
    }

    fun decimal_scale(arg0: u64) : u128 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    fun decrement_position_count(arg0: &mut 0x2::table::Table<address, u64>, arg1: address) {
        if (!0x2::table::contains<address, u64>(arg0, arg1)) {
            abort 19
        };
        let v0 = 0x2::table::remove<address, u64>(arg0, arg1);
        assert!(v0 > 0, 19);
        let v1 = v0 - 1;
        if (v1 > 0) {
            0x2::table::add<address, u64>(arg0, arg1, v1);
        };
    }

    public(friend) fun deposit_to_collateral_reserve<T0>(arg0: &mut Hearn, arg1: u64, arg2: 0x2::coin::Coin<T0>) {
        assert_version(arg0);
        if (0x2::coin::value<T0>(&arg2) == 0) {
            0x2::coin::destroy_zero<T0>(arg2);
            return
        };
        let v0 = take_market(arg0, arg1);
        ensure_market_collateral_type<T0>(&v0);
        let v1 = &mut v0.reserves;
        add_to_reserve<T0>(v1, 1, arg2);
        store_market(arg0, arg1, v0);
    }

    public(friend) fun enable_lltv(arg0: &mut Hearn, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        ensure_owner(arg0, 0x2::tx_context::sender(arg2));
        if (0x2::table::contains<u64, bool>(&arg0.enabled_lltvs, arg1)) {
            0x2::table::remove<u64, bool>(&mut arg0.enabled_lltvs, arg1);
        };
        0x2::table::add<u64, bool>(&mut arg0.enabled_lltvs, arg1, true);
        0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::events::emit_enable_lltv(arg1);
    }

    fun ensure_authorized(arg0: &0x2::table::Table<Authorization, bool>, arg1: address, arg2: address) {
        if (arg1 == arg2) {
            return
        };
        let v0 = Authorization{
            owner    : arg1,
            operator : arg2,
        };
        if (!0x2::table::contains<Authorization, bool>(arg0, v0)) {
            abort 6
        };
    }

    fun ensure_authorized_with_uid_proof(arg0: &0x2::table::Table<Authorization, bool>, arg1: address, arg2: address, arg3: &0x1::option::Option<address>) {
        if (0x1::option::is_some<address>(arg3)) {
            if (*0x1::option::borrow<address>(arg3) == arg1) {
                return
            };
        };
        ensure_authorized(arg0, arg1, arg2);
    }

    fun ensure_market_collateral_type<T0>(arg0: &Market) {
        if (arg0.config.collateral_token_type != 0x1::type_name::with_defining_ids<T0>()) {
            abort 9
        };
    }

    fun ensure_market_loan_type<T0>(arg0: &Market) {
        if (arg0.config.loan_token_type != 0x1::type_name::with_defining_ids<T0>()) {
            abort 9
        };
    }

    fun ensure_market_types<T0, T1>(arg0: &Market) {
        ensure_market_loan_type<T0>(arg0);
        ensure_market_collateral_type<T1>(arg0);
    }

    public(friend) fun ensure_owner(arg0: &Hearn, arg1: address) {
        if (arg1 != arg0.owner) {
            abort 0
        };
    }

    fun exactly_one_zero(arg0: u128, arg1: u128) {
        if (arg0 == 0 && arg1 == 0) {
            abort 3
        };
        if (arg0 != 0 && arg1 != 0) {
            abort 12
        };
    }

    public(friend) fun extract_from_collateral_reserve<T0>(arg0: &mut Hearn, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_version(arg0);
        if (arg2 == 0) {
            return 0x2::coin::zero<T0>(arg3)
        };
        let v0 = take_market(arg0, arg1);
        ensure_market_collateral_type<T0>(&v0);
        let v1 = &mut v0.reserves;
        let (v2, v3) = take_reserve_or_zero<T0>(v1, 1, arg3);
        let v4 = v2;
        assert!(v3 && 0x2::coin::value<T0>(&v4) >= arg2, 5);
        let v5 = &mut v0.reserves;
        store_reserve<T0>(v5, 1, v4);
        store_market(arg0, arg1, v0);
        0x2::coin::split<T0>(&mut v4, arg2, arg3)
    }

    public(friend) fun flash_loan<T0>(arg0: &mut Hearn, arg1: u64, arg2: u64, arg3: u128, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, FlashLoanReceipt<T0>) {
        assert_version(arg0);
        if (arg3 == 0) {
            abort 3
        };
        if (arg2 != 0 && arg2 != 1) {
            abort 9
        };
        let v0 = take_market(arg0, arg1);
        assert_not_paused(arg0, &v0);
        let v1 = &mut v0.reserves;
        let (v2, _) = take_reserve_or_zero<T0>(v1, arg2, arg4);
        let v4 = v2;
        if (arg3 > (0x2::coin::value<T0>(&v4) as u128)) {
            let v5 = &mut v0.reserves;
            store_reserve<T0>(v5, arg2, v4);
            store_market(arg0, arg1, v0);
            abort 4
        };
        let v6 = &mut v0.reserves;
        store_reserve<T0>(v6, arg2, v4);
        store_market(arg0, arg1, v0);
        0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::events::emit_flash_loan(0x2::tx_context::sender(arg4), 0x1::type_name::with_defining_ids<T0>(), arg3);
        let v7 = FlashLoanReceipt<T0>{
            market_id  : arg1,
            amount     : arg3,
            token_slot : arg2,
        };
        (0x2::coin::split<T0>(&mut v4, 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::to_u64(arg3), arg4), v7)
    }

    public(friend) fun flash_loan_repay<T0>(arg0: &mut Hearn, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: FlashLoanReceipt<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        let FlashLoanReceipt {
            market_id  : v0,
            amount     : v1,
            token_slot : v2,
        } = arg3;
        if (arg1 != v0) {
            abort 13
        };
        let v3 = take_market(arg0, arg1);
        if ((0x2::coin::value<T0>(&arg2) as u128) < v1 + 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::w_mul_down(v1, v3.flashloan_fee)) {
            store_market(arg0, arg1, v3);
            abort 7
        };
        let v4 = &mut v3.reserves;
        let (v5, _) = take_reserve_or_zero<T0>(v4, v2, arg4);
        let v7 = v5;
        0x2::coin::join<T0>(&mut v7, arg2);
        let v8 = &mut v3.reserves;
        store_reserve<T0>(v8, v2, v7);
        store_market(arg0, arg1, v3);
    }

    public fun get_collateral_reserve_balance<T0>(arg0: &Hearn, arg1: u64) : u64 {
        if (!0x2::table::contains<u64, Market>(&arg0.markets, arg1)) {
            abort 2
        };
        let v0 = 0x2::table::borrow<u64, Market>(&arg0.markets, arg1);
        ensure_market_collateral_type<T0>(v0);
        if (!0x2::object_bag::contains<u64>(&v0.reserves, 1)) {
            return 0
        };
        0x2::coin::value<T0>(0x2::object_bag::borrow<u64, 0x2::coin::Coin<T0>>(&v0.reserves, 1))
    }

    public fun get_market_llv_config(arg0: &Hearn, arg1: u64) : (u64, 0x1::option::Option<0x2::object::ID>) {
        if (!0x2::table::contains<u64, Market>(&arg0.markets, arg1)) {
            abort 2
        };
        let v0 = 0x2::table::borrow<u64, Market>(&arg0.markets, arg1);
        (v0.config.recall_ltv, v0.config.llv_pool_id)
    }

    public fun get_position_collateral(arg0: &Hearn, arg1: u64, arg2: address) : u128 {
        let v0 = new_position_key(arg1, arg2);
        if (!0x2::table::contains<PositionKey, Position>(&arg0.positions, v0)) {
            return 0
        };
        0x2::table::borrow<PositionKey, Position>(&arg0.positions, v0).collateral
    }

    public fun get_position_llv_shares(arg0: &Hearn, arg1: u64, arg2: address) : u128 {
        let v0 = new_position_key(arg1, arg2);
        if (!0x2::table::contains<PositionKey, Position>(&arg0.positions, v0)) {
            return 0
        };
        0x2::table::borrow<PositionKey, Position>(&arg0.positions, v0).llv_shares
    }

    public fun get_total_collateral_value(arg0: &Hearn, arg1: u64, arg2: address, arg3: u128) : u128 {
        let v0 = new_position_key(arg1, arg2);
        if (!0x2::table::contains<PositionKey, Position>(&arg0.positions, v0)) {
            return 0
        };
        0x2::table::borrow<PositionKey, Position>(&arg0.positions, v0).collateral
    }

    public(friend) fun get_user_ltv<T0, T1>(arg0: &Hearn, arg1: u64, arg2: address, arg3: &0x5572e96ecf75923178561fae85ae7bd86810574dab3a403e2a98e681d55fd10::pyth_oracle::Oracle, arg4: &0x2::clock::Clock) : u128 {
        get_user_ltv_with_llv<T0, T1>(arg0, arg1, arg2, arg3, arg4, 0)
    }

    public(friend) fun get_user_ltv_with_llv<T0, T1>(arg0: &Hearn, arg1: u64, arg2: address, arg3: &0x5572e96ecf75923178561fae85ae7bd86810574dab3a403e2a98e681d55fd10::pyth_oracle::Oracle, arg4: &0x2::clock::Clock, arg5: u128) : u128 {
        if (!0x2::table::contains<u64, Market>(&arg0.markets, arg1)) {
            abort 2
        };
        let v0 = 0x2::table::borrow<u64, Market>(&arg0.markets, arg1);
        ensure_market_types<T0, T1>(v0);
        let v1 = new_position_key(arg1, arg2);
        if (!0x2::table::contains<PositionKey, Position>(&arg0.positions, v1)) {
            return 0
        };
        let v2 = 0x2::table::borrow<PositionKey, Position>(&arg0.positions, v1);
        if (v2.borrow_shares == 0) {
            return 0
        };
        compute_ltv_with_price(v0.base_token_decimals, v0.quote_token_decimals, v2.borrow_shares, v0.total_borrow_assets, v0.total_borrow_shares, v2.collateral, 0x5572e96ecf75923178561fae85ae7bd86810574dab3a403e2a98e681d55fd10::pyth_oracle::price(arg3, v0.config.oracle_id, arg4))
    }

    fun get_user_position_info_with_price(arg0: &Hearn, arg1: &Market, arg2: u64, arg3: address, arg4: u128) : UserPositionInfo {
        let v0 = PositionKey{
            market_id : arg2,
            owner     : arg3,
        };
        let (v1, v2, v3) = if (0x2::table::contains<PositionKey, Position>(&arg0.positions, v0)) {
            let v4 = 0x2::table::borrow<PositionKey, Position>(&arg0.positions, v0);
            (v4.collateral, v4.borrow_shares, v4.supply_shares)
        } else {
            (0, 0, 0)
        };
        let v5 = if (!0x2::table::contains<PositionKey, Position>(&arg0.positions, v0) || v2 == 0) {
            340282366920938463463374607431768211455
        } else {
            let (v6, v7) = calculate_health_values(arg1.base_token_decimals, arg1.quote_token_decimals, v2, arg1.total_borrow_assets, arg1.total_borrow_shares, v1, arg4, arg1.config.lltv);
            if (v6 == 0) {
                340282366920938463463374607431768211455
            } else {
                0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::w_div_down(v7, v6)
            }
        };
        UserPositionInfo{
            market_id                   : arg2,
            collateral                  : v1,
            borrow_shares               : v2,
            borrow_assets               : user_position_borrow_assets(arg0, arg2, arg3),
            supply_shares               : v3,
            supply_assets               : user_position_supply_assets(arg0, arg2, arg3),
            health_factor               : v5,
            withdrawable_assets         : user_withdrawable_assets(arg0, arg2, arg3),
            max_borrowable              : max_borrowable_with_price_wad(arg0, arg1, arg2, arg3, arg4),
            max_withdrawable_collateral : max_withdrawable_collateral_with_price_wad(arg0, arg1, arg2, arg3, arg4),
        }
    }

    public fun hearn_address(arg0: &Hearn) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    fun increment_position_count(arg0: &mut 0x2::table::Table<address, u64>, arg1: address) {
        if (0x2::table::contains<address, u64>(arg0, arg1)) {
            let v0 = 0x2::table::remove<address, u64>(arg0, arg1);
            assert!(v0 < 18446744073709551615, 18);
            0x2::table::add<address, u64>(arg0, arg1, v0 + 1);
        } else {
            0x2::table::add<address, u64>(arg0, arg1, 1);
        };
    }

    fun init(arg0: MARKET, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<MARKET>(&arg0), 6);
        let v0 = 0x2::tx_context::sender(arg1);
        0x2::transfer::share_object<Hearn>(new_hearn(v0, arg1));
    }

    public fun is_authorized(arg0: &Hearn, arg1: address, arg2: address) : bool {
        let v0 = Authorization{
            owner    : arg1,
            operator : arg2,
        };
        0x2::table::contains<Authorization, bool>(&arg0.authorizations, v0)
    }

    public fun is_global_paused(arg0: &Hearn) : bool {
        arg0.is_paused
    }

    fun is_healthy_internal(arg0: u64, arg1: u64, arg2: u128, arg3: u128, arg4: u128, arg5: u128, arg6: u128, arg7: u64) : bool {
        if (arg2 == 0) {
            return true
        };
        let (v0, v1) = calculate_health_values(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        v0 <= v1
    }

    public(friend) fun liquidate<T0, T1>(arg0: &mut Hearn, arg1: u64, arg2: address, arg3: u128, arg4: u128, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::clock::Clock, arg7: &0x5572e96ecf75923178561fae85ae7bd86810574dab3a403e2a98e681d55fd10::pyth_oracle::Oracle, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u128, u128, u128, 0x2::coin::Coin<T0>) {
        let v0 = read_oracle_liquidate_price(arg7, market_oracle_id(&arg0.markets, arg1), arg6);
        liquidate_with_price<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v0, arg8)
    }

    public fun liquidate_plan<T0, T1>(arg0: &Hearn, arg1: u64, arg2: address, arg3: u128, arg4: u128, arg5: &0x2::clock::Clock, arg6: &0x5572e96ecf75923178561fae85ae7bd86810574dab3a403e2a98e681d55fd10::pyth_oracle::Oracle) : (u128, u128, u128, bool) {
        assert_version(arg0);
        let v0 = 0x2::table::borrow<u64, Market>(&arg0.markets, arg1);
        ensure_market_types<T0, T1>(v0);
        let v1 = new_position_key(arg1, arg2);
        if (!0x2::table::contains<PositionKey, Position>(&arg0.positions, v1)) {
            return (0, 0, 0, false)
        };
        liquidate_plan_with_price(v0, 0x2::table::borrow<PositionKey, Position>(&arg0.positions, v1), arg3, arg4, read_oracle_liquidate_price(arg6, market_oracle_id(&arg0.markets, arg1), arg5))
    }

    fun liquidate_plan_with_price(arg0: &Market, arg1: &Position, arg2: u128, arg3: u128, arg4: u128) : (u128, u128, u128, bool) {
        if (arg1.borrow_shares == 0 || arg1.collateral == 0) {
            return (0, 0, 0, false)
        };
        let v0 = 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::wad() - 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::w_mul_down(300000000000000000, 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::wad() - (arg0.config.lltv as u128));
        let v1 = if (v0 > 0) {
            let v2 = 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::w_div_down(0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::wad(), v0);
            let v3 = 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::wad() + 150000000000000000;
            if (v2 < v3) {
                v2
            } else {
                v3
            }
        } else {
            0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::wad() + 150000000000000000
        };
        let (v4, v5) = if (arg2 > 0) {
            (0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::to_shares_up(0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::w_div_up(0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::mul_div(arg2, arg4, 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::wad()), v1), arg0.total_borrow_assets, arg0.total_borrow_shares), arg2)
        } else {
            (arg3, 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::mul_div(0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::w_mul_down(0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::to_assets_down(arg3, arg0.total_borrow_assets, arg0.total_borrow_shares), v1), 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::wad(), arg4))
        };
        let v6 = arg1.borrow_shares;
        let v7 = arg1.collateral;
        let v8 = 0;
        while (v8 < 2) {
            if (v4 > v6) {
                v4 = v6;
                v5 = 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::mul_div(0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::w_mul_down(0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::to_assets_down(v6, arg0.total_borrow_assets, arg0.total_borrow_shares), v1), 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::wad(), arg4);
            };
            if (v5 > v7) {
                v5 = v7;
                v4 = 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::to_shares_up(0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::w_div_up(0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::mul_div(v7, arg4, 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::wad()), v1), arg0.total_borrow_assets, arg0.total_borrow_shares);
            };
            v8 = v8 + 1;
        };
        if (v4 > v6) {
            v4 = v6;
        };
        if (v5 > v7) {
            v5 = v7;
        };
        (0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::to_assets_up(v4, arg0.total_borrow_assets, arg0.total_borrow_shares), v5, v4, !is_healthy_internal(arg0.base_token_decimals, arg0.quote_token_decimals, arg1.borrow_shares, arg0.total_borrow_assets, arg0.total_borrow_shares, arg1.collateral, arg4, arg0.config.lltv))
    }

    fun liquidate_with_price<T0, T1>(arg0: &mut Hearn, arg1: u64, arg2: address, arg3: u128, arg4: u128, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::clock::Clock, arg7: u128, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u128, u128, u128, 0x2::coin::Coin<T0>) {
        assert_version(arg0);
        exactly_one_zero(arg3, arg4);
        let v0 = take_market(arg0, arg1);
        ensure_market_types<T0, T1>(&v0);
        let v1 = &mut v0;
        let v2 = &mut arg0.irm;
        let v3 = &mut arg0.positions;
        let v4 = &mut arg0.position_counts;
        let v5 = &mut arg0.markets;
        let v6 = &mut arg0.user_market_ids;
        accrue_interest_internal(v1, v2, arg1, arg6, arg0.fee_recipient, v3, v4, v5, v6);
        let v7 = new_position_key(arg1, arg2);
        if (!0x2::table::contains<PositionKey, Position>(&arg0.positions, v7)) {
            store_market(arg0, arg1, v0);
            abort 26
        };
        let v8 = &mut arg0.positions;
        let v9 = &mut arg0.position_counts;
        let v10 = &mut arg0.markets;
        let v11 = &mut arg0.user_market_ids;
        let (v12, _) = borrow_position(v8, v9, v10, v11, v7);
        let (v14, v15, v16, v17) = liquidate_plan_with_price(&v0, v12, arg3, arg4, arg7);
        assert!(v17, 11);
        assert!(v16 <= v12.borrow_shares, 12);
        assert!(v15 <= v12.collateral, 12);
        assert!(v16 <= v0.total_borrow_shares, 12);
        assert!(v15 <= v0.total_collateral_assets, 12);
        let v18 = (0x2::coin::value<T0>(&arg5) as u128);
        if (v18 < v14) {
            store_market(arg0, arg1, v0);
            abort 7
        };
        let (v19, v20) = if (v18 > v14) {
            if (v14 == 0) {
                (0x2::coin::zero<T0>(arg8), arg5)
            } else {
                (0x2::coin::split<T0>(&mut arg5, 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::to_u64(v14), arg8), arg5)
            }
        } else {
            let v20 = 0x2::coin::zero<T0>(arg8);
            (arg5, v20)
        };
        v12.borrow_shares = v12.borrow_shares - v16;
        v0.total_borrow_shares = v0.total_borrow_shares - v16;
        v0.total_borrow_assets = 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::zero_floor_sub(v0.total_borrow_assets, v14);
        v12.collateral = v12.collateral - v15;
        let (v21, v22) = if (v12.collateral == 0 && v12.borrow_shares > 0) {
            let v23 = v12.borrow_shares;
            let v24 = 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::to_assets_up(v23, v0.total_borrow_assets, v0.total_borrow_shares);
            let v25 = if (v24 > v0.total_borrow_assets) {
                v0.total_borrow_assets
            } else {
                v24
            };
            v0.total_borrow_assets = v0.total_borrow_assets - v25;
            v0.total_supply_assets = v0.total_supply_assets - v25;
            v0.total_borrow_shares = v0.total_borrow_shares - v23;
            v12.borrow_shares = 0;
            (v25, v23)
        } else {
            (0, 0)
        };
        let v26 = &mut v0.reserves;
        let (v27, _) = take_reserve_or_zero<T0>(v26, 0, arg8);
        let v29 = v27;
        0x2::coin::join<T0>(&mut v29, v19);
        let v30 = &mut v0.reserves;
        store_reserve<T0>(v30, 0, v29);
        let v31 = &mut v0.reserves;
        let (v32, _) = take_reserve_or_zero<T1>(v31, 1, arg8);
        let v34 = v32;
        let v35 = &mut v0.reserves;
        store_reserve<T1>(v35, 1, v34);
        v0.total_collateral_assets = v0.total_collateral_assets - v15;
        store_market(arg0, arg1, v0);
        0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::events::emit_liquidate(arg1, 0x2::tx_context::sender(arg8), arg2, v14, v16, v15, v21, v22, v0.config.loan_token_type, v0.config.collateral_token_type);
        (0x2::coin::split<T1>(&mut v34, 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::to_u64(v15), arg8), v15, v16, v14, v20)
    }

    public fun market_available_liquidity(arg0: &Hearn, arg1: u64) : u128 {
        assert!(0x2::table::contains<u64, Market>(&arg0.markets, arg1), 2);
        let v0 = 0x2::table::borrow<u64, Market>(&arg0.markets, arg1);
        if (v0.total_supply_assets <= v0.total_borrow_assets) {
            0
        } else {
            v0.total_supply_assets - v0.total_borrow_assets
        }
    }

    public fun market_base_token_decimals(arg0: &Hearn, arg1: u64) : u64 {
        assert!(0x2::table::contains<u64, Market>(&arg0.markets, arg1), 2);
        0x2::table::borrow<u64, Market>(&arg0.markets, arg1).base_token_decimals
    }

    public fun market_batch_info(arg0: &Hearn, arg1: vector<u64>, arg2: &0x2::clock::Clock) : vector<MarketInfo> {
        let v0 = arg1;
        if (0x1::vector::is_empty<u64>(&v0)) {
            v0 = 0x1::vector::empty<u64>();
            let v1 = 0;
            while (v1 < arg0.next_market_id) {
                if (0x2::table::contains<u64, Market>(&arg0.markets, v1)) {
                    0x1::vector::push_back<u64>(&mut v0, v1);
                };
                v1 = v1 + 1;
            };
        };
        let v2 = 0x1::vector::empty<MarketInfo>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(&v0)) {
            let v4 = *0x1::vector::borrow<u64>(&v0, v3);
            if (!0x2::table::contains<u64, Market>(&arg0.markets, v4)) {
                v3 = v3 + 1;
                continue
            };
            0x1::vector::push_back<MarketInfo>(&mut v2, market_info(arg0, v4, arg2));
            v3 = v3 + 1;
        };
        v2
    }

    public fun market_borrow_rate(arg0: &Hearn, arg1: u64, arg2: &0x2::clock::Clock) : u128 {
        assert!(0x2::table::contains<u64, Market>(&arg0.markets, arg1), 2);
        let v0 = 0x2::table::borrow<u64, Market>(&arg0.markets, arg1);
        0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::adaptive_curve_irm::borrow_rate_view(&arg0.irm, arg1, v0.total_supply_assets, v0.total_borrow_assets, v0.last_update, arg2)
    }

    public fun market_collateral_token_type(arg0: &Hearn, arg1: u64) : 0x1::type_name::TypeName {
        assert!(0x2::table::contains<u64, Market>(&arg0.markets, arg1), 2);
        0x2::table::borrow<u64, Market>(&arg0.markets, arg1).config.collateral_token_type
    }

    public fun market_fee(arg0: &Hearn, arg1: u64) : u128 {
        assert!(0x2::table::contains<u64, Market>(&arg0.markets, arg1), 2);
        0x2::table::borrow<u64, Market>(&arg0.markets, arg1).fee
    }

    public fun market_flashloan_fee(arg0: &Hearn, arg1: u64) : u128 {
        assert!(0x2::table::contains<u64, Market>(&arg0.markets, arg1), 2);
        0x2::table::borrow<u64, Market>(&arg0.markets, arg1).flashloan_fee
    }

    public fun market_info(arg0: &Hearn, arg1: u64, arg2: &0x2::clock::Clock) : MarketInfo {
        assert!(0x2::table::contains<u64, Market>(&arg0.markets, arg1), 2);
        let v0 = 0x2::table::borrow<u64, Market>(&arg0.markets, arg1);
        let v1 = 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::adaptive_curve_irm::borrow_rate_view(&arg0.irm, arg1, v0.total_supply_assets, v0.total_borrow_assets, v0.last_update, arg2);
        let v2 = if (v0.total_supply_assets > 0) {
            0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::w_div_down(v0.total_borrow_assets, v0.total_supply_assets)
        } else {
            0
        };
        MarketInfo{
            market_id                    : arg1,
            supply_coin_type             : v0.config.loan_token_type,
            collateral_coin_type         : v0.config.collateral_token_type,
            ltv                          : v0.config.ltv,
            lltv                         : v0.config.lltv,
            liquidation_threshold        : v0.config.lltv,
            total_supply_assets          : v0.total_supply_assets,
            total_borrow_assets          : v0.total_borrow_assets,
            total_collateral_assets      : v0.total_collateral_assets,
            fee                          : v0.fee,
            flashloan_fee                : v0.flashloan_fee,
            supply_rate                  : 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::w_mul_down(0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::w_mul_down(v1, v2), 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::wad() - v0.fee),
            borrow_rate                  : v1,
            utilization_rate             : v2,
            market_paused                : v0.is_paused,
            global_paused                : arg0.is_paused,
            is_supply_pause              : v0.is_supply_pause,
            is_withdraw_pause            : v0.is_withdraw_pause,
            is_supply_collateral_pause   : v0.is_supply_collateral_pause,
            is_withdraw_collateral_pause : v0.is_withdraw_collateral_pause,
            is_borrow_pause              : v0.is_borrow_pause,
            is_repay_pause               : v0.is_repay_pause,
            title                        : v0.title,
        }
    }

    public fun market_is_borrow_paused(arg0: &Hearn, arg1: u64) : bool {
        assert!(0x2::table::contains<u64, Market>(&arg0.markets, arg1), 2);
        0x2::table::borrow<u64, Market>(&arg0.markets, arg1).is_borrow_pause
    }

    public fun market_is_paused(arg0: &Hearn, arg1: u64) : bool {
        assert!(0x2::table::contains<u64, Market>(&arg0.markets, arg1), 2);
        0x2::table::borrow<u64, Market>(&arg0.markets, arg1).is_paused
    }

    public fun market_is_repay_paused(arg0: &Hearn, arg1: u64) : bool {
        assert!(0x2::table::contains<u64, Market>(&arg0.markets, arg1), 2);
        0x2::table::borrow<u64, Market>(&arg0.markets, arg1).is_repay_pause
    }

    public fun market_is_supply_collateral_paused(arg0: &Hearn, arg1: u64) : bool {
        assert!(0x2::table::contains<u64, Market>(&arg0.markets, arg1), 2);
        0x2::table::borrow<u64, Market>(&arg0.markets, arg1).is_supply_collateral_pause
    }

    public fun market_is_supply_paused(arg0: &Hearn, arg1: u64) : bool {
        assert!(0x2::table::contains<u64, Market>(&arg0.markets, arg1), 2);
        0x2::table::borrow<u64, Market>(&arg0.markets, arg1).is_supply_pause
    }

    public fun market_is_withdraw_collateral_paused(arg0: &Hearn, arg1: u64) : bool {
        assert!(0x2::table::contains<u64, Market>(&arg0.markets, arg1), 2);
        0x2::table::borrow<u64, Market>(&arg0.markets, arg1).is_withdraw_collateral_pause
    }

    public fun market_is_withdraw_paused(arg0: &Hearn, arg1: u64) : bool {
        assert!(0x2::table::contains<u64, Market>(&arg0.markets, arg1), 2);
        0x2::table::borrow<u64, Market>(&arg0.markets, arg1).is_withdraw_pause
    }

    public fun market_last_update(arg0: &Hearn, arg1: u64) : u64 {
        assert!(0x2::table::contains<u64, Market>(&arg0.markets, arg1), 2);
        0x2::table::borrow<u64, Market>(&arg0.markets, arg1).last_update
    }

    public fun market_liquidation_bonus(arg0: &Hearn, arg1: u64) : u64 {
        assert!(0x2::table::contains<u64, Market>(&arg0.markets, arg1), 2);
        0x2::table::borrow<u64, Market>(&arg0.markets, arg1).config.liquidation_bonus
    }

    public fun market_lltv(arg0: &Hearn, arg1: u64) : u64 {
        assert!(0x2::table::contains<u64, Market>(&arg0.markets, arg1), 2);
        0x2::table::borrow<u64, Market>(&arg0.markets, arg1).config.lltv
    }

    public fun market_loan_token_type(arg0: &Hearn, arg1: u64) : 0x1::type_name::TypeName {
        assert!(0x2::table::contains<u64, Market>(&arg0.markets, arg1), 2);
        0x2::table::borrow<u64, Market>(&arg0.markets, arg1).config.loan_token_type
    }

    public fun market_ltv(arg0: &Hearn, arg1: u64) : u64 {
        assert!(0x2::table::contains<u64, Market>(&arg0.markets, arg1), 2);
        0x2::table::borrow<u64, Market>(&arg0.markets, arg1).config.ltv
    }

    public fun market_oracle_config_id(arg0: &Hearn, arg1: u64) : u64 {
        assert!(0x2::table::contains<u64, Market>(&arg0.markets, arg1), 2);
        0x2::table::borrow<u64, Market>(&arg0.markets, arg1).config.oracle_id
    }

    fun market_oracle_id(arg0: &0x2::table::Table<u64, Market>, arg1: u64) : u64 {
        if (!0x2::table::contains<u64, Market>(arg0, arg1)) {
            abort 2
        };
        0x2::table::borrow<u64, Market>(arg0, arg1).config.oracle_id
    }

    public fun market_params(arg0: &Hearn, arg1: u64) : MarketParams {
        assert!(0x2::table::contains<u64, Market>(&arg0.markets, arg1), 2);
        0x2::table::borrow<u64, Market>(&arg0.markets, arg1).config
    }

    public fun market_quote_token_decimals(arg0: &Hearn, arg1: u64) : u64 {
        assert!(0x2::table::contains<u64, Market>(&arg0.markets, arg1), 2);
        0x2::table::borrow<u64, Market>(&arg0.markets, arg1).quote_token_decimals
    }

    public fun market_rate_at_target(arg0: &Hearn, arg1: u64) : u128 {
        assert!(0x2::table::contains<u64, Market>(&arg0.markets, arg1), 2);
        0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::adaptive_curve_irm::rate_at_target_view(&arg0.irm, arg1)
    }

    public fun market_supply_rate(arg0: &Hearn, arg1: u64, arg2: &0x2::clock::Clock) : u128 {
        assert!(0x2::table::contains<u64, Market>(&arg0.markets, arg1), 2);
        let v0 = 0x2::table::borrow<u64, Market>(&arg0.markets, arg1);
        let v1 = if (v0.total_supply_assets > 0) {
            0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::w_div_down(v0.total_borrow_assets, v0.total_supply_assets)
        } else {
            0
        };
        0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::w_mul_down(0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::w_mul_down(0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::adaptive_curve_irm::borrow_rate_view(&arg0.irm, arg1, v0.total_supply_assets, v0.total_borrow_assets, v0.last_update, arg2), v1), 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::wad() - v0.fee)
    }

    public fun market_title(arg0: &Hearn, arg1: u64) : vector<u8> {
        assert!(0x2::table::contains<u64, Market>(&arg0.markets, arg1), 2);
        0x2::table::borrow<u64, Market>(&arg0.markets, arg1).title
    }

    public fun market_total_borrow_assets(arg0: &Hearn, arg1: u64) : u128 {
        assert!(0x2::table::contains<u64, Market>(&arg0.markets, arg1), 2);
        0x2::table::borrow<u64, Market>(&arg0.markets, arg1).total_borrow_assets
    }

    public fun market_total_borrow_shares(arg0: &Hearn, arg1: u64) : u128 {
        assert!(0x2::table::contains<u64, Market>(&arg0.markets, arg1), 2);
        0x2::table::borrow<u64, Market>(&arg0.markets, arg1).total_borrow_shares
    }

    public fun market_total_count(arg0: &Hearn) : u64 {
        arg0.next_market_id - 1
    }

    public fun market_total_supply_assets(arg0: &Hearn, arg1: u64) : u128 {
        assert!(0x2::table::contains<u64, Market>(&arg0.markets, arg1), 2);
        0x2::table::borrow<u64, Market>(&arg0.markets, arg1).total_supply_assets
    }

    public fun market_total_supply_shares(arg0: &Hearn, arg1: u64) : u128 {
        assert!(0x2::table::contains<u64, Market>(&arg0.markets, arg1), 2);
        0x2::table::borrow<u64, Market>(&arg0.markets, arg1).total_supply_shares
    }

    public fun market_user_count(arg0: &Hearn, arg1: u64) : u64 {
        assert!(0x2::table::contains<u64, Market>(&arg0.markets, arg1), 2);
        0x2::table::borrow<u64, Market>(&arg0.markets, arg1).open_position_count
    }

    public fun market_utilization_rate(arg0: &Hearn, arg1: u64) : u128 {
        assert!(0x2::table::contains<u64, Market>(&arg0.markets, arg1), 2);
        let v0 = 0x2::table::borrow<u64, Market>(&arg0.markets, arg1);
        if (v0.total_supply_assets > 0) {
            0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::w_div_down(v0.total_borrow_assets, v0.total_supply_assets)
        } else {
            0
        }
    }

    fun max_borrowable_with_price_wad(arg0: &Hearn, arg1: &Market, arg2: u64, arg3: address, arg4: u128) : u128 {
        let v0 = decimal_scale(arg1.quote_token_decimals);
        let v1 = PositionKey{
            market_id : arg2,
            owner     : arg3,
        };
        if (!0x2::table::contains<PositionKey, Position>(&arg0.positions, v1)) {
            return 0
        };
        let v2 = 0x2::table::borrow<PositionKey, Position>(&arg0.positions, v1);
        if (v2.collateral == 0) {
            return 0
        };
        let v3 = 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::mul_div(v2.collateral, arg4, 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::wad());
        if (v3 == 0) {
            return 0
        };
        let v4 = 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::mul_div(v3, (arg1.config.ltv as u128), decimal_scale(arg1.base_token_decimals));
        if (v4 == 0) {
            return 0
        };
        let v5 = if (v2.borrow_shares == 0) {
            0
        } else {
            0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::mul_div(0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::to_assets_up(v2.borrow_shares, arg1.total_borrow_assets, arg1.total_borrow_shares), 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::wad(), v0)
        };
        let v6 = 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::zero_floor_sub(v4, v5);
        if (v6 == 0) {
            return 0
        };
        let v7 = 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::mul_div(v6, v0, 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::wad());
        if (v7 == 0) {
            return 0
        };
        let v8 = market_available_liquidity(arg0, arg2);
        if (v8 == 0) {
            return 0
        };
        if (v7 < v8) {
            v7
        } else {
            v8
        }
    }

    fun max_withdrawable_collateral_with_price_wad(arg0: &Hearn, arg1: &Market, arg2: u64, arg3: address, arg4: u128) : u128 {
        let v0 = PositionKey{
            market_id : arg2,
            owner     : arg3,
        };
        if (!0x2::table::contains<PositionKey, Position>(&arg0.positions, v0)) {
            return 0
        };
        let v1 = 0x2::table::borrow<PositionKey, Position>(&arg0.positions, v0);
        if (v1.collateral == 0) {
            return 0
        };
        if (v1.borrow_shares == 0) {
            return v1.collateral
        };
        let v2 = 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::to_assets_up(v1.borrow_shares, arg1.total_borrow_assets, arg1.total_borrow_shares);
        if (v2 == 0) {
            return v1.collateral
        };
        0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::zero_floor_sub(v1.collateral, 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::mul_div_up(0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::mul_div_up(0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::mul_div(v2, 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::wad(), decimal_scale(arg1.quote_token_decimals)), decimal_scale(arg1.base_token_decimals), (arg1.config.lltv as u128)), 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::wad(), arg4))
    }

    public(friend) fun migrate(arg0: &mut Hearn, arg1: &0x2::tx_context::TxContext) {
        ensure_owner(arg0, 0x2::tx_context::sender(arg1));
        arg0.version = 1;
        0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::events::emit_migrate(arg0.version);
    }

    fun new_hearn(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : Hearn {
        Hearn{
            id              : 0x2::object::new(arg1),
            version         : 1,
            owner           : arg0,
            fee_recipient   : arg0,
            markets         : 0x2::table::new<u64, Market>(arg1),
            positions       : 0x2::table::new<PositionKey, Position>(arg1),
            position_counts : 0x2::table::new<address, u64>(arg1),
            authorizations  : 0x2::table::new<Authorization, bool>(arg1),
            enabled_lltvs   : 0x2::table::new<u64, bool>(arg1),
            next_market_id  : 1,
            irm             : 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::adaptive_curve_irm::create(arg1),
            is_paused       : false,
            user_market_ids : 0x2::table::new<address, vector<u64>>(arg1),
        }
    }

    public fun new_market_params<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : MarketParams {
        assert!(arg2 < arg1, 12);
        MarketParams{
            loan_token_type       : 0x1::type_name::with_defining_ids<T0>(),
            collateral_token_type : 0x1::type_name::with_defining_ids<T1>(),
            oracle_id             : arg0,
            lltv                  : arg1,
            ltv                   : arg2,
            liquidation_bonus     : arg3,
            recall_ltv            : 0,
            llv_pool_id           : 0x1::option::none<0x2::object::ID>(),
            has_clm_cap           : false,
        }
    }

    fun new_position_key(arg0: u64, arg1: address) : PositionKey {
        PositionKey{
            market_id : arg0,
            owner     : arg1,
        }
    }

    fun project_borrow_shares_after_change(arg0: u128, arg1: u128, arg2: bool, arg3: u128, arg4: u128) : u128 {
        let v0 = if (arg1 == 0) {
            0
        } else if (arg2) {
            0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::to_shares_up(arg1, arg3, arg4)
        } else {
            0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::to_shares_down(arg1, arg3, arg4)
        };
        if (arg2) {
            arg0 + v0
        } else if (arg0 >= v0) {
            arg0 - v0
        } else {
            0
        }
    }

    fun read_oracle_liquidate_price(arg0: &0x5572e96ecf75923178561fae85ae7bd86810574dab3a403e2a98e681d55fd10::pyth_oracle::Oracle, arg1: u64, arg2: &0x2::clock::Clock) : u128 {
        let (v0, _) = 0x5572e96ecf75923178561fae85ae7bd86810574dab3a403e2a98e681d55fd10::pyth_oracle::query_price(arg0, arg1, true, arg2);
        v0
    }

    fun read_oracle_price(arg0: &0x5572e96ecf75923178561fae85ae7bd86810574dab3a403e2a98e681d55fd10::pyth_oracle::Oracle, arg1: u64, arg2: &0x2::clock::Clock) : u128 {
        0x5572e96ecf75923178561fae85ae7bd86810574dab3a403e2a98e681d55fd10::pyth_oracle::price(arg0, arg1, arg2)
    }

    public(friend) fun repay<T0, T1>(arg0: &mut Hearn, arg1: u64, arg2: address, arg3: u128, arg4: u128, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (u128, u128, 0x2::coin::Coin<T0>) {
        assert_version(arg0);
        exactly_one_zero(arg3, arg4);
        let v0 = take_market(arg0, arg1);
        assert_repay_not_paused(arg0, &v0);
        ensure_market_types<T0, T1>(&v0);
        let v1 = &mut v0;
        let v2 = &mut arg0.irm;
        let v3 = &mut arg0.positions;
        let v4 = &mut arg0.position_counts;
        let v5 = &mut arg0.markets;
        let v6 = &mut arg0.user_market_ids;
        accrue_interest_internal(v1, v2, arg1, arg6, arg0.fee_recipient, v3, v4, v5, v6);
        let (v7, v8) = if (arg3 > 0) {
            (arg3, 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::to_shares_up(arg3, v0.total_borrow_assets, v0.total_borrow_shares))
        } else {
            (0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::to_assets_up(arg4, v0.total_borrow_assets, v0.total_borrow_shares), arg4)
        };
        let v9 = v8;
        let v10 = v7;
        if (v7 > v0.total_borrow_assets) {
            v10 = v0.total_borrow_assets;
            v9 = v0.total_borrow_shares;
        };
        let v11 = new_position_key(arg1, arg2);
        let v12 = &mut arg0.positions;
        let v13 = &mut arg0.position_counts;
        let v14 = &mut arg0.markets;
        let v15 = &mut arg0.user_market_ids;
        let (v16, v17) = borrow_position(v12, v13, v14, v15, v11);
        if (v17) {
            v0.open_position_count = v0.open_position_count + 1;
        };
        if (v9 > v16.borrow_shares) {
            let v18 = v16.borrow_shares;
            v9 = v18;
            v10 = 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::to_assets_up(v18, v0.total_borrow_assets, v0.total_borrow_shares);
        };
        v16.borrow_shares = v16.borrow_shares - v9;
        let v19 = (0x2::coin::value<T0>(&arg5) as u128);
        if (v19 < v10) {
            store_market(arg0, arg1, v0);
            abort 7
        };
        let v20 = &mut v0.reserves;
        let (v21, _) = take_reserve_or_zero<T0>(v20, 0, arg7);
        let v23 = v21;
        let (v24, v25) = if (v19 > v10) {
            if (v10 == 0) {
                (0x2::coin::zero<T0>(arg7), arg5)
            } else {
                (0x2::coin::split<T0>(&mut arg5, 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::to_u64(v10), arg7), arg5)
            }
        } else {
            (arg5, 0x2::coin::zero<T0>(arg7))
        };
        0x2::coin::join<T0>(&mut v23, v24);
        let v26 = &mut v0.reserves;
        store_reserve<T0>(v26, 0, v23);
        v0.total_borrow_shares = v0.total_borrow_shares - v9;
        v0.total_borrow_assets = 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::zero_floor_sub(v0.total_borrow_assets, v10);
        store_market(arg0, arg1, v0);
        let v27 = &mut arg0.positions;
        let v28 = &mut arg0.position_counts;
        let v29 = &mut arg0.markets;
        let v30 = &mut arg0.user_market_ids;
        cleanup_position_if_empty(v27, v28, v29, v30, v11);
        0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::events::emit_repay(arg1, 0x2::tx_context::sender(arg7), arg2, v10, v9, v0.config.loan_token_type, v0.config.collateral_token_type);
        (v10, v9, v25)
    }

    public(friend) fun set_authorization(arg0: &mut Hearn, arg1: address, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = Authorization{
            owner    : v0,
            operator : arg1,
        };
        if (arg2) {
            if (0x2::table::contains<Authorization, bool>(&arg0.authorizations, v1)) {
                0x2::table::remove<Authorization, bool>(&mut arg0.authorizations, v1);
            };
            0x2::table::add<Authorization, bool>(&mut arg0.authorizations, v1, true);
        } else if (0x2::table::contains<Authorization, bool>(&arg0.authorizations, v1)) {
            0x2::table::remove<Authorization, bool>(&mut arg0.authorizations, v1);
        };
        0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::events::emit_set_authorization(v0, v0, arg1, arg2, 0x1::option::none<u64>());
    }

    public(friend) fun set_fee(arg0: &mut Hearn, arg1: u64, arg2: u128, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        ensure_owner(arg0, 0x2::tx_context::sender(arg4));
        if (arg2 > 250000000000000000) {
            abort 10
        };
        let v0 = take_market(arg0, arg1);
        let v1 = &mut v0;
        let v2 = &mut arg0.irm;
        let v3 = &mut arg0.positions;
        let v4 = &mut arg0.position_counts;
        let v5 = &mut arg0.markets;
        let v6 = &mut arg0.user_market_ids;
        accrue_interest_internal(v1, v2, arg1, arg3, arg0.fee_recipient, v3, v4, v5, v6);
        v0.fee = arg2;
        store_market(arg0, arg1, v0);
        0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::events::emit_set_fee(arg1, arg2);
    }

    public(friend) fun set_fee_recipient(arg0: &mut Hearn, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        ensure_owner(arg0, 0x2::tx_context::sender(arg2));
        arg0.fee_recipient = arg1;
        0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::events::emit_set_fee_recipient(arg0.fee_recipient, arg1);
    }

    public(friend) fun set_flashloan_fee(arg0: &mut Hearn, arg1: u64, arg2: u128, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        ensure_owner(arg0, 0x2::tx_context::sender(arg4));
        if (arg2 > 250000000000000000) {
            abort 10
        };
        let v0 = take_market(arg0, arg1);
        let v1 = &mut v0;
        let v2 = &mut arg0.irm;
        let v3 = &mut arg0.positions;
        let v4 = &mut arg0.position_counts;
        let v5 = &mut arg0.markets;
        let v6 = &mut arg0.user_market_ids;
        accrue_interest_internal(v1, v2, arg1, arg3, arg0.fee_recipient, v3, v4, v5, v6);
        v0.flashloan_fee = arg2;
        store_market(arg0, arg1, v0);
        0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::events::emit_set_flashloan_fee(arg1, arg2);
    }

    public(friend) fun set_global_pause(arg0: &mut Hearn, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        ensure_owner(arg0, 0x2::tx_context::sender(arg2));
        arg0.is_paused = arg1;
        0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::events::emit_set_global_pause(arg1);
    }

    public(friend) fun set_market_borrow_pause(arg0: &mut Hearn, arg1: u64, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        ensure_owner(arg0, 0x2::tx_context::sender(arg3));
        let v0 = take_market(arg0, arg1);
        v0.is_borrow_pause = arg2;
        store_market(arg0, arg1, v0);
        0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::events::emit_set_market_borrow_pause(arg1, arg2);
    }

    public(friend) fun set_market_llv_config(arg0: &mut Hearn, arg1: u64, arg2: u64, arg3: 0x1::option::Option<0x2::object::ID>, arg4: &0x2::tx_context::TxContext) {
        ensure_owner(arg0, 0x2::tx_context::sender(arg4));
        assert_version(arg0);
        let v0 = take_market(arg0, arg1);
        if (arg2 > 0) {
            assert!(arg2 >= v0.config.ltv, 28);
            assert!(arg2 < v0.config.lltv, 28);
        };
        v0.config.recall_ltv = arg2;
        v0.config.llv_pool_id = arg3;
        store_market(arg0, arg1, v0);
    }

    public(friend) fun set_market_pause(arg0: &mut Hearn, arg1: u64, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        ensure_owner(arg0, 0x2::tx_context::sender(arg3));
        let v0 = take_market(arg0, arg1);
        v0.is_paused = arg2;
        store_market(arg0, arg1, v0);
        0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::events::emit_set_market_pause(arg1, arg2);
    }

    public(friend) fun set_market_repay_pause(arg0: &mut Hearn, arg1: u64, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        ensure_owner(arg0, 0x2::tx_context::sender(arg3));
        let v0 = take_market(arg0, arg1);
        v0.is_repay_pause = arg2;
        store_market(arg0, arg1, v0);
        0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::events::emit_set_market_repay_pause(arg1, arg2);
    }

    public(friend) fun set_market_supply_collateral_pause(arg0: &mut Hearn, arg1: u64, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        ensure_owner(arg0, 0x2::tx_context::sender(arg3));
        let v0 = take_market(arg0, arg1);
        v0.is_supply_collateral_pause = arg2;
        store_market(arg0, arg1, v0);
        0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::events::emit_set_market_supply_collateral_pause(arg1, arg2);
    }

    public(friend) fun set_market_supply_pause(arg0: &mut Hearn, arg1: u64, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        ensure_owner(arg0, 0x2::tx_context::sender(arg3));
        let v0 = take_market(arg0, arg1);
        v0.is_supply_pause = arg2;
        store_market(arg0, arg1, v0);
        0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::events::emit_set_market_supply_pause(arg1, arg2);
    }

    public(friend) fun set_market_withdraw_collateral_pause(arg0: &mut Hearn, arg1: u64, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        ensure_owner(arg0, 0x2::tx_context::sender(arg3));
        let v0 = take_market(arg0, arg1);
        v0.is_withdraw_collateral_pause = arg2;
        store_market(arg0, arg1, v0);
        0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::events::emit_set_market_withdraw_collateral_pause(arg1, arg2);
    }

    public(friend) fun set_market_withdraw_pause(arg0: &mut Hearn, arg1: u64, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        ensure_owner(arg0, 0x2::tx_context::sender(arg3));
        let v0 = take_market(arg0, arg1);
        v0.is_withdraw_pause = arg2;
        store_market(arg0, arg1, v0);
        0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::events::emit_set_market_withdraw_pause(arg1, arg2);
    }

    public(friend) fun set_owner(arg0: &mut Hearn, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        ensure_owner(arg0, 0x2::tx_context::sender(arg2));
        arg0.owner = arg1;
        0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::events::emit_set_owner(arg0.owner, arg1);
    }

    fun store_market(arg0: &mut Hearn, arg1: u64, arg2: Market) {
        0x2::table::add<u64, Market>(&mut arg0.markets, arg1, arg2);
    }

    fun store_reserve<T0>(arg0: &mut 0x2::object_bag::ObjectBag, arg1: u64, arg2: 0x2::coin::Coin<T0>) {
        0x2::object_bag::add<u64, 0x2::coin::Coin<T0>>(arg0, arg1, arg2);
    }

    public(friend) fun supply<T0>(arg0: &mut Hearn, arg1: u64, arg2: address, arg3: u128, arg4: u128, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (u128, u128, 0x2::coin::Coin<T0>) {
        assert_version(arg0);
        exactly_one_zero(arg3, arg4);
        let v0 = take_market(arg0, arg1);
        assert_supply_not_paused(arg0, &v0);
        ensure_market_loan_type<T0>(&v0);
        let v1 = &mut v0;
        let v2 = &mut arg0.irm;
        let v3 = &mut arg0.positions;
        let v4 = &mut arg0.position_counts;
        let v5 = &mut arg0.markets;
        let v6 = &mut arg0.user_market_ids;
        accrue_interest_internal(v1, v2, arg1, arg6, arg0.fee_recipient, v3, v4, v5, v6);
        let v7 = (0x2::coin::value<T0>(&arg5) as u128);
        let (v8, v9) = if (arg3 > 0) {
            (arg3, 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::to_shares_down(arg3, v0.total_supply_assets, v0.total_supply_shares))
        } else {
            (0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::to_assets_up(arg4, v0.total_supply_assets, v0.total_supply_shares), arg4)
        };
        if (v7 < v8) {
            store_market(arg0, arg1, v0);
            abort 7
        };
        let (v10, v11) = if (v7 > v8) {
            if (v8 == 0) {
                (0x2::coin::zero<T0>(arg7), arg5)
            } else {
                (0x2::coin::split<T0>(&mut arg5, 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::to_u64(v8), arg7), arg5)
            }
        } else {
            (arg5, 0x2::coin::zero<T0>(arg7))
        };
        let v12 = &mut v0.reserves;
        add_to_reserve<T0>(v12, 0, v10);
        let v13 = &mut arg0.positions;
        let v14 = &mut arg0.position_counts;
        let v15 = &mut arg0.markets;
        let v16 = &mut arg0.user_market_ids;
        let (v17, v18) = borrow_position(v13, v14, v15, v16, new_position_key(arg1, arg2));
        if (v18) {
            v0.open_position_count = v0.open_position_count + 1;
        };
        v17.supply_shares = v17.supply_shares + v9;
        v0.total_supply_shares = v0.total_supply_shares + v9;
        v0.total_supply_assets = v0.total_supply_assets + v8;
        store_market(arg0, arg1, v0);
        0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::events::emit_supply(arg1, 0x2::tx_context::sender(arg7), arg2, v8, v9, v0.config.loan_token_type, v0.config.collateral_token_type);
        (v8, v9, v11)
    }

    public(friend) fun supply_collateral<T0>(arg0: &mut Hearn, arg1: u64, arg2: address, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) : (u128, 0x2::coin::Coin<T0>) {
        assert_version(arg0);
        let v0 = (0x2::coin::value<T0>(&arg3) as u128);
        if (v0 == 0) {
            abort 3
        };
        let v1 = take_market(arg0, arg1);
        assert_supply_collateral_not_paused(arg0, &v1);
        ensure_market_collateral_type<T0>(&v1);
        let v2 = &mut arg0.positions;
        let v3 = &mut arg0.position_counts;
        let v4 = &mut arg0.markets;
        let v5 = &mut arg0.user_market_ids;
        let (v6, v7) = borrow_position(v2, v3, v4, v5, new_position_key(arg1, arg2));
        if (v7) {
            v1.open_position_count = v1.open_position_count + 1;
        };
        let v8 = 340282366920938463463374607431768211455 - v6.collateral;
        let v9 = v0;
        if (v0 > v8) {
            v9 = v8;
        };
        v6.collateral = v6.collateral + v9;
        let (v10, v11) = if (v9 == 0) {
            (arg3, false)
        } else if (v9 == v0) {
            let v12 = &mut v1.reserves;
            add_to_reserve<T0>(v12, 1, arg3);
            (0x2::coin::zero<T0>(arg4), true)
        } else {
            let v13 = &mut v1.reserves;
            add_to_reserve<T0>(v13, 1, 0x2::coin::split<T0>(&mut arg3, 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::to_u64(v9), arg4));
            (arg3, true)
        };
        if (v11) {
            v1.total_collateral_assets = v1.total_collateral_assets + v9;
        };
        store_market(arg0, arg1, v1);
        if (v11) {
            0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::events::emit_supply_collateral(arg1, 0x2::tx_context::sender(arg4), arg2, v9, v1.config.loan_token_type, v1.config.collateral_token_type);
        };
        (v9, v10)
    }

    fun take_market(arg0: &mut Hearn, arg1: u64) : Market {
        if (!0x2::table::contains<u64, Market>(&arg0.markets, arg1)) {
            abort 2
        };
        0x2::table::remove<u64, Market>(&mut arg0.markets, arg1)
    }

    fun take_reserve_or_zero<T0>(arg0: &mut 0x2::object_bag::ObjectBag, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, bool) {
        if (0x2::object_bag::contains<u64>(arg0, arg1)) {
            (0x2::object_bag::remove<u64, 0x2::coin::Coin<T0>>(arg0, arg1), true)
        } else {
            (0x2::coin::zero<T0>(arg2), false)
        }
    }

    public(friend) fun update_market_liquidation_bonus(arg0: &mut Hearn, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        ensure_owner(arg0, 0x2::tx_context::sender(arg3));
        let v0 = take_market(arg0, arg1);
        v0.config.liquidation_bonus = arg2;
        store_market(arg0, arg1, v0);
    }

    public(friend) fun update_market_ltv(arg0: &mut Hearn, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        ensure_owner(arg0, 0x2::tx_context::sender(arg4));
        assert!(arg2 < arg3, 12);
        let v0 = take_market(arg0, arg1);
        let v1 = v0.config.recall_ltv;
        if (v1 > 0) {
            assert!(v1 >= arg2, 28);
            assert!(v1 < arg3, 28);
        };
        v0.config.ltv = arg2;
        v0.config.lltv = arg3;
        store_market(arg0, arg1, v0);
    }

    public(friend) fun update_position_llv_shares(arg0: &mut Hearn, arg1: u64, arg2: address, arg3: u128, arg4: bool, arg5: 0x2::object::ID) {
        assert_version(arg0);
        if (!0x2::table::contains<u64, Market>(&arg0.markets, arg1)) {
            abort 2
        };
        let v0 = 0x2::table::borrow<u64, Market>(&arg0.markets, arg1).config.llv_pool_id;
        assert!(0x1::option::is_some<0x2::object::ID>(&v0), 29);
        assert!(*0x1::option::borrow<0x2::object::ID>(&v0) == arg5, 27);
        let v1 = new_position_key(arg1, arg2);
        if (!0x2::table::contains<PositionKey, Position>(&arg0.positions, v1)) {
            if (arg4 && arg3 > 0) {
                let v2 = &mut arg0.positions;
                let v3 = &mut arg0.position_counts;
                let v4 = &mut arg0.markets;
                let v5 = &mut arg0.user_market_ids;
                let (v6, _) = borrow_position(v2, v3, v4, v5, v1);
                v6.llv_shares = arg3;
            };
            return
        };
        let v8 = 0x2::table::borrow_mut<PositionKey, Position>(&mut arg0.positions, v1);
        if (arg4) {
            v8.llv_shares = v8.llv_shares + arg3;
        } else {
            assert!(v8.llv_shares >= arg3, 5);
            v8.llv_shares = v8.llv_shares - arg3;
        };
    }

    public fun user_health_factor(arg0: &Hearn, arg1: u64, arg2: address, arg3: &0x5572e96ecf75923178561fae85ae7bd86810574dab3a403e2a98e681d55fd10::pyth_oracle::Oracle, arg4: &0x2::clock::Clock) : u128 {
        let v0 = PositionKey{
            market_id : arg1,
            owner     : arg2,
        };
        if (!0x2::table::contains<PositionKey, Position>(&arg0.positions, v0)) {
            return 340282366920938463463374607431768211455
        };
        let v1 = 0x2::table::borrow<PositionKey, Position>(&arg0.positions, v0);
        if (v1.borrow_shares == 0) {
            return 340282366920938463463374607431768211455
        };
        let v2 = 0x2::table::borrow<u64, Market>(&arg0.markets, arg1);
        let (v3, v4) = calculate_health_values(v2.base_token_decimals, v2.quote_token_decimals, v1.borrow_shares, v2.total_borrow_assets, v2.total_borrow_shares, v1.collateral, read_oracle_price(arg3, v2.config.oracle_id, arg4), v2.config.lltv);
        if (v3 == 0) {
            return 340282366920938463463374607431768211455
        };
        0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::w_div_down(v4, v3)
    }

    public fun user_health_factor_after_change(arg0: &Hearn, arg1: u64, arg2: address, arg3: u128, arg4: bool, arg5: u128, arg6: bool, arg7: &0x5572e96ecf75923178561fae85ae7bd86810574dab3a403e2a98e681d55fd10::pyth_oracle::Oracle, arg8: &0x2::clock::Clock) : u128 {
        let v0 = PositionKey{
            market_id : arg1,
            owner     : arg2,
        };
        let v1 = 0x2::table::borrow<u64, Market>(&arg0.markets, arg1);
        let (v2, v3) = accrue_borrow_totals_read_only(arg0, v1, arg1, arg8);
        let (v4, v5) = if (0x2::table::contains<PositionKey, Position>(&arg0.positions, v0)) {
            let v6 = 0x2::table::borrow<PositionKey, Position>(&arg0.positions, v0);
            (v6.borrow_shares, v6.collateral)
        } else {
            (0, 0)
        };
        let v7 = project_borrow_shares_after_change(v4, arg3, arg4, v2, v3);
        let v8 = if (arg6) {
            v5 + arg5
        } else if (v5 >= arg5) {
            v5 - arg5
        } else {
            0
        };
        if (v7 == 0) {
            return 340282366920938463463374607431768211455
        };
        let (v9, v10) = calculate_health_values(v1.base_token_decimals, v1.quote_token_decimals, v7, v2, v3, v8, read_oracle_price(arg7, v1.config.oracle_id, arg8), v1.config.lltv);
        if (v9 == 0) {
            return 340282366920938463463374607431768211455
        };
        0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::w_div_down(v10, v9)
    }

    public fun user_market_list(arg0: &Hearn, arg1: address) : vector<u64> {
        if (!0x2::table::contains<address, vector<u64>>(&arg0.user_market_ids, arg1)) {
            0x1::vector::empty<u64>()
        } else {
            *0x2::table::borrow<address, vector<u64>>(&arg0.user_market_ids, arg1)
        }
    }

    public fun user_max_borrow_assets_for_health_factor(arg0: &Hearn, arg1: u64, arg2: address, arg3: u128, arg4: bool, arg5: u128, arg6: &0x5572e96ecf75923178561fae85ae7bd86810574dab3a403e2a98e681d55fd10::pyth_oracle::Oracle, arg7: &0x2::clock::Clock) : (u128, u128) {
        assert!(0x2::table::contains<u64, Market>(&arg0.markets, arg1), 2);
        let v0 = PositionKey{
            market_id : arg1,
            owner     : arg2,
        };
        let v1 = 0x2::table::borrow<u64, Market>(&arg0.markets, arg1);
        let v2 = decimal_scale(v1.base_token_decimals);
        let v3 = decimal_scale(v1.quote_token_decimals);
        let (v4, v5) = if (0x2::table::contains<PositionKey, Position>(&arg0.positions, v0)) {
            let v6 = 0x2::table::borrow<PositionKey, Position>(&arg0.positions, v0);
            (v6.borrow_shares, v6.collateral)
        } else {
            (0, 0)
        };
        let v7 = if (arg4) {
            v5 + arg3
        } else if (v5 >= arg3) {
            v5 - arg3
        } else {
            0
        };
        if (arg5 == 0 || v7 == 0) {
            return (0, user_health_factor_after_change(arg0, arg1, arg2, 0, true, arg3, arg4, arg6, arg7))
        };
        let v8 = read_oracle_price(arg6, v1.config.oracle_id, arg7);
        let (v9, v10) = accrue_borrow_totals_read_only(arg0, v1, arg1, arg7);
        let v11 = 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::mul_div(v7, v8, 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::wad());
        if (v11 == 0) {
            return (0, user_health_factor_after_change(arg0, arg1, arg2, 0, true, arg3, arg4, arg6, arg7))
        };
        let v12 = 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::mul_div(v11, (v1.config.lltv as u128), v2);
        if (v12 == 0) {
            return (0, user_health_factor_after_change(arg0, arg1, arg2, 0, true, arg3, arg4, arg6, arg7))
        };
        let v13 = 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::w_div_down(v12, arg5);
        if (v13 == 0) {
            return (0, user_health_factor_after_change(arg0, arg1, arg2, 0, true, arg3, arg4, arg6, arg7))
        };
        let v14 = 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::mul_div_down(v13, v3, 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::wad());
        if (v14 == 0) {
            return (0, user_health_factor_after_change(arg0, arg1, arg2, 0, true, arg3, arg4, arg6, arg7))
        };
        if (0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::to_assets_up(v4, v9, v10) >= v14) {
            return (0, user_health_factor_after_change(arg0, arg1, arg2, 0, true, arg3, arg4, arg6, arg7))
        };
        let v15 = 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::to_shares_down(v14, v9, v10);
        if (v15 <= v4) {
            return (0, user_health_factor_after_change(arg0, arg1, arg2, 0, true, arg3, arg4, arg6, arg7))
        };
        let v16 = v15 - v4;
        let v17 = 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::to_assets_up(v16, v9, v10);
        let v18 = v17;
        if (v17 == 0) {
            return (0, user_health_factor_after_change(arg0, arg1, arg2, 0, true, arg3, arg4, arg6, arg7))
        };
        let v19 = market_available_liquidity(arg0, arg1);
        if (v17 > v19) {
            v18 = v19;
        };
        let v20 = 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::to_shares_up(v18, v9, v10);
        let v21 = v20;
        if (v20 > v16) {
            v21 = v16;
            v18 = 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::to_assets_up(v16, v9, v10);
        };
        if (user_health_factor_after_change(arg0, arg1, arg2, v18, true, arg3, arg4, arg6, arg7) < arg5 && v21 > 0) {
            v18 = 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::to_assets_up(v21 - 1, v9, v10);
        };
        (v18, user_health_factor_after_change(arg0, arg1, arg2, v18, true, arg3, arg4, arg6, arg7))
    }

    public fun user_max_borrowable(arg0: &Hearn, arg1: u64, arg2: address, arg3: &0x5572e96ecf75923178561fae85ae7bd86810574dab3a403e2a98e681d55fd10::pyth_oracle::Oracle, arg4: &0x2::clock::Clock) : u128 {
        assert!(0x2::table::contains<u64, Market>(&arg0.markets, arg1), 2);
        let v0 = 0x2::table::borrow<u64, Market>(&arg0.markets, arg1);
        max_borrowable_with_price_wad(arg0, v0, arg1, arg2, read_oracle_price(arg3, v0.config.oracle_id, arg4))
    }

    public fun user_max_withdrawable_collateral(arg0: &Hearn, arg1: u64, arg2: address, arg3: &0x5572e96ecf75923178561fae85ae7bd86810574dab3a403e2a98e681d55fd10::pyth_oracle::Oracle, arg4: &0x2::clock::Clock) : u128 {
        assert!(0x2::table::contains<u64, Market>(&arg0.markets, arg1), 2);
        let v0 = 0x2::table::borrow<u64, Market>(&arg0.markets, arg1);
        max_withdrawable_collateral_with_price_wad(arg0, v0, arg1, arg2, read_oracle_price(arg3, v0.config.oracle_id, arg4))
    }

    public fun user_min_collateral_for_health_factor(arg0: &Hearn, arg1: u64, arg2: address, arg3: u128, arg4: bool, arg5: u128, arg6: &0x5572e96ecf75923178561fae85ae7bd86810574dab3a403e2a98e681d55fd10::pyth_oracle::Oracle, arg7: &0x2::clock::Clock) : (u128, u128) {
        assert!(0x2::table::contains<u64, Market>(&arg0.markets, arg1), 2);
        let v0 = PositionKey{
            market_id : arg1,
            owner     : arg2,
        };
        let v1 = 0x2::table::borrow<u64, Market>(&arg0.markets, arg1);
        let v2 = decimal_scale(v1.base_token_decimals);
        let v3 = decimal_scale(v1.quote_token_decimals);
        let (v4, v5) = if (0x2::table::contains<PositionKey, Position>(&arg0.positions, v0)) {
            let v6 = 0x2::table::borrow<PositionKey, Position>(&arg0.positions, v0);
            (v6.borrow_shares, v6.collateral)
        } else {
            (0, 0)
        };
        let (v7, v8) = accrue_borrow_totals_read_only(arg0, v1, arg1, arg7);
        let v9 = project_borrow_shares_after_change(v4, arg3, arg4, v7, v8);
        if (v9 == 0) {
            return (0, 340282366920938463463374607431768211455)
        };
        let v10 = 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::mul_div(0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::to_assets_up(v9, v7, v8), 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::wad(), v3);
        let v11 = 0;
        if (v10 != 0 && arg5 != 0) {
            let v12 = 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::w_mul_up(v10, arg5);
            if (v12 != 0) {
                let v13 = 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::mul_div_up(v12, v2, (v1.config.lltv as u128));
                if (v13 != 0) {
                    let v14 = 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::mul_div_up(v13, 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::wad(), read_oracle_price(arg6, v1.config.oracle_id, arg7));
                    if (v14 > v5) {
                        v11 = v14 - v5;
                    };
                };
            };
        };
        (v11, user_health_factor_after_change(arg0, arg1, arg2, arg3, arg4, v11, true, arg6, arg7))
    }

    public fun user_position_borrow_assets(arg0: &Hearn, arg1: u64, arg2: address) : u128 {
        let v0 = user_position_borrow_shares(arg0, arg1, arg2);
        if (v0 == 0) {
            return 0
        };
        let v1 = 0x2::table::borrow<u64, Market>(&arg0.markets, arg1);
        0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::to_assets_up(v0, v1.total_borrow_assets, v1.total_borrow_shares)
    }

    public fun user_position_borrow_shares(arg0: &Hearn, arg1: u64, arg2: address) : u128 {
        let v0 = PositionKey{
            market_id : arg1,
            owner     : arg2,
        };
        if (!0x2::table::contains<PositionKey, Position>(&arg0.positions, v0)) {
            return 0
        };
        0x2::table::borrow<PositionKey, Position>(&arg0.positions, v0).borrow_shares
    }

    public fun user_position_collateral(arg0: &Hearn, arg1: u64, arg2: address) : u128 {
        let v0 = PositionKey{
            market_id : arg1,
            owner     : arg2,
        };
        if (!0x2::table::contains<PositionKey, Position>(&arg0.positions, v0)) {
            return 0
        };
        0x2::table::borrow<PositionKey, Position>(&arg0.positions, v0).collateral
    }

    public fun user_position_count(arg0: &Hearn, arg1: address) : u64 {
        if (!0x2::table::contains<address, u64>(&arg0.position_counts, arg1)) {
            0
        } else {
            *0x2::table::borrow<address, u64>(&arg0.position_counts, arg1)
        }
    }

    public fun user_position_info(arg0: &Hearn, arg1: u64, arg2: address, arg3: &0x5572e96ecf75923178561fae85ae7bd86810574dab3a403e2a98e681d55fd10::pyth_oracle::Oracle, arg4: &0x2::clock::Clock) : UserPositionInfo {
        assert!(0x2::table::contains<u64, Market>(&arg0.markets, arg1), 2);
        get_user_position_info_with_price(arg0, 0x2::table::borrow<u64, Market>(&arg0.markets, arg1), arg1, arg2, 0x5572e96ecf75923178561fae85ae7bd86810574dab3a403e2a98e681d55fd10::pyth_oracle::price(arg3, market_oracle_config_id(arg0, arg1), arg4))
    }

    public fun user_position_supply_assets(arg0: &Hearn, arg1: u64, arg2: address) : u128 {
        let v0 = user_position_supply_shares(arg0, arg1, arg2);
        if (v0 == 0) {
            return 0
        };
        let v1 = 0x2::table::borrow<u64, Market>(&arg0.markets, arg1);
        0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::to_assets_down(v0, v1.total_supply_assets, v1.total_supply_shares)
    }

    public fun user_position_supply_shares(arg0: &Hearn, arg1: u64, arg2: address) : u128 {
        let v0 = PositionKey{
            market_id : arg1,
            owner     : arg2,
        };
        if (!0x2::table::contains<PositionKey, Position>(&arg0.positions, v0)) {
            return 0
        };
        0x2::table::borrow<PositionKey, Position>(&arg0.positions, v0).supply_shares
    }

    public fun user_positions_batch(arg0: &Hearn, arg1: address) : vector<UserPositionInfo> {
        let v0 = user_market_list(arg0, arg1);
        let v1 = 0x1::vector::empty<UserPositionInfo>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&v0)) {
            let v3 = *0x1::vector::borrow<u64>(&v0, v2);
            let v4 = PositionKey{
                market_id : v3,
                owner     : arg1,
            };
            let (v5, v6, v7) = if (0x2::table::contains<PositionKey, Position>(&arg0.positions, v4)) {
                let v8 = 0x2::table::borrow<PositionKey, Position>(&arg0.positions, v4);
                (v8.collateral, v8.borrow_shares, v8.supply_shares)
            } else {
                (0, 0, 0)
            };
            let v9 = UserPositionInfo{
                market_id                   : v3,
                collateral                  : v5,
                borrow_shares               : v6,
                borrow_assets               : user_position_borrow_assets(arg0, v3, arg1),
                supply_shares               : v7,
                supply_assets               : user_position_supply_assets(arg0, v3, arg1),
                health_factor               : 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::wad(),
                withdrawable_assets         : user_withdrawable_assets(arg0, v3, arg1),
                max_borrowable              : 0,
                max_withdrawable_collateral : v5,
            };
            0x1::vector::push_back<UserPositionInfo>(&mut v1, v9);
            v2 = v2 + 1;
        };
        v1
    }

    public fun user_withdrawable_assets(arg0: &Hearn, arg1: u64, arg2: address) : u128 {
        let v0 = user_position_supply_assets(arg0, arg1, arg2);
        if (v0 == 0) {
            return 0
        };
        let v1 = market_available_liquidity(arg0, arg1);
        if (v0 < v1) {
            v0
        } else {
            v1
        }
    }

    public(friend) fun withdraw<T0>(arg0: &mut Hearn, arg1: u64, arg2: address, arg3: address, arg4: u128, arg5: u128, arg6: &0x2::clock::Clock, arg7: 0x1::option::Option<address>, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u128, u128) {
        assert_version(arg0);
        ensure_authorized_with_uid_proof(&arg0.authorizations, arg2, 0x2::tx_context::sender(arg8), &arg7);
        exactly_one_zero(arg4, arg5);
        let v0 = take_market(arg0, arg1);
        assert_withdraw_not_paused(arg0, &v0);
        ensure_market_loan_type<T0>(&v0);
        let v1 = &mut v0;
        let v2 = &mut arg0.irm;
        let v3 = &mut arg0.positions;
        let v4 = &mut arg0.position_counts;
        let v5 = &mut arg0.markets;
        let v6 = &mut arg0.user_market_ids;
        accrue_interest_internal(v1, v2, arg1, arg6, arg0.fee_recipient, v3, v4, v5, v6);
        let (v7, v8) = if (arg4 > 0) {
            (arg4, 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::to_shares_up(arg4, v0.total_supply_assets, v0.total_supply_shares))
        } else {
            (0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::to_assets_down(arg5, v0.total_supply_assets, v0.total_supply_shares), arg5)
        };
        let v9 = if (v0.total_supply_assets >= v0.total_borrow_assets) {
            v0.total_supply_assets - v0.total_borrow_assets
        } else {
            0
        };
        if (v7 > v9) {
            store_market(arg0, arg1, v0);
            abort 4
        };
        let v10 = &mut v0.reserves;
        let (v11, _) = take_reserve_or_zero<T0>(v10, 0, arg8);
        let v13 = v11;
        if (v7 > (0x2::coin::value<T0>(&v13) as u128)) {
            let v14 = &mut v0.reserves;
            store_reserve<T0>(v14, 0, v13);
            store_market(arg0, arg1, v0);
            abort 4
        };
        let v15 = if (v7 > 0) {
            let v16 = &mut v0.reserves;
            store_reserve<T0>(v16, 0, v13);
            0x2::coin::split<T0>(&mut v13, 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::to_u64(v7), arg8)
        } else {
            let v17 = &mut v0.reserves;
            store_reserve<T0>(v17, 0, v13);
            0x2::coin::zero<T0>(arg8)
        };
        let v18 = new_position_key(arg1, arg2);
        let v19 = &mut arg0.positions;
        let v20 = &mut arg0.position_counts;
        let v21 = &mut arg0.markets;
        let v22 = &mut arg0.user_market_ids;
        let (v23, v24) = borrow_position(v19, v20, v21, v22, v18);
        if (v24) {
            v0.open_position_count = v0.open_position_count + 1;
        };
        v23.supply_shares = v23.supply_shares - v8;
        v0.total_supply_assets = v0.total_supply_assets - v7;
        v0.total_supply_shares = v0.total_supply_shares - v8;
        store_market(arg0, arg1, v0);
        let v25 = &mut arg0.positions;
        let v26 = &mut arg0.position_counts;
        let v27 = &mut arg0.markets;
        let v28 = &mut arg0.user_market_ids;
        cleanup_position_if_empty(v25, v26, v27, v28, v18);
        0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::events::emit_withdraw(arg1, 0x2::tx_context::sender(arg8), arg2, arg3, v7, v8, v0.config.loan_token_type, v0.config.collateral_token_type);
        (v15, v7, v8)
    }

    public(friend) fun withdraw_collateral<T0, T1>(arg0: &mut Hearn, arg1: u64, arg2: address, arg3: address, arg4: u128, arg5: &0x2::clock::Clock, arg6: address, arg7: &0x5572e96ecf75923178561fae85ae7bd86810574dab3a403e2a98e681d55fd10::pyth_oracle::Oracle, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = read_oracle_price(arg7, market_oracle_id(&arg0.markets, arg1), arg5);
        withdraw_collateral_with_price<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v0, arg8)
    }

    fun withdraw_collateral_with_price<T0, T1>(arg0: &mut Hearn, arg1: u64, arg2: address, arg3: address, arg4: u128, arg5: &0x2::clock::Clock, arg6: address, arg7: u128, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_version(arg0);
        ensure_authorized(&arg0.authorizations, arg2, arg6);
        if (arg4 == 0) {
            abort 3
        };
        let v0 = take_market(arg0, arg1);
        assert_withdraw_collateral_not_paused(arg0, &v0);
        ensure_market_types<T0, T1>(&v0);
        let v1 = &mut v0;
        let v2 = &mut arg0.irm;
        let v3 = &mut arg0.positions;
        let v4 = &mut arg0.position_counts;
        let v5 = &mut arg0.markets;
        let v6 = &mut arg0.user_market_ids;
        accrue_interest_internal(v1, v2, arg1, arg5, arg0.fee_recipient, v3, v4, v5, v6);
        let v7 = new_position_key(arg1, arg2);
        let v8 = &mut arg0.positions;
        let v9 = &mut arg0.position_counts;
        let v10 = &mut arg0.markets;
        let v11 = &mut arg0.user_market_ids;
        let (v12, v13) = borrow_position(v8, v9, v10, v11, v7);
        if (v13) {
            v0.open_position_count = v0.open_position_count + 1;
        };
        if (arg4 > v12.collateral) {
            store_market(arg0, arg1, v0);
            abort 5
        };
        v12.collateral = v12.collateral - arg4;
        let v14 = &mut v0.reserves;
        let (v15, _) = take_reserve_or_zero<T1>(v14, 1, arg8);
        let v17 = v15;
        let v18 = &mut v0.reserves;
        store_reserve<T1>(v18, 1, v17);
        v0.total_collateral_assets = v0.total_collateral_assets - arg4;
        store_market(arg0, arg1, v0);
        assert!(is_healthy_internal(v0.base_token_decimals, v0.quote_token_decimals, v12.borrow_shares, v0.total_borrow_assets, v0.total_borrow_shares, v12.collateral, arg7, v0.config.lltv), 11);
        let v19 = &mut arg0.positions;
        let v20 = &mut arg0.position_counts;
        let v21 = &mut arg0.markets;
        let v22 = &mut arg0.user_market_ids;
        cleanup_position_if_empty(v19, v20, v21, v22, v7);
        0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::events::emit_withdraw_collateral(arg1, arg6, arg2, arg3, arg4, v0.config.loan_token_type, v0.config.collateral_token_type);
        0x2::coin::split<T1>(&mut v17, 0x5e98a5f6f808c598a7983f32f205630ba90bc5debd7f76da4c8bae9c9af28fc2::math::to_u64(arg4), arg8)
    }

    // decompiled from Move bytecode v6
}

