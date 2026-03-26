module 0xf245f480ded5111af849028b22261f0394df290e03c80726bee54ea5912acf30::trading_pair {
    struct PairInfo has drop, store {
        name: 0x1::string::String,
        base_token_type: 0x1::string::String,
        oracle_asset_id: 0x1::string::String,
        description: 0x1::string::String,
    }

    struct RiskParams has copy, drop, store {
        max_total_collateral: u256,
        max_position_collateral: u256,
        max_leverage: u256,
        max_user_collateral: u256,
        max_user_exposure: u256,
        max_user_positions: u64,
    }

    struct FeeConfig has copy, drop, store {
        open_fee_rate: u256,
        close_fee_rate: u256,
        vault_share_rate: u256,
    }

    struct LiquidationConfig has copy, drop, store {
        reward_rate: u256,
        min_reward: u256,
    }

    struct UserRiskState has copy, drop, store {
        user: address,
        active_collateral: u256,
        active_exposure: u256,
        active_positions: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
        pair_id: address,
    }

    struct GuardianCap has key {
        id: 0x2::object::UID,
        pair_id: address,
    }

    struct RiskCap has key {
        id: 0x2::object::UID,
        pair_id: address,
    }

    struct Position<phantom T0> has store, key {
        id: 0x2::object::UID,
        id_count: u256,
    }

    struct PositionInfo has copy, drop, store {
        id_count: u256,
        is_active: bool,
        opened_at: u64,
        closed_at: u64,
        claimable_balance: u256,
        collateral: u256,
        is_long: bool,
        leverage: u256,
        entry_price: u256,
        entry_psi: u256,
        liquidation_price: u256,
        n: u256,
    }

    struct LPPosition<phantom T0> has store, key {
        id: 0x2::object::UID,
        user: address,
        shares: u256,
        opened_at: u64,
    }

    struct TradingPair<phantom T0> has key {
        id: 0x2::object::UID,
        pair_info: PairInfo,
        total_positions_count: u256,
        total_collateral: 0x2::balance::Balance<T0>,
        total_shares: u256,
        total_long_positions: u256,
        total_short_positions: u256,
        sum_psi: u256,
        sum_psi_long: u256,
        sum_psi_short: u256,
        risk_params: RiskParams,
        fee_config: FeeConfig,
        liquidation_config: LiquidationConfig,
        position_infos: 0x2::table::Table<u256, PositionInfo>,
        position_risk_owners: 0x2::table::Table<u256, address>,
        user_risk_states: 0x2::table::Table<address, UserRiskState>,
        pending_claimable_total: u256,
        fee_balance: 0x2::balance::Balance<T0>,
        vault_fee_balance: 0x2::balance::Balance<T0>,
        is_paused: bool,
    }

    struct PositionOpened has copy, drop {
        pair_id: address,
        position_id: address,
        id_count: u256,
        user: address,
        executor: address,
        collateral: u256,
        leverage: u256,
        is_long: bool,
        entry_price: u256,
        entry_psi: u256,
    }

    struct PositionClosed has copy, drop {
        pair_id: address,
        position_id: address,
        id_count: u256,
        user: address,
        executor: address,
        position_value: u256,
        payout_due: u256,
        payout_paid: u256,
        payout_claimable: u256,
        close_fee_due: u256,
        close_fee_paid: u256,
        exit_price: u256,
        exit_psi: u256,
    }

    struct PositionLiquidated has copy, drop {
        pair_id: address,
        id_count: u256,
        owner: address,
        liquidator: address,
        position_value: u256,
        reward_due: u256,
        reward_paid_from_pool: u256,
        reward_paid_from_insurance: u256,
        insurance_refund: u256,
        liquidator_paid_total: u256,
        owner_claimable: u256,
        liquidate_price: u256,
        liquidate_psi: u256,
    }

    struct PositionClaimed has copy, drop {
        pair_id: address,
        position_id: address,
        id_count: u256,
        claimer: address,
        claimed_amount: u256,
        remaining_claimable: u256,
        pending_claimable_total_after: u256,
    }

    struct LiquidityProvided has copy, drop {
        pair_id: address,
        lp_position_id: address,
        provider: address,
        collateral: u256,
        shares_minted: u256,
        share_price: u256,
    }

    struct LiquidityWithdrawn has copy, drop {
        pair_id: address,
        lp_position_id: address,
        provider: address,
        shares_burned: u256,
        collateral_out: u256,
        share_price: u256,
    }

    struct FeeConfigUpdated has copy, drop {
        pair_id: address,
        open_fee_rate: u256,
        close_fee_rate: u256,
        vault_share_rate: u256,
    }

    struct LiquidationConfigUpdated has copy, drop {
        pair_id: address,
        reward_rate: u256,
        min_reward: u256,
    }

    struct TradingPairCreated has copy, drop {
        pair_id: address,
        creator: address,
    }

    struct PauseStateUpdated has copy, drop {
        pair_id: address,
        is_paused: bool,
    }

    struct RiskParamsUpdated has copy, drop {
        pair_id: address,
        max_total_collateral: u256,
        max_position_collateral: u256,
        max_leverage: u256,
        max_user_collateral: u256,
        max_user_exposure: u256,
        max_user_positions: u64,
    }

    struct VaultFeesDeposited has copy, drop {
        pair_id: address,
        vault_id: address,
        amount: u256,
        vault_fee_balance_after: u256,
    }

    public(friend) fun accumulated_fee_balance<T0>(arg0: &TradingPair<T0>) : u256 {
        (0x2::balance::value<T0>(&arg0.fee_balance) as u256)
    }

    public(friend) fun accumulated_vault_fee_balance<T0>(arg0: &TradingPair<T0>) : u256 {
        (0x2::balance::value<T0>(&arg0.vault_fee_balance) as u256)
    }

    public fun add_liquidity_to_position_ptb<T0>(arg0: &mut TradingPair<T0>, arg1: &mut LPPosition<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 1014);
        assert!(arg1.user == 0x2::tx_context::sender(arg3), 1018);
        let v0 = (0x2::coin::value<T0>(&arg2) as u256);
        assert!(v0 > 0, 1004);
        let v1 = calculate_minted_shares(v0, total_active_collateral<T0>(arg0), arg0.total_shares);
        0x2::balance::join<T0>(&mut arg0.total_collateral, 0x2::coin::into_balance<T0>(arg2));
        arg0.total_shares = arg0.total_shares + v1;
        arg1.shares = arg1.shares + v1;
        let v2 = LiquidityProvided{
            pair_id        : 0x2::object::id_address<TradingPair<T0>>(arg0),
            lp_position_id : 0x2::object::id_address<LPPosition<T0>>(arg1),
            provider       : arg1.user,
            collateral     : v0,
            shares_minted  : v1,
            share_price    : calculate_share_price_from_state(total_active_collateral<T0>(arg0), arg0.total_shares),
        };
        0x2::event::emit<LiquidityProvided>(v2);
    }

    fun append_bytes(arg0: &mut vector<u8>, arg1: &vector<u8>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg1)) {
            0x1::vector::push_back<u8>(arg0, *0x1::vector::borrow<u8>(arg1, v0));
            v0 = v0 + 1;
        };
    }

    fun assert_cap_matches_pair(arg0: address, arg1: address) {
        assert!(arg0 == arg1, 1013);
    }

    fun assert_withdrawal_respects_claimable<T0>(arg0: &TradingPair<T0>, arg1: u256) {
        assert!((0x2::balance::value<T0>(&arg0.total_collateral) as u256) - arg1 >= arg0.pending_claimable_total, 1026);
    }

    fun build_fee_config(arg0: u256, arg1: u256, arg2: u256) : FeeConfig {
        assert!(arg0 <= 1000000000000000000, 1019);
        assert!(arg1 <= 1000000000000000000, 1019);
        assert!(arg2 <= 1000000000000000000, 1019);
        FeeConfig{
            open_fee_rate    : arg0,
            close_fee_rate   : arg1,
            vault_share_rate : arg2,
        }
    }

    fun build_liquidation_config(arg0: u256, arg1: u256) : LiquidationConfig {
        assert!(arg0 <= 1000000000000000000, 1020);
        assert!(arg1 <= 18446744073709551615, 1022);
        LiquidationConfig{
            reward_rate : arg0,
            min_reward  : arg1,
        }
    }

    fun build_market_name(arg0: &0x1::string::String, arg1: &0x1::string::String, arg2: &0x1::string::String) : 0x1::string::String {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        append_bytes(v1, 0x1::string::as_bytes(arg0));
        0x1::vector::push_back<u8>(&mut v0, 45);
        let v2 = extract_type_symbol_bytes(arg1);
        let v3 = &mut v0;
        append_bytes(v3, &v2);
        if (0x1::vector::length<u8>(0x1::string::as_bytes(arg2)) > 0) {
            0x1::vector::push_back<u8>(&mut v0, 45);
            let v4 = &mut v0;
            append_bytes(v4, 0x1::string::as_bytes(arg2));
        };
        0x1::string::utf8(v0)
    }

    fun build_pair_info<T0>(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String) : PairInfo {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()));
        PairInfo{
            name            : build_market_name(&arg0, &v0, &arg2),
            base_token_type : v0,
            oracle_asset_id : arg0,
            description     : arg1,
        }
    }

    fun build_risk_params(arg0: u256, arg1: u256, arg2: u256, arg3: u256, arg4: u256, arg5: u64) : RiskParams {
        assert!(arg0 > 0, 1012);
        assert!(arg1 > 0, 1012);
        assert!(arg2 > 0, 1012);
        assert!(arg3 > 0, 1012);
        assert!(arg4 > 0, 1012);
        assert!(arg5 > 0, 1012);
        assert!(arg1 <= arg0, 1012);
        assert!(arg3 <= arg0, 1012);
        RiskParams{
            max_total_collateral    : arg0,
            max_position_collateral : arg1,
            max_leverage            : arg2,
            max_user_collateral     : arg3,
            max_user_exposure       : arg4,
            max_user_positions      : arg5,
        }
    }

    fun calculate_fee_amount(arg0: u256, arg1: u256) : u256 {
        arg0 * arg1 / 1000000000000000000
    }

    fun calculate_liquidation_distance_health_rate_from_info(arg0: &PositionInfo, arg1: u256) : u256 {
        let v0 = arg0.liquidation_price;
        if (v0 == 0) {
            return 1000000000000000000
        };
        if (arg0.is_long) {
            if (arg1 <= v0) {
                return 0
            };
            let v2 = arg0.entry_price - v0;
            if (v2 == 0) {
                return 0
            };
            let v3 = arg1 - v0;
            if (v3 >= v2) {
                return 1000000000000000000
            };
            v3 * 1000000000000000000 / v2
        } else {
            if (arg1 >= v0) {
                return 0
            };
            let v4 = v0 - arg0.entry_price;
            if (v4 == 0) {
                return 0
            };
            let v5 = v0 - arg1;
            if (v5 >= v4) {
                return 1000000000000000000
            };
            v5 * 1000000000000000000 / v4
        }
    }

    public(friend) fun calculate_liquidation_price(arg0: u256, arg1: bool, arg2: u256) : u256 {
        if (arg2 == 0) {
            return 0
        };
        if (arg1 && arg2 <= 1000000000000000000) {
            return 0
        };
        if (arg1) {
            arg0 * (800000000000000000 + arg2 - 1000000000000000000) / arg2
        } else {
            arg0 * (arg2 + 1000000000000000000 - 800000000000000000) / arg2
        }
    }

    public(friend) fun calculate_lp_position_value<T0>(arg0: &TradingPair<T0>, arg1: &LPPosition<T0>) : u256 {
        if (arg0.total_shares == 0) {
            return 0
        };
        arg1.shares * total_active_collateral<T0>(arg0) / arg0.total_shares
    }

    fun calculate_minted_shares(arg0: u256, arg1: u256, arg2: u256) : u256 {
        if (arg2 == 0 || arg1 == 0) {
            return arg0 * 1000000000000000000
        };
        arg0 * arg2 / arg1
    }

    fun calculate_position_exposure(arg0: u256, arg1: u256) : u256 {
        arg0 * arg1 / 1000000000000000000
    }

    public(friend) fun calculate_position_n(arg0: u256, arg1: u256, arg2: u256) : u256 {
        assert!(arg2 > 0, 1002);
        if (arg1 == 0) {
            return 0
        };
        arg0 * arg1 * 1000000000000000000 / arg2
    }

    public(friend) fun calculate_position_value<T0>(arg0: &TradingPair<T0>, arg1: &Position<T0>, arg2: u256, arg3: u256) : u256 {
        let (v0, v1) = calculate_position_value_signed<T0>(arg0, arg1, arg2, arg3);
        if (v0) {
            return 0
        };
        v1
    }

    fun calculate_position_value_from_info(arg0: &PositionInfo, arg1: u256, arg2: u256) : u256 {
        let (v0, v1) = calculate_position_value_signed_from_info(arg0, arg1, arg2);
        if (v0) {
            return 0
        };
        v1
    }

    fun calculate_position_value_raw_signed_from_info(arg0: &PositionInfo, arg1: u256) : (bool, u256) {
        let v0 = arg0.collateral;
        let v1 = arg0.leverage;
        if (v1 == 0) {
            return (false, v0)
        };
        let (v2, v3) = if (arg0.is_long) {
            (v0 * v1, v0 * 1000000000000000000 + arg0.n * arg1 / 1000000000000000000)
        } else {
            (arg0.n * arg1 / 1000000000000000000, v0 * (v1 + 1000000000000000000))
        };
        if (v3 <= v2) {
            return (true, (v2 - v3) / 1000000000000000000)
        };
        (false, (v3 - v2) / 1000000000000000000)
    }

    public(friend) fun calculate_position_value_signed<T0>(arg0: &TradingPair<T0>, arg1: &Position<T0>, arg2: u256, arg3: u256) : (bool, u256) {
        let v0 = arg1.id_count;
        if (!0x2::table::contains<u256, PositionInfo>(&arg0.position_infos, v0)) {
            return (false, 0)
        };
        let v1 = 0x2::table::borrow<u256, PositionInfo>(&arg0.position_infos, v0);
        if (v1.collateral == 0) {
            return (false, 0)
        };
        let (v2, v3) = calculate_position_value_raw_signed_from_info(v1, arg2);
        if (v3 == 0) {
            return (false, 0)
        };
        (v2, v3 * v1.entry_psi / arg3)
    }

    fun calculate_position_value_signed_from_info(arg0: &PositionInfo, arg1: u256, arg2: u256) : (bool, u256) {
        if (arg0.collateral == 0) {
            return (false, 0)
        };
        let (v0, v1) = calculate_position_value_raw_signed_from_info(arg0, arg1);
        if (v1 == 0) {
            return (false, 0)
        };
        (v0, v1 * arg0.entry_psi / arg2)
    }

    fun calculate_share_price_from_state(arg0: u256, arg1: u256) : u256 {
        if (arg1 == 0) {
            return 1000000000000000000
        };
        arg0 * 1000000000000000000 / arg1
    }

    fun calculate_withdraw_collateral(arg0: u256, arg1: u256, arg2: u256) : u256 {
        assert!(arg2 > 0, 1016);
        arg0 * arg1 / arg2
    }

    fun check_risk_on_open<T0>(arg0: &TradingPair<T0>, arg1: address, arg2: u256, arg3: u256) {
        let v0 = arg0.risk_params;
        assert!(arg2 <= v0.max_position_collateral, 1005);
        assert!(arg3 <= v0.max_leverage, 1006);
        assert!((0x2::balance::value<T0>(&arg0.total_collateral) as u256) + arg2 <= v0.max_total_collateral, 1007);
        if (!0x2::table::contains<address, UserRiskState>(&arg0.user_risk_states, arg1)) {
            assert!(arg2 <= v0.max_user_collateral, 1008);
            assert!(calculate_position_exposure(arg2, arg3) <= v0.max_user_exposure, 1009);
            assert!(1 <= v0.max_user_positions, 1010);
            return
        };
        let v1 = 0x2::table::borrow<address, UserRiskState>(&arg0.user_risk_states, arg1);
        assert!(v1.active_collateral + arg2 <= v0.max_user_collateral, 1008);
        assert!(v1.active_exposure + calculate_position_exposure(arg2, arg3) <= v0.max_user_exposure, 1009);
        assert!(v1.active_positions + 1 <= v0.max_user_positions, 1010);
    }

    public fun claim_position_balance<T0>(arg0: &mut TradingPair<T0>, arg1: &Position<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(claim_position_balance_ptb<T0>(arg0, arg1, arg2), v0);
    }

    public fun claim_position_balance_ptb<T0>(arg0: &mut TradingPair<T0>, arg1: &Position<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = arg1.id_count;
        assert!(0x2::table::contains<u256, PositionInfo>(&arg0.position_infos, v0), 1021);
        let v1 = 0x2::table::borrow_mut<u256, PositionInfo>(&mut arg0.position_infos, v0);
        let v2 = v1.claimable_balance;
        if (v2 == 0) {
            return 0x2::coin::from_balance<T0>(0x2::balance::zero<T0>(), arg2)
        };
        let v3 = (0x2::balance::value<T0>(&arg0.total_collateral) as u256);
        let v4 = if (v2 > v3) {
            v3
        } else {
            v2
        };
        if (v4 == 0) {
            return 0x2::coin::from_balance<T0>(0x2::balance::zero<T0>(), arg2)
        };
        v1.claimable_balance = v2 - v4;
        arg0.pending_claimable_total = arg0.pending_claimable_total - v4;
        let v5 = PositionClaimed{
            pair_id                       : 0x2::object::id_address<TradingPair<T0>>(arg0),
            position_id                   : 0x2::object::id_address<Position<T0>>(arg1),
            id_count                      : v0,
            claimer                       : 0x2::tx_context::sender(arg2),
            claimed_amount                : v4,
            remaining_claimable           : v1.claimable_balance,
            pending_claimable_total_after : arg0.pending_claimable_total,
        };
        0x2::event::emit<PositionClaimed>(v5);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.total_collateral, to_u64(v4)), arg2)
    }

    public(friend) fun close_fee_rate<T0>(arg0: &TradingPair<T0>) : u256 {
        arg0.fee_config.close_fee_rate
    }

    public fun close_position<T0>(arg0: &mut TradingPair<T0>, arg1: &Position<T0>, arg2: &0xf245f480ded5111af849028b22261f0394df290e03c80726bee54ea5912acf30::p2_oracle::Oracle, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(close_position_ptb<T0>(arg0, arg1, arg2, arg3, arg4), v0);
    }

    public fun close_position_ptb<T0>(arg0: &mut TradingPair<T0>, arg1: &Position<T0>, arg2: &0xf245f480ded5111af849028b22261f0394df290e03c80726bee54ea5912acf30::p2_oracle::Oracle, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(!arg0.is_paused, 1014);
        let v0 = 0xf245f480ded5111af849028b22261f0394df290e03c80726bee54ea5912acf30::p2_oracle::get_current_price(arg2, arg0.pair_info.oracle_asset_id, arg3);
        close_position_ptb_with_price_and_discount_rate<T0>(arg0, arg1, v0, 0x2::clock::timestamp_ms(arg3), 0, arg4)
    }

    public(friend) fun close_position_ptb_with_price<T0>(arg0: &mut TradingPair<T0>, arg1: &Position<T0>, arg2: u256, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        close_position_ptb_with_price_and_discount_rate<T0>(arg0, arg1, arg2, arg3, 0, arg4)
    }

    fun close_position_ptb_with_price_and_discount_rate<T0>(arg0: &mut TradingPair<T0>, arg1: &Position<T0>, arg2: u256, arg3: u64, arg4: u256, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = arg1.id_count;
        assert!(0x2::table::contains<u256, PositionInfo>(&arg0.position_infos, v0), 1021);
        let v1 = *0x2::table::borrow<u256, PositionInfo>(&arg0.position_infos, v0);
        assert!(v1.is_active, 1001);
        let v2 = compute_psi<T0>(arg0, arg2);
        let v3 = calculate_position_value_from_info(&v1, arg2, v2);
        let v4 = v1.collateral;
        let v5 = v1.leverage;
        let v6 = v1.entry_psi;
        assert!(0x2::table::contains<u256, address>(&arg0.position_risk_owners, v0), 1023);
        let v7 = 0x2::table::remove<u256, address>(&mut arg0.position_risk_owners, v0);
        arg0.sum_psi = arg0.sum_psi - v4 * v6;
        if (v1.is_long) {
            arg0.total_long_positions = arg0.total_long_positions - 1;
            arg0.sum_psi_long = arg0.sum_psi_long - v4 * v5 * v6 / 1000000000000000000;
        } else {
            arg0.total_short_positions = arg0.total_short_positions - 1;
            arg0.sum_psi_short = arg0.sum_psi_short - v4 * v5 * v6 / 1000000000000000000;
        };
        decrease_user_risk_state<T0>(arg0, v7, v4, calculate_position_exposure(v4, v5));
        let v8 = calculate_fee_amount(v3, 0xf245f480ded5111af849028b22261f0394df290e03c80726bee54ea5912acf30::fee_discount::apply_discount(arg0.fee_config.close_fee_rate, arg4));
        let v9 = v3 - v8;
        let v10 = (0x2::balance::value<T0>(&arg0.total_collateral) as u256);
        let v11 = if (v9 > v10) {
            v10
        } else {
            v9
        };
        let v12 = to_u64(v11);
        let v13 = if (v12 > 0) {
            0x2::balance::split<T0>(&mut arg0.total_collateral, v12)
        } else {
            0x2::balance::zero<T0>()
        };
        let v14 = (0x2::balance::value<T0>(&arg0.total_collateral) as u256);
        let v15 = if (v8 > v14) {
            v14
        } else {
            v8
        };
        let v16 = to_u64(v15);
        if (v16 > 0) {
            let v17 = 0x2::balance::split<T0>(&mut arg0.total_collateral, v16);
            let v18 = to_u64(calculate_fee_amount(v15, arg0.fee_config.vault_share_rate));
            if (v18 > 0) {
                0x2::balance::join<T0>(&mut arg0.vault_fee_balance, 0x2::balance::split<T0>(&mut v17, v18));
            };
            0x2::balance::join<T0>(&mut arg0.fee_balance, v17);
        };
        let v19 = 0x2::table::borrow_mut<u256, PositionInfo>(&mut arg0.position_infos, v0);
        v19.is_active = false;
        v19.closed_at = arg3;
        let v20 = PositionClosed{
            pair_id          : 0x2::object::id_address<TradingPair<T0>>(arg0),
            position_id      : 0x2::object::id_address<Position<T0>>(arg1),
            id_count         : arg1.id_count,
            user             : v7,
            executor         : 0x2::tx_context::sender(arg5),
            position_value   : v3,
            payout_due       : v9,
            payout_paid      : v11,
            payout_claimable : 0,
            close_fee_due    : v8,
            close_fee_paid   : v15,
            exit_price       : arg2,
            exit_psi         : v2,
        };
        0x2::event::emit<PositionClosed>(v20);
        0x2::coin::from_balance<T0>(v13, arg5)
    }

    public fun close_position_ptb_with_stake<T0>(arg0: &mut TradingPair<T0>, arg1: &Position<T0>, arg2: &0xf245f480ded5111af849028b22261f0394df290e03c80726bee54ea5912acf30::taco_staking::StakePool, arg3: &0xf245f480ded5111af849028b22261f0394df290e03c80726bee54ea5912acf30::taco_staking::StakePosition, arg4: &0xf245f480ded5111af849028b22261f0394df290e03c80726bee54ea5912acf30::p2_oracle::Oracle, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(!arg0.is_paused, 1014);
        let v0 = 0xf245f480ded5111af849028b22261f0394df290e03c80726bee54ea5912acf30::p2_oracle::get_current_price(arg4, arg0.pair_info.oracle_asset_id, arg5);
        let v1 = 0xf245f480ded5111af849028b22261f0394df290e03c80726bee54ea5912acf30::fee_discount::discount_rate_from_stake_position(arg2, arg3, arg5, 0x2::tx_context::sender(arg6));
        close_position_ptb_with_price_and_discount_rate<T0>(arg0, arg1, v0, 0x2::clock::timestamp_ms(arg5), v1, arg6)
    }

    public fun close_position_with_stake<T0>(arg0: &mut TradingPair<T0>, arg1: &Position<T0>, arg2: &0xf245f480ded5111af849028b22261f0394df290e03c80726bee54ea5912acf30::taco_staking::StakePool, arg3: &0xf245f480ded5111af849028b22261f0394df290e03c80726bee54ea5912acf30::taco_staking::StakePosition, arg4: &0xf245f480ded5111af849028b22261f0394df290e03c80726bee54ea5912acf30::p2_oracle::Oracle, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(close_position_ptb_with_stake<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6), v0);
    }

    public(friend) fun compute_psi<T0>(arg0: &TradingPair<T0>, arg1: u256) : u256 {
        let v0 = (0x2::balance::value<T0>(&arg0.total_collateral) as u256);
        if (arg0.pending_claimable_total >= v0) {
            return 1000000000000000000
        };
        let v1 = v0 - arg0.pending_claimable_total;
        if (v1 == 0) {
            return 1000000000000000000
        };
        let v2 = arg0.sum_psi + arg0.sum_psi_short + arg0.sum_psi_long * arg1 / 1000000000000000000;
        let v3 = arg0.sum_psi_long + arg0.sum_psi_short * arg1 / 1000000000000000000;
        if (v2 <= v3) {
            return 1000000000000000000
        };
        (v2 - v3 + v1 - 1) / v1
    }

    public fun create_trading_pair<T0>(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u256, arg4: u256, arg5: u256, arg6: u256, arg7: u256, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = create_trading_pair_with_risk_params<T0>(build_pair_info<T0>(arg1, arg2, arg0), build_risk_params(arg3, arg4, arg5, arg6, arg7, arg8), arg9);
        let v1 = 0x2::object::id_address<TradingPair<T0>>(&v0);
        let v2 = 0x2::tx_context::sender(arg9);
        let v3 = TradingPairCreated{
            pair_id : v1,
            creator : v2,
        };
        0x2::event::emit<TradingPairCreated>(v3);
        let v4 = AdminCap{
            id      : 0x2::object::new(arg9),
            pair_id : v1,
        };
        0x2::transfer::transfer<AdminCap>(v4, v2);
        let v5 = GuardianCap{
            id      : 0x2::object::new(arg9),
            pair_id : v1,
        };
        0x2::transfer::transfer<GuardianCap>(v5, v2);
        let v6 = RiskCap{
            id      : 0x2::object::new(arg9),
            pair_id : v1,
        };
        0x2::transfer::transfer<RiskCap>(v6, v2);
        0x2::transfer::share_object<TradingPair<T0>>(v0);
    }

    fun create_trading_pair_with_risk_params<T0>(arg0: PairInfo, arg1: RiskParams, arg2: &mut 0x2::tx_context::TxContext) : TradingPair<T0> {
        TradingPair<T0>{
            id                      : 0x2::object::new(arg2),
            pair_info               : arg0,
            total_positions_count   : 0,
            total_collateral        : 0x2::balance::zero<T0>(),
            total_shares            : 0,
            total_long_positions    : 0,
            total_short_positions   : 0,
            sum_psi                 : 0,
            sum_psi_long            : 0,
            sum_psi_short           : 0,
            risk_params             : arg1,
            fee_config              : default_fee_config(),
            liquidation_config      : default_liquidation_config(),
            position_infos          : 0x2::table::new<u256, PositionInfo>(arg2),
            position_risk_owners    : 0x2::table::new<u256, address>(arg2),
            user_risk_states        : 0x2::table::new<address, UserRiskState>(arg2),
            pending_claimable_total : 0,
            fee_balance             : 0x2::balance::zero<T0>(),
            vault_fee_balance       : 0x2::balance::zero<T0>(),
            is_paused               : false,
        }
    }

    fun decrease_user_risk_state<T0>(arg0: &mut TradingPair<T0>, arg1: address, arg2: u256, arg3: u256) {
        assert!(0x2::table::contains<address, UserRiskState>(&arg0.user_risk_states, arg1), 1011);
        let v0 = 0x2::table::borrow_mut<address, UserRiskState>(&mut arg0.user_risk_states, arg1);
        v0.active_collateral = v0.active_collateral - arg2;
        v0.active_exposure = v0.active_exposure - arg3;
        v0.active_positions = v0.active_positions - 1;
        if (v0.active_positions == 0) {
            let v1 = 0x2::table::remove<address, UserRiskState>(&mut arg0.user_risk_states, arg1);
            assert!(v1.active_collateral == 0, 1011);
            assert!(v1.active_exposure == 0, 1011);
        };
    }

    fun default_fee_config() : FeeConfig {
        FeeConfig{
            open_fee_rate    : 0,
            close_fee_rate   : 0,
            vault_share_rate : 0,
        }
    }

    fun default_liquidation_config() : LiquidationConfig {
        build_liquidation_config(10000000000000000, 0)
    }

    fun default_risk_params() : RiskParams {
        RiskParams{
            max_total_collateral    : 1000000000000000000000000000,
            max_position_collateral : 1000000000000000000000000000,
            max_leverage            : 100 * 1000000000000000000,
            max_user_collateral     : 1000000000000000000000000000,
            max_user_exposure       : 1000000000000000000000000000,
            max_user_positions      : 1000000,
        }
    }

    public fun deposit_vault_fees<T0>(arg0: &mut TradingPair<T0>, arg1: &AdminCap, arg2: &mut 0xf245f480ded5111af849028b22261f0394df290e03c80726bee54ea5912acf30::fee_vault::FeeVault<T0>) {
        assert_cap_matches_pair(0x2::object::id_address<TradingPair<T0>>(arg0), arg1.pair_id);
        let v0 = 0x2::balance::value<T0>(&arg0.vault_fee_balance);
        if (v0 == 0) {
            return
        };
        0xf245f480ded5111af849028b22261f0394df290e03c80726bee54ea5912acf30::fee_vault::deposit_rewards_balance<T0>(arg2, 0x2::balance::split<T0>(&mut arg0.vault_fee_balance, v0));
        let v1 = VaultFeesDeposited{
            pair_id                 : 0x2::object::id_address<TradingPair<T0>>(arg0),
            vault_id                : 0x2::object::id_address<0xf245f480ded5111af849028b22261f0394df290e03c80726bee54ea5912acf30::fee_vault::FeeVault<T0>>(arg2),
            amount                  : (v0 as u256),
            vault_fee_balance_after : (0x2::balance::value<T0>(&arg0.vault_fee_balance) as u256),
        };
        0x2::event::emit<VaultFeesDeposited>(v1);
    }

    public(friend) fun destroy_position_if_settled<T0>(arg0: &TradingPair<T0>, arg1: Position<T0>) {
        let v0 = arg1.id_count;
        assert!(0x2::table::contains<u256, PositionInfo>(&arg0.position_infos, v0), 1021);
        let v1 = 0x2::table::borrow<u256, PositionInfo>(&arg0.position_infos, v0);
        assert!(!v1.is_active, 1001);
        assert!(v1.claimable_balance == 0, 1025);
        let Position {
            id       : v2,
            id_count : _,
        } = arg1;
        0x2::object::delete(v2);
    }

    public(friend) fun entry_psi<T0>(arg0: &TradingPair<T0>, arg1: &Position<T0>) : u256 {
        let v0 = arg1.id_count;
        if (!0x2::table::contains<u256, PositionInfo>(&arg0.position_infos, v0)) {
            return 0
        };
        0x2::table::borrow<u256, PositionInfo>(&arg0.position_infos, v0).entry_psi
    }

    fun extract_type_symbol_bytes(arg0: &0x1::string::String) : vector<u8> {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = 0x1::vector::length<u8>(v0);
        let v2 = 0;
        let v3 = 0;
        while (v3 + 1 < v1) {
            if (*0x1::vector::borrow<u8>(v0, v3) == 58 && *0x1::vector::borrow<u8>(v0, v3 + 1) == 58) {
                v2 = v3 + 2;
                v3 = v3 + 1;
            };
            v3 = v3 + 1;
        };
        let v4 = 0x1::vector::empty<u8>();
        let v5 = v2;
        while (v5 < v1) {
            0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(v0, v5));
            v5 = v5 + 1;
        };
        v4
    }

    fun increase_user_risk_state<T0>(arg0: &mut TradingPair<T0>, arg1: address, arg2: u256, arg3: u256) {
        if (!0x2::table::contains<address, UserRiskState>(&arg0.user_risk_states, arg1)) {
            let v0 = UserRiskState{
                user              : arg1,
                active_collateral : arg2,
                active_exposure   : arg3,
                active_positions  : 1,
            };
            0x2::table::add<address, UserRiskState>(&mut arg0.user_risk_states, arg1, v0);
            return
        };
        let v1 = 0x2::table::borrow_mut<address, UserRiskState>(&mut arg0.user_risk_states, arg1);
        v1.active_collateral = v1.active_collateral + arg2;
        v1.active_exposure = v1.active_exposure + arg3;
        v1.active_positions = v1.active_positions + 1;
    }

    public(friend) fun is_paused<T0>(arg0: &TradingPair<T0>) : bool {
        arg0.is_paused
    }

    public(friend) fun is_position_liquidatable<T0>(arg0: &TradingPair<T0>, arg1: u256, arg2: u256) : bool {
        if (!0x2::table::contains<u256, PositionInfo>(&arg0.position_infos, arg1)) {
            return false
        };
        let v0 = 0x2::table::borrow<u256, PositionInfo>(&arg0.position_infos, arg1);
        if (!v0.is_active) {
            return false
        };
        is_position_liquidatable_from_info(v0, arg2, compute_psi<T0>(arg0, arg2))
    }

    fun is_position_liquidatable_from_info(arg0: &PositionInfo, arg1: u256, arg2: u256) : bool {
        if (calculate_liquidation_distance_health_rate_from_info(arg0, arg1) == 0) {
            return true
        };
        let (v0, v1) = calculate_position_value_signed_from_info(arg0, arg1, arg2);
        if (v0) {
            return true
        };
        v1 < arg0.collateral * 800000000000000000 / 1000000000000000000
    }

    public fun liquidate_position<T0>(arg0: &mut TradingPair<T0>, arg1: u256, arg2: 0x2::coin::Coin<T0>, arg3: &0xf245f480ded5111af849028b22261f0394df290e03c80726bee54ea5912acf30::p2_oracle::Oracle, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(liquidate_position_ptb<T0>(arg0, arg1, arg2, arg3, arg4, arg5), v0);
    }

    public fun liquidate_position_ptb<T0>(arg0: &mut TradingPair<T0>, arg1: u256, arg2: 0x2::coin::Coin<T0>, arg3: &0xf245f480ded5111af849028b22261f0394df290e03c80726bee54ea5912acf30::p2_oracle::Oracle, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(!arg0.is_paused, 1014);
        let v0 = 0xf245f480ded5111af849028b22261f0394df290e03c80726bee54ea5912acf30::p2_oracle::get_current_price(arg3, arg0.pair_info.oracle_asset_id, arg4);
        liquidate_position_ptb_with_price_and_insurance_balance<T0>(arg0, arg1, v0, 0x2::clock::timestamp_ms(arg4), 0x2::coin::into_balance<T0>(arg2), arg5)
    }

    public(friend) fun liquidate_position_ptb_with_price<T0>(arg0: &mut TradingPair<T0>, arg1: u256, arg2: u256, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        liquidate_position_ptb_with_price_and_insurance_balance<T0>(arg0, arg1, arg2, arg3, 0x2::balance::zero<T0>(), arg4)
    }

    fun liquidate_position_ptb_with_price_and_insurance_balance<T0>(arg0: &mut TradingPair<T0>, arg1: u256, arg2: u256, arg3: u64, arg4: 0x2::balance::Balance<T0>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::table::contains<u256, PositionInfo>(&arg0.position_infos, arg1), 1021);
        let v0 = *0x2::table::borrow<u256, PositionInfo>(&arg0.position_infos, arg1);
        assert!(v0.is_active, 1001);
        let v1 = compute_psi<T0>(arg0, arg2);
        let (v2, v3) = calculate_position_value_signed_from_info(&v0, arg2, v1);
        let v4 = if (v2) {
            0
        } else {
            v3
        };
        assert!(is_position_liquidatable_from_info(&v0, arg2, v1), 1015);
        let v5 = v0.collateral;
        let v6 = v0.leverage;
        let v7 = v0.entry_psi;
        assert!(0x2::table::contains<u256, address>(&arg0.position_risk_owners, arg1), 1023);
        let v8 = 0x2::table::remove<u256, address>(&mut arg0.position_risk_owners, arg1);
        arg0.sum_psi = arg0.sum_psi - v5 * v7;
        if (v0.is_long) {
            arg0.total_long_positions = arg0.total_long_positions - 1;
            arg0.sum_psi_long = arg0.sum_psi_long - v5 * v6 * v7 / 1000000000000000000;
        } else {
            arg0.total_short_positions = arg0.total_short_positions - 1;
            arg0.sum_psi_short = arg0.sum_psi_short - v5 * v6 * v7 / 1000000000000000000;
        };
        decrease_user_risk_state<T0>(arg0, v8, v5, calculate_position_exposure(v5, v6));
        let v9 = (0x2::balance::value<T0>(&arg0.total_collateral) as u256);
        let v10 = if (v4 > v9) {
            v9
        } else {
            v4
        };
        let v11 = calculate_fee_amount(v10, arg0.liquidation_config.reward_rate);
        let v12 = if (v11 > arg0.liquidation_config.min_reward) {
            v11
        } else {
            arg0.liquidation_config.min_reward
        };
        let v13 = if (v10 > v12) {
            v12
        } else {
            v10
        };
        let v14 = v12 - v13;
        let v15 = to_u64(v14);
        assert!(0x2::balance::value<T0>(&arg4) >= v15, 1024);
        let v16 = to_u64(v13);
        let v17 = if (v16 > 0) {
            0x2::balance::split<T0>(&mut arg0.total_collateral, v16)
        } else {
            0x2::balance::zero<T0>()
        };
        let v18 = v17;
        let v19 = v10 - v13;
        let v20 = to_u64(v19);
        let v21 = if (v20 > 0) {
            0x2::balance::split<T0>(&mut arg0.total_collateral, v20)
        } else {
            0x2::balance::zero<T0>()
        };
        if (v15 > 0) {
            0x2::balance::join<T0>(&mut v18, 0x2::balance::split<T0>(&mut arg4, v15));
        };
        let v22 = (0x2::balance::value<T0>(&arg4) as u256);
        0x2::balance::join<T0>(&mut v18, arg4);
        let v23 = 0x2::table::borrow_mut<u256, PositionInfo>(&mut arg0.position_infos, arg1);
        v23.is_active = false;
        v23.closed_at = arg3;
        v23.claimable_balance = v23.claimable_balance + v19;
        arg0.pending_claimable_total = arg0.pending_claimable_total + v19;
        let v24 = PositionLiquidated{
            pair_id                    : 0x2::object::id_address<TradingPair<T0>>(arg0),
            id_count                   : v0.id_count,
            owner                      : v8,
            liquidator                 : 0x2::tx_context::sender(arg5),
            position_value             : v10,
            reward_due                 : v12,
            reward_paid_from_pool      : v13,
            reward_paid_from_insurance : v14,
            insurance_refund           : v22,
            liquidator_paid_total      : v13 + v14 + v22,
            owner_claimable            : v19,
            liquidate_price            : arg2,
            liquidate_psi              : v1,
        };
        0x2::event::emit<PositionLiquidated>(v24);
        0x2::balance::join<T0>(&mut arg0.total_collateral, v21);
        0x2::coin::from_balance<T0>(v18, arg5)
    }

    public(friend) fun liquidation_reward_rate<T0>(arg0: &TradingPair<T0>) : u256 {
        arg0.liquidation_config.reward_rate
    }

    public(friend) fun lp_shares<T0>(arg0: &LPPosition<T0>) : u256 {
        arg0.shares
    }

    public(friend) fun min_liquidation_reward<T0>(arg0: &TradingPair<T0>) : u256 {
        arg0.liquidation_config.min_reward
    }

    public(friend) fun n<T0>(arg0: &TradingPair<T0>, arg1: &Position<T0>) : u256 {
        let v0 = arg1.id_count;
        if (!0x2::table::contains<u256, PositionInfo>(&arg0.position_infos, v0)) {
            return 0
        };
        0x2::table::borrow<u256, PositionInfo>(&arg0.position_infos, v0).n
    }

    public(friend) fun open_fee_rate<T0>(arg0: &TradingPair<T0>) : u256 {
        arg0.fee_config.open_fee_rate
    }

    public fun open_position<T0>(arg0: &mut TradingPair<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u256, arg3: bool, arg4: &0xf245f480ded5111af849028b22261f0394df290e03c80726bee54ea5912acf30::p2_oracle::Oracle, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        0x2::transfer::public_transfer<Position<T0>>(open_position_ptb<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6), v0);
    }

    public fun open_position_ptb<T0>(arg0: &mut TradingPair<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u256, arg3: bool, arg4: &0xf245f480ded5111af849028b22261f0394df290e03c80726bee54ea5912acf30::p2_oracle::Oracle, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : Position<T0> {
        let v0 = 0xf245f480ded5111af849028b22261f0394df290e03c80726bee54ea5912acf30::p2_oracle::get_current_price(arg4, arg0.pair_info.oracle_asset_id, arg5);
        let v1 = 0x2::tx_context::sender(arg6);
        open_position_ptb_with_entry_price<T0>(arg0, arg1, arg2, arg3, v1, 0, v0, arg5, arg6)
    }

    public(friend) fun open_position_ptb_on_behalf_of<T0>(arg0: &mut TradingPair<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u256, arg3: bool, arg4: address, arg5: &0xf245f480ded5111af849028b22261f0394df290e03c80726bee54ea5912acf30::p2_oracle::Oracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : Position<T0> {
        let v0 = 0xf245f480ded5111af849028b22261f0394df290e03c80726bee54ea5912acf30::p2_oracle::get_current_price(arg5, arg0.pair_info.oracle_asset_id, arg6);
        open_position_ptb_with_entry_price<T0>(arg0, arg1, arg2, arg3, arg4, 0, v0, arg6, arg7)
    }

    fun open_position_ptb_with_entry_price<T0>(arg0: &mut TradingPair<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u256, arg3: bool, arg4: address, arg5: u256, arg6: u256, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : Position<T0> {
        assert!(!arg0.is_paused, 1014);
        let v0 = calculate_fee_amount((0x2::coin::value<T0>(&arg1) as u256), 0xf245f480ded5111af849028b22261f0394df290e03c80726bee54ea5912acf30::fee_discount::apply_discount(arg0.fee_config.open_fee_rate, arg5));
        let v1 = to_u64(v0);
        let v2 = 0x2::coin::into_balance<T0>(arg1);
        if (v1 > 0) {
            let v3 = 0x2::balance::split<T0>(&mut v2, v1);
            let v4 = to_u64(calculate_fee_amount(v0, arg0.fee_config.vault_share_rate));
            if (v4 > 0) {
                0x2::balance::join<T0>(&mut arg0.vault_fee_balance, 0x2::balance::split<T0>(&mut v3, v4));
            };
            0x2::balance::join<T0>(&mut arg0.fee_balance, v3);
        };
        let v5 = (0x2::balance::value<T0>(&v2) as u256);
        assert!(v5 > 0, 1004);
        check_risk_on_open<T0>(arg0, arg4, v5, arg2);
        let v6 = arg0.total_positions_count;
        let v7 = compute_psi<T0>(arg0, arg6);
        0x2::balance::join<T0>(&mut arg0.total_collateral, v2);
        arg0.total_positions_count = v6 + 1;
        arg0.sum_psi = arg0.sum_psi + v5 * v7;
        if (arg3) {
            arg0.total_long_positions = arg0.total_long_positions + 1;
            arg0.sum_psi_long = arg0.sum_psi_long + v5 * arg2 * v7 / 1000000000000000000;
        } else {
            arg0.total_short_positions = arg0.total_short_positions + 1;
            arg0.sum_psi_short = arg0.sum_psi_short + v5 * arg2 * v7 / 1000000000000000000;
        };
        increase_user_risk_state<T0>(arg0, arg4, v5, calculate_position_exposure(v5, arg2));
        let v8 = Position<T0>{
            id       : 0x2::object::new(arg8),
            id_count : v6,
        };
        0x2::table::add<u256, address>(&mut arg0.position_risk_owners, v6, arg4);
        let v9 = PositionInfo{
            id_count          : v6,
            is_active         : true,
            opened_at         : 0x2::clock::timestamp_ms(arg7),
            closed_at         : 0,
            claimable_balance : 0,
            collateral        : v5,
            is_long           : arg3,
            leverage          : arg2,
            entry_price       : arg6,
            entry_psi         : v7,
            liquidation_price : calculate_liquidation_price(arg6, arg3, arg2),
            n                 : calculate_position_n(v5, arg2, arg6),
        };
        0x2::table::add<u256, PositionInfo>(&mut arg0.position_infos, v6, v9);
        let v10 = PositionOpened{
            pair_id     : 0x2::object::id_address<TradingPair<T0>>(arg0),
            position_id : 0x2::object::id_address<Position<T0>>(&v8),
            id_count    : v6,
            user        : arg4,
            executor    : 0x2::tx_context::sender(arg8),
            collateral  : v5,
            leverage    : arg2,
            is_long     : arg3,
            entry_price : arg6,
            entry_psi   : v7,
        };
        0x2::event::emit<PositionOpened>(v10);
        v8
    }

    public fun open_position_ptb_with_stake<T0>(arg0: &mut TradingPair<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u256, arg3: bool, arg4: &0xf245f480ded5111af849028b22261f0394df290e03c80726bee54ea5912acf30::taco_staking::StakePool, arg5: &0xf245f480ded5111af849028b22261f0394df290e03c80726bee54ea5912acf30::taco_staking::StakePosition, arg6: &0xf245f480ded5111af849028b22261f0394df290e03c80726bee54ea5912acf30::p2_oracle::Oracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : Position<T0> {
        let v0 = 0xf245f480ded5111af849028b22261f0394df290e03c80726bee54ea5912acf30::p2_oracle::get_current_price(arg6, arg0.pair_info.oracle_asset_id, arg7);
        let v1 = 0xf245f480ded5111af849028b22261f0394df290e03c80726bee54ea5912acf30::fee_discount::discount_rate_from_stake_position(arg4, arg5, arg7, 0x2::tx_context::sender(arg8));
        let v2 = 0x2::tx_context::sender(arg8);
        open_position_ptb_with_entry_price<T0>(arg0, arg1, arg2, arg3, v2, v1, v0, arg7, arg8)
    }

    public fun open_position_with_stake<T0>(arg0: &mut TradingPair<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u256, arg3: bool, arg4: &0xf245f480ded5111af849028b22261f0394df290e03c80726bee54ea5912acf30::taco_staking::StakePool, arg5: &0xf245f480ded5111af849028b22261f0394df290e03c80726bee54ea5912acf30::taco_staking::StakePosition, arg6: &0xf245f480ded5111af849028b22261f0394df290e03c80726bee54ea5912acf30::p2_oracle::Oracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        0x2::transfer::public_transfer<Position<T0>>(open_position_ptb_with_stake<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8), v0);
    }

    public(friend) fun pair_base_token_type<T0>(arg0: &TradingPair<T0>) : &0x1::string::String {
        &arg0.pair_info.base_token_type
    }

    public(friend) fun pair_description<T0>(arg0: &TradingPair<T0>) : &0x1::string::String {
        &arg0.pair_info.description
    }

    public(friend) fun pair_name<T0>(arg0: &TradingPair<T0>) : &0x1::string::String {
        &arg0.pair_info.name
    }

    public(friend) fun pair_oracle_asset_id<T0>(arg0: &TradingPair<T0>) : 0x1::string::String {
        arg0.pair_info.oracle_asset_id
    }

    public fun pause<T0>(arg0: &mut TradingPair<T0>, arg1: &GuardianCap) {
        assert_cap_matches_pair(0x2::object::id_address<TradingPair<T0>>(arg0), arg1.pair_id);
        arg0.is_paused = true;
        let v0 = PauseStateUpdated{
            pair_id   : 0x2::object::id_address<TradingPair<T0>>(arg0),
            is_paused : true,
        };
        0x2::event::emit<PauseStateUpdated>(v0);
    }

    public(friend) fun pending_claimable_total<T0>(arg0: &TradingPair<T0>) : u256 {
        arg0.pending_claimable_total
    }

    public(friend) fun position_claimable_balance<T0>(arg0: &TradingPair<T0>, arg1: &Position<T0>) : u256 {
        let v0 = arg1.id_count;
        if (!0x2::table::contains<u256, PositionInfo>(&arg0.position_infos, v0)) {
            return 0
        };
        0x2::table::borrow<u256, PositionInfo>(&arg0.position_infos, v0).claimable_balance
    }

    public(friend) fun position_closed_at<T0>(arg0: &TradingPair<T0>, arg1: u256) : u64 {
        0x2::table::borrow<u256, PositionInfo>(&arg0.position_infos, arg1).closed_at
    }

    public(friend) fun position_id<T0>(arg0: &Position<T0>) : u256 {
        arg0.id_count
    }

    public(friend) fun position_info<T0>(arg0: &TradingPair<T0>, arg1: u256) : PositionInfo {
        *0x2::table::borrow<u256, PositionInfo>(&arg0.position_infos, arg1)
    }

    public fun position_is_active<T0>(arg0: &TradingPair<T0>, arg1: &Position<T0>) : bool {
        let v0 = arg1.id_count;
        if (!0x2::table::contains<u256, PositionInfo>(&arg0.position_infos, v0)) {
            return false
        };
        0x2::table::borrow<u256, PositionInfo>(&arg0.position_infos, v0).is_active
    }

    public fun provide_liquidity<T0>(arg0: &mut TradingPair<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        0x2::transfer::public_transfer<LPPosition<T0>>(provide_liquidity_ptb<T0>(arg0, arg1, arg2, arg3), v0);
    }

    public fun provide_liquidity_ptb<T0>(arg0: &mut TradingPair<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : LPPosition<T0> {
        assert!(!arg0.is_paused, 1014);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = (0x2::coin::value<T0>(&arg1) as u256);
        assert!(v1 > 0, 1004);
        let v2 = calculate_minted_shares(v1, total_active_collateral<T0>(arg0), arg0.total_shares);
        0x2::balance::join<T0>(&mut arg0.total_collateral, 0x2::coin::into_balance<T0>(arg1));
        arg0.total_shares = arg0.total_shares + v2;
        let v3 = LPPosition<T0>{
            id        : 0x2::object::new(arg3),
            user      : v0,
            shares    : v2,
            opened_at : 0x2::clock::timestamp_ms(arg2),
        };
        let v4 = LiquidityProvided{
            pair_id        : 0x2::object::id_address<TradingPair<T0>>(arg0),
            lp_position_id : 0x2::object::id_address<LPPosition<T0>>(&v3),
            provider       : v0,
            collateral     : v1,
            shares_minted  : v2,
            share_price    : calculate_share_price_from_state(total_active_collateral<T0>(arg0), arg0.total_shares),
        };
        0x2::event::emit<LiquidityProvided>(v4);
        v3
    }

    public fun set_fee_config<T0>(arg0: &mut TradingPair<T0>, arg1: &RiskCap, arg2: u256, arg3: u256) {
        assert_cap_matches_pair(0x2::object::id_address<TradingPair<T0>>(arg0), arg1.pair_id);
        arg0.fee_config = build_fee_config(arg2, arg3, arg0.fee_config.vault_share_rate);
        let v0 = FeeConfigUpdated{
            pair_id          : 0x2::object::id_address<TradingPair<T0>>(arg0),
            open_fee_rate    : arg2,
            close_fee_rate   : arg3,
            vault_share_rate : arg0.fee_config.vault_share_rate,
        };
        0x2::event::emit<FeeConfigUpdated>(v0);
    }

    public fun set_liquidation_reward_rate<T0>(arg0: &mut TradingPair<T0>, arg1: &RiskCap, arg2: u256) {
        assert_cap_matches_pair(0x2::object::id_address<TradingPair<T0>>(arg0), arg1.pair_id);
        arg0.liquidation_config = build_liquidation_config(arg2, arg0.liquidation_config.min_reward);
        let v0 = LiquidationConfigUpdated{
            pair_id     : 0x2::object::id_address<TradingPair<T0>>(arg0),
            reward_rate : arg2,
            min_reward  : arg0.liquidation_config.min_reward,
        };
        0x2::event::emit<LiquidationConfigUpdated>(v0);
    }

    public fun set_min_liquidation_reward<T0>(arg0: &mut TradingPair<T0>, arg1: &RiskCap, arg2: u256) {
        assert_cap_matches_pair(0x2::object::id_address<TradingPair<T0>>(arg0), arg1.pair_id);
        assert!(arg2 <= arg0.risk_params.max_position_collateral, 1022);
        arg0.liquidation_config = build_liquidation_config(arg0.liquidation_config.reward_rate, arg2);
        let v0 = LiquidationConfigUpdated{
            pair_id     : 0x2::object::id_address<TradingPair<T0>>(arg0),
            reward_rate : arg0.liquidation_config.reward_rate,
            min_reward  : arg2,
        };
        0x2::event::emit<LiquidationConfigUpdated>(v0);
    }

    public fun set_risk_params<T0>(arg0: &mut TradingPair<T0>, arg1: &RiskCap, arg2: u256, arg3: u256, arg4: u256, arg5: u256, arg6: u256, arg7: u64) {
        assert_cap_matches_pair(0x2::object::id_address<TradingPair<T0>>(arg0), arg1.pair_id);
        let v0 = build_risk_params(arg2, arg3, arg4, arg5, arg6, arg7);
        assert!(arg0.liquidation_config.min_reward <= v0.max_position_collateral, 1022);
        arg0.risk_params = v0;
        let v1 = RiskParamsUpdated{
            pair_id                 : 0x2::object::id_address<TradingPair<T0>>(arg0),
            max_total_collateral    : arg2,
            max_position_collateral : arg3,
            max_leverage            : arg4,
            max_user_collateral     : arg5,
            max_user_exposure       : arg6,
            max_user_positions      : arg7,
        };
        0x2::event::emit<RiskParamsUpdated>(v1);
    }

    public fun set_vault_fee_share_rate<T0>(arg0: &mut TradingPair<T0>, arg1: &RiskCap, arg2: u256) {
        assert_cap_matches_pair(0x2::object::id_address<TradingPair<T0>>(arg0), arg1.pair_id);
        arg0.fee_config = build_fee_config(arg0.fee_config.open_fee_rate, arg0.fee_config.close_fee_rate, arg2);
        let v0 = FeeConfigUpdated{
            pair_id          : 0x2::object::id_address<TradingPair<T0>>(arg0),
            open_fee_rate    : arg0.fee_config.open_fee_rate,
            close_fee_rate   : arg0.fee_config.close_fee_rate,
            vault_share_rate : arg2,
        };
        0x2::event::emit<FeeConfigUpdated>(v0);
    }

    public(friend) fun sum_psi<T0>(arg0: &TradingPair<T0>) : u256 {
        arg0.sum_psi
    }

    public(friend) fun sum_psi_long<T0>(arg0: &TradingPair<T0>) : u256 {
        arg0.sum_psi_long
    }

    public(friend) fun sum_psi_short<T0>(arg0: &TradingPair<T0>) : u256 {
        arg0.sum_psi_short
    }

    fun to_u64(arg0: u256) : u64 {
        assert!(arg0 <= 18446744073709551615, 1003);
        (arg0 as u64)
    }

    fun total_active_collateral<T0>(arg0: &TradingPair<T0>) : u256 {
        let v0 = (0x2::balance::value<T0>(&arg0.total_collateral) as u256);
        if (arg0.pending_claimable_total >= v0) {
            return 0
        };
        v0 - arg0.pending_claimable_total
    }

    public(friend) fun total_collateral<T0>(arg0: &TradingPair<T0>) : u256 {
        (0x2::balance::value<T0>(&arg0.total_collateral) as u256)
    }

    public(friend) fun total_long_positions<T0>(arg0: &TradingPair<T0>) : u256 {
        arg0.total_long_positions
    }

    public(friend) fun total_positions_count<T0>(arg0: &TradingPair<T0>) : u256 {
        arg0.total_positions_count
    }

    public(friend) fun total_shares<T0>(arg0: &TradingPair<T0>) : u256 {
        arg0.total_shares
    }

    public(friend) fun total_short_positions<T0>(arg0: &TradingPair<T0>) : u256 {
        arg0.total_short_positions
    }

    public fun unpause<T0>(arg0: &mut TradingPair<T0>, arg1: &GuardianCap) {
        assert_cap_matches_pair(0x2::object::id_address<TradingPair<T0>>(arg0), arg1.pair_id);
        arg0.is_paused = false;
        let v0 = PauseStateUpdated{
            pair_id   : 0x2::object::id_address<TradingPair<T0>>(arg0),
            is_paused : false,
        };
        0x2::event::emit<PauseStateUpdated>(v0);
    }

    public(friend) fun vault_fee_share_rate<T0>(arg0: &TradingPair<T0>) : u256 {
        arg0.fee_config.vault_share_rate
    }

    public fun withdraw_liquidity<T0>(arg0: &mut TradingPair<T0>, arg1: LPPosition<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(withdraw_liquidity_ptb<T0>(arg0, arg1, arg2), v0);
    }

    public fun withdraw_liquidity_partial<T0>(arg0: &mut TradingPair<T0>, arg1: &mut LPPosition<T0>, arg2: u256, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(withdraw_liquidity_partial_ptb<T0>(arg0, arg1, arg2, arg3), v0);
    }

    public fun withdraw_liquidity_partial_ptb<T0>(arg0: &mut TradingPair<T0>, arg1: &mut LPPosition<T0>, arg2: u256, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(!arg0.is_paused, 1014);
        assert!(arg1.user == 0x2::tx_context::sender(arg3), 1018);
        assert!(arg2 > 0, 1017);
        assert!(arg2 <= arg1.shares, 1017);
        assert!(arg0.total_shares > 0, 1016);
        let v0 = calculate_withdraw_collateral(arg2, total_active_collateral<T0>(arg0), arg0.total_shares);
        assert_withdrawal_respects_claimable<T0>(arg0, v0);
        arg0.total_shares = arg0.total_shares - arg2;
        arg1.shares = arg1.shares - arg2;
        let v1 = LiquidityWithdrawn{
            pair_id        : 0x2::object::id_address<TradingPair<T0>>(arg0),
            lp_position_id : 0x2::object::id_address<LPPosition<T0>>(arg1),
            provider       : arg1.user,
            shares_burned  : arg2,
            collateral_out : v0,
            share_price    : calculate_share_price_from_state(total_active_collateral<T0>(arg0), arg0.total_shares),
        };
        0x2::event::emit<LiquidityWithdrawn>(v1);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.total_collateral, to_u64(v0)), arg3)
    }

    public fun withdraw_liquidity_ptb<T0>(arg0: &mut TradingPair<T0>, arg1: LPPosition<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(!arg0.is_paused, 1014);
        assert!(arg1.user == 0x2::tx_context::sender(arg2), 1018);
        let v0 = arg1.shares;
        assert!(v0 > 0, 1016);
        let v1 = calculate_withdraw_collateral(v0, total_active_collateral<T0>(arg0), arg0.total_shares);
        assert_withdrawal_respects_claimable<T0>(arg0, v1);
        arg0.total_shares = arg0.total_shares - v0;
        let LPPosition {
            id        : v2,
            user      : v3,
            shares    : _,
            opened_at : _,
        } = arg1;
        0x2::object::delete(v2);
        let v6 = LiquidityWithdrawn{
            pair_id        : 0x2::object::id_address<TradingPair<T0>>(arg0),
            lp_position_id : 0x2::object::id_address<LPPosition<T0>>(&arg1),
            provider       : v3,
            shares_burned  : v0,
            collateral_out : v1,
            share_price    : calculate_share_price_from_state(total_active_collateral<T0>(arg0), arg0.total_shares),
        };
        0x2::event::emit<LiquidityWithdrawn>(v6);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.total_collateral, to_u64(v1)), arg2)
    }

    // decompiled from Move bytecode v6
}

