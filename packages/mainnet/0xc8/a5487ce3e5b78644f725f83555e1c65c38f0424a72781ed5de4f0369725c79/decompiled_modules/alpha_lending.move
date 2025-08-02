module 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending {
    struct ALPHA_LENDING has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct LendingProtocol has store, key {
        id: 0x2::object::UID,
        lending_protocol_cap_id: 0x2::object::ID,
        positions: 0x2::table::Table<0x2::object::ID, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::Position>,
        markets: 0x2::table::Table<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>,
        oracle: 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::oracle::Oracle,
        protocol_fee_address: address,
        version: u64,
        config: LendingProtocolConfig,
        admin_cap_id: 0x2::object::ID,
    }

    struct LendingProtocolConfig has store {
        max_safe_collateral_ratio: u8,
        max_liquidation_threshold: u8,
        max_liquidation_bonus_bps: u64,
        max_liquidation_fee_bps: u64,
        lp_position_safe_collateral_ratio: u8,
        lp_position_liquidation_threshold: u8,
        reward_autocompounding: bool,
        pegged_position_config: vector<PeggedPostionPair>,
        multiplier_position_config: vector<MultiplierPositionConfig>,
        sui_staking_enabled: bool,
    }

    struct PeggedPostionPair has store {
        borrow_coin_type: 0x1::type_name::TypeName,
        deposit_coin_type: 0x1::type_name::TypeName,
        pegged_position_safe_collateral_ratio: u8,
        pegged_position_liquidation_threshold: u8,
    }

    struct MultiplierPositionConfig has store {
        coin_type: 0x1::type_name::TypeName,
        multiplier_position_safe_collateral_ratio: u8,
        multiplier_position_liquidation_threshold: u8,
    }

    struct LendingProtocolCap has store, key {
        id: 0x2::object::UID,
    }

    struct DepositEvent has copy, drop {
        cointype: 0x1::type_name::TypeName,
        market_id: u64,
        position_id: 0x2::object::ID,
        deposit_amount: u64,
        deposit_value: u64,
        deposit_fee: u64,
        partner_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct LPPositionDepositEvent has copy, drop {
        position_id: 0x2::object::ID,
        lp_position_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        partner_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct WithdrawEvent has copy, drop {
        cointype: 0x1::type_name::TypeName,
        market_id: u64,
        position_id: 0x2::object::ID,
        withdraw_amount: u64,
        withdraw_value: u64,
        withdraw_fee: u64,
        partner_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct BorrowEvent has copy, drop {
        cointype: 0x1::type_name::TypeName,
        market_id: u64,
        position_id: 0x2::object::ID,
        borrow_amount: u64,
        borrow_value: u64,
        borrow_fee: u64,
        partner_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct RepayEvent has copy, drop {
        cointype: 0x1::type_name::TypeName,
        market_id: u64,
        position_id: 0x2::object::ID,
        repay_amount: u64,
        repay_value: u64,
    }

    struct LiquidationEvent has copy, drop {
        repay_type: 0x1::type_name::TypeName,
        withdraw_type: 0x1::type_name::TypeName,
        position_id: 0x2::object::ID,
        repay_amount: u64,
        repay_value: u64,
        repay_market_id: u64,
        withdraw_amount: u64,
        withdraw_value: u64,
        withdraw_market_id: u64,
        liquidation_bonus: u64,
        liquidation_fee: u64,
    }

    struct LpLiquidationEvent has copy, drop {
        repay_type: 0x1::type_name::TypeName,
        position_id: 0x2::object::ID,
        repay_amount: u64,
        repay_value: u64,
        repay_market_id: u64,
        coin_a_amount: u64,
        coin_b_amount: u64,
        withdraw_value: u64,
        liquidation_bonus: u64,
        liquidation_fee: u64,
        lp_position_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
    }

    struct CollectRewardsEvent has copy, drop {
        reward_type: 0x1::type_name::TypeName,
        position_id: 0x2::object::ID,
        market_id: u64,
        reward_amount: u64,
    }

    struct CollectMarketFeeEvent has copy, drop {
        cointype: 0x1::type_name::TypeName,
        market_id: u64,
        fee_amount: u64,
    }

    struct CollectProtocolFeeEvent has copy, drop {
        cointype: 0x1::type_name::TypeName,
        market_id: u64,
        fee_amount: u64,
    }

    struct RewardUpdateEvent has copy, drop {
        reward_type: 0x1::type_name::TypeName,
        market_id: u64,
        reward_amount: u64,
        start_time: u64,
        end_time: u64,
    }

    struct LpPositionBorrowHotPotato {
        lp_position_id: 0x2::object::ID,
    }

    struct FlashTransactionHotPotato {
        position_id: 0x2::object::ID,
    }

    public fun borrow<T0>(arg0: &mut LendingProtocol, arg1: &0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::LiquidityPromise<T0> {
        verify_version(arg0);
        assert!(arg3 > 0, 32);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::Position>(&mut arg0.positions, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(arg1));
        let v1 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_partner_id(v0);
        if (0x1::option::is_some<0x2::object::ID>(&v1)) {
            0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::partner::validate_partner_is_active(0x2::dynamic_field::borrow<0x2::object::ID, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::partner::Partner>(&arg0.id, 0x1::option::extract<0x2::object::ID>(&mut v1)));
        } else {
            assert!(!0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::has_deposited_to(v0, arg2), 30);
        };
        let v2 = borrow_internal<T0>(arg0, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(arg1), arg2, arg3, arg4);
        let v3 = 0x2::table::borrow_mut<0x2::object::ID, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::Position>(&mut arg0.positions, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(arg1));
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::refresh(v3, &mut arg0.markets, &arg0.oracle, arg4);
        if (0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::borrowed_from_isolated(v3)) {
            assert!(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_borrow_market_count(v3) == 1, 2);
        };
        assert!(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::is_healthy(v3), 1);
        let v4 = BorrowEvent{
            cointype      : 0x1::type_name::get<T0>(),
            market_id     : arg2,
            position_id   : 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(arg1),
            borrow_amount : arg3,
            borrow_value  : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_spot_usd_value(0x2::table::borrow<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(&arg0.markets, arg2), &arg0.oracle, arg3), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(100))),
            borrow_fee    : 0,
            partner_id    : v1,
        };
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::events::emit_event<BorrowEvent>(v4);
        v2
    }

    public fun update_version(arg0: &mut LendingProtocol, arg1: &AdminCap, arg2: u64) {
        verify_admin_cap(arg0, arg1);
        assert!(arg2 > arg0.version, 7);
        arg0.version = arg2;
    }

    fun new(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : (LendingProtocolCap, AdminCap) {
        let v0 = LendingProtocolCap{id: 0x2::object::new(arg1)};
        let v1 = LendingProtocolConfig{
            max_safe_collateral_ratio         : 90,
            max_liquidation_threshold         : 95,
            max_liquidation_bonus_bps         : 1000,
            max_liquidation_fee_bps           : 1000,
            lp_position_safe_collateral_ratio : 80,
            lp_position_liquidation_threshold : 85,
            reward_autocompounding            : false,
            pegged_position_config            : 0x1::vector::empty<PeggedPostionPair>(),
            multiplier_position_config        : 0x1::vector::empty<MultiplierPositionConfig>(),
            sui_staking_enabled               : false,
        };
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        let v3 = LendingProtocol{
            id                      : 0x2::object::new(arg1),
            lending_protocol_cap_id : 0x2::object::id<LendingProtocolCap>(&v0),
            positions               : 0x2::table::new<0x2::object::ID, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::Position>(arg1),
            markets                 : 0x2::table::new<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(arg1),
            oracle                  : 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::oracle::create_oracle(arg1),
            protocol_fee_address    : arg0,
            version                 : 1,
            config                  : v1,
            admin_cap_id            : 0x2::object::id<AdminCap>(&v2),
        };
        0x2::transfer::share_object<LendingProtocol>(v3);
        (v0, v2)
    }

    public fun add_bluefin_lp_collateral<T0, T1>(arg0: &mut LendingProtocol, arg1: &0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, arg2: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        assert!(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::oracle::is_coin_in_oracle(&arg0.oracle, 0x1::type_name::get<T0>()), 27);
        assert!(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::oracle::is_coin_in_oracle(&arg0.oracle, 0x1::type_name::get<T1>()), 27);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::Position>(&mut arg0.positions, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(arg1));
        let v1 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_partner_id(v0);
        assert!(0x1::option::is_some<0x2::object::ID>(&v1), 26);
        let v2 = 0x2::dynamic_field::borrow<0x2::object::ID, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::partner::Partner>(&arg0.id, 0x1::option::extract<0x2::object::ID>(&mut v1));
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::partner::validate_partner_address(v2, 0x2::tx_context::sender(arg5));
        assert!(0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg3) == 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::pool_id(&arg2), 28);
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::add_bluefin_lp_collateral(v0, arg2, arg0.config.lp_position_safe_collateral_ratio, arg0.config.lp_position_liquidation_threshold, 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg3), arg4);
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::update_bluefin_lp_collateral_usd_value<T0, T1>(v0, arg3, &arg0.oracle, arg4);
        let v3 = LPPositionDepositEvent{
            position_id    : 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(arg1),
            lp_position_id : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg2),
            pool_id        : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg3),
            partner_id     : 0x1::option::some<0x2::object::ID>(0x2::object::id<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::partner::Partner>(v2)),
        };
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::events::emit_event<LPPositionDepositEvent>(v3);
    }

    public fun add_coin_to_oracle(arg0: &mut LendingProtocol, arg1: &AdminCap, arg2: 0x1::type_name::TypeName, arg3: &mut 0x2::tx_context::TxContext) : 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::oracle::PriceIdentifier {
        verify_version(arg0);
        verify_admin_cap(arg0, arg1);
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::oracle::add_coin_to_oracle(&mut arg0.oracle, arg2, arg3)
    }

    public fun add_collateral<T0>(arg0: &mut LendingProtocol, arg1: &0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        assert!(0x2::coin::value<T0>(&arg3) > 0, 31);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::Position>(&mut arg0.positions, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(arg1));
        let v1 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_partner_id(v0);
        if (0x1::option::is_some<0x2::object::ID>(&v1)) {
            0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::partner::validate_partner_is_active(0x2::dynamic_field::borrow<0x2::object::ID, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::partner::Partner>(&arg0.id, 0x1::option::extract<0x2::object::ID>(&mut v1)));
        } else {
            assert!(!0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::has_borrowed_from(v0, arg2), 29);
        };
        assert!(0x2::table::contains<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(&arg0.markets, arg2), 25);
        let v2 = 0x2::table::borrow_mut<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(&mut arg0.markets, arg2);
        assert!(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_active(v2), 23);
        assert!(!0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::deposit_limit_exceeded(v2, 0x2::coin::value<T0>(&arg3)), 37);
        let v3 = 0x2::coin::value<T0>(&arg3);
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::add_token_collateral<T0>(v0, arg2, v2, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::add_liquidity<T0>(v2, arg3, arg4), arg4);
        let v4 = DepositEvent{
            cointype       : 0x1::type_name::get<T0>(),
            market_id      : arg2,
            position_id    : 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(arg1),
            deposit_amount : v3,
            deposit_value  : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_spot_usd_value(v2, &arg0.oracle, v3), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(100))),
            deposit_fee    : 0,
            partner_id     : v1,
        };
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::events::emit_event<DepositEvent>(v4);
    }

    public fun add_market<T0>(arg0: &mut LendingProtocol, arg1: 0x2::coin::Coin<T0>, arg2: u8, arg3: u8, arg4: u64, arg5: u64, arg6: u8, arg7: u64, arg8: u64, arg9: u64, arg10: 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::oracle::PriceIdentifier, arg11: vector<0x1::type_name::TypeName>, arg12: vector<u8>, arg13: vector<u64>, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u8, arg19: &0x2::clock::Clock, arg20: &mut 0x2::tx_context::TxContext) : 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::MarketCap {
        abort 35
    }

    fun add_market_internal<T0>(arg0: &mut LendingProtocol, arg1: 0x2::coin::Coin<T0>, arg2: u8, arg3: u8, arg4: u64, arg5: u64, arg6: u8, arg7: u64, arg8: u64, arg9: u64, arg10: 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::oracle::PriceIdentifier, arg11: vector<0x1::type_name::TypeName>, arg12: vector<u8>, arg13: vector<u64>, arg14: u64, arg15: u64, arg16: u64, arg17: bool, arg18: u64, arg19: bool, arg20: u8, arg21: &0x2::clock::Clock, arg22: &mut 0x2::tx_context::TxContext) : 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::MarketCap {
        let v0 = 0x2::table::length<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(&arg0.markets) + 1;
        let v1 = 0x1::type_name::get<T0>();
        assert!(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::oracle::is_coin_in_oracle(&arg0.oracle, v1), 27);
        let (v2, v3) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::create_market<T0>(v0, v1, 0x2::coin::into_balance<T0>(arg1), arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, 0, arg19, arg20, arg21, arg22);
        0x2::table::add<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(&mut arg0.markets, v0, v2);
        v3
    }

    public fun add_market_native<T0>(arg0: &mut LendingProtocol, arg1: &AdminCap, arg2: 0x2::coin::Coin<T0>, arg3: u8, arg4: u8, arg5: u64, arg6: u64, arg7: u8, arg8: u64, arg9: u64, arg10: u64, arg11: 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::oracle::PriceIdentifier, arg12: vector<0x1::type_name::TypeName>, arg13: vector<u8>, arg14: vector<u64>, arg15: u64, arg16: u64, arg17: u64, arg18: bool, arg19: u64, arg20: u8, arg21: &0x2::clock::Clock, arg22: &mut 0x2::tx_context::TxContext) : 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::MarketCap {
        verify_version(arg0);
        verify_admin_cap(arg0, arg1);
        add_market_internal<T0>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, true, arg20, arg21, arg22)
    }

    public fun add_reward<T0>(arg0: &mut LendingProtocol, arg1: &0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::MarketCap, arg2: bool, arg3: 0x2::balance::Balance<T0>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        assert!(arg4 <= arg5, 6);
        assert!(arg4 >= 0x2::clock::timestamp_ms(arg6), 24);
        assert!(arg5 - arg4 <= 126144000001, 46);
        let v0 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_market_id(arg1);
        let v1 = 0x1::type_name::get<T0>();
        let v2 = if (arg0.config.reward_autocompounding == true) {
            find_market_by_coin(arg0, v1)
        } else {
            0x1::option::none<u64>()
        };
        let v3 = v2;
        if (0x1::option::is_some<u64>(&v3)) {
            let v4 = 0x1::option::extract<u64>(&mut v3);
            0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::add_reward<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::XToken<T0>>(0x2::table::borrow_mut<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(&mut arg0.markets, v0), arg1, arg2, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::add_liquidity<T0>(0x2::table::borrow_mut<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(&mut arg0.markets, v4), 0x2::coin::from_balance<T0>(arg3, arg7), arg6), v1, true, v4, arg4, arg5, arg6, arg7);
        } else {
            0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::add_reward<T0>(0x2::table::borrow_mut<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(&mut arg0.markets, v0), arg1, arg2, arg3, v1, false, 0, arg4, arg5, arg6, arg7);
        };
        let v5 = RewardUpdateEvent{
            reward_type   : v1,
            market_id     : v0,
            reward_amount : 0x2::balance::value<T0>(&arg3),
            start_time    : arg4,
            end_time      : arg5,
        };
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::events::emit_event<RewardUpdateEvent>(v5);
    }

    public fun borrow_bluefin_lp_collateral(arg0: &mut LendingProtocol, arg1: &0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, arg2: &mut 0x2::tx_context::TxContext) : (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, LpPositionBorrowHotPotato) {
        verify_version(arg0);
        let v0 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::borrow_bluefin_lp_collateral(0x2::table::borrow_mut<0x2::object::ID, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::Position>(&mut arg0.positions, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(arg1)));
        let v1 = LpPositionBorrowHotPotato{lp_position_id: 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&v0)};
        (v0, v1)
    }

    fun borrow_internal<T0>(arg0: &mut LendingProtocol, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) : 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::LiquidityPromise<T0> {
        assert!(0x2::table::contains<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(&arg0.markets, arg2), 25);
        let v0 = 0x2::table::borrow_mut<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(&mut arg0.markets, arg2);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::Position>(&mut arg0.positions, arg1);
        assert!(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_active(v0), 23);
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::add_borrow(v1, 0x1::type_name::get<T0>(), arg2, arg3, 0x2::clock::timestamp_ms(arg4), v0, arg4);
        if (0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::is_isolated(v0)) {
            assert!(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_borrow_market_count(v1) == 1, 2);
        };
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::borrow<T0>(v0, arg3, &arg0.oracle, arg4)
    }

    public fun change_protocol_fee_address(arg0: &mut LendingProtocol, arg1: &AdminCap, arg2: address) {
        verify_version(arg0);
        verify_admin_cap(arg0, arg1);
        arg0.protocol_fee_address = arg2;
    }

    public fun collect_reward<T0>(arg0: &mut LendingProtocol, arg1: u64, arg2: &0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::LiquidityPromise<T0>) {
        verify_version(arg0);
        let v0 = 0x2::table::borrow_mut<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(&mut arg0.markets, arg1);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::Position>(&mut arg0.positions, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(arg2));
        let (v2, v3, v4) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::claim_rewards<T0>(v1, v0, true, arg3);
        let v5 = v3;
        let v6 = v2;
        let (v7, v8, v9) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::claim_rewards<T0>(v1, v0, false, arg3);
        let v10 = v8;
        0x2::balance::join<T0>(&mut v6, v7);
        let v11 = 0x2::coin::from_balance<T0>(v6, arg4);
        let v12 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::create_empty_promise<T0>();
        if (0x2::balance::value<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::XToken<T0>>(&v5) > 0) {
            0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::join_promise<T0>(&mut v12, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::remove_liquidity<T0>(0x2::table::borrow_mut<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(&mut arg0.markets, v4), v5, &arg0.oracle, arg3));
        } else {
            0x2::balance::destroy_zero<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::XToken<T0>>(v5);
        };
        if (0x2::balance::value<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::XToken<T0>>(&v10) > 0) {
            0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::join_promise<T0>(&mut v12, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::remove_liquidity<T0>(0x2::table::borrow_mut<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(&mut arg0.markets, v9), v10, &arg0.oracle, arg3));
        } else {
            0x2::balance::destroy_zero<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::XToken<T0>>(v10);
        };
        let v13 = CollectRewardsEvent{
            reward_type   : 0x1::type_name::get<T0>(),
            position_id   : 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(arg2),
            market_id     : arg1,
            reward_amount : 0x2::coin::value<T0>(&v11),
        };
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::events::emit_event<CollectRewardsEvent>(v13);
        (v11, v12)
    }

    public fun collect_reward_and_deposit<T0>(arg0: &mut LendingProtocol, arg1: u64, arg2: &0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::LiquidityPromise<T0>) {
        verify_version(arg0);
        let (v0, v1) = collect_reward<T0>(arg0, arg1, arg2, arg3, arg4);
        let v2 = v0;
        let v3 = find_market_by_coin(arg0, 0x1::type_name::get<T0>());
        if (0x1::option::is_none<u64>(&v3)) {
            return (v2, v1)
        };
        let v4 = 0x1::option::extract<u64>(&mut v3);
        if (0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::has_borrowed_from(0x2::table::borrow_mut<0x2::object::ID, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::Position>(&mut arg0.positions, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(arg2)), v4)) {
            return (v2, v1)
        };
        let v5 = fulfill_promise<T0>(arg0, v1, arg3, arg4);
        0x2::coin::join<T0>(&mut v2, v5);
        let v6 = 0x2::table::borrow_mut<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(&mut arg0.markets, v4);
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::refresh(v6, arg3);
        let v7 = 0x2::coin::zero<T0>(arg4);
        if (!0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::deposit_limit_exceeded(v6, 0x2::coin::value<T0>(&v2)) && 0x2::coin::value<T0>(&v2) > 0) {
            add_collateral<T0>(arg0, arg2, v4, v2, arg3, arg4);
        } else {
            0x2::coin::join<T0>(&mut v7, v2);
        };
        (v7, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::create_empty_promise<T0>())
    }

    public fun collect_staking_rewards(arg0: &mut LendingProtocol, arg1: &AdminCap, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        verify_admin_cap(arg0, arg1);
        let v0 = find_market_by_coin(arg0, 0x1::type_name::get<0x2::sui::SUI>());
        assert!(0x1::option::is_some<u64>(&v0), 36);
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::collect_staking_rewards(0x2::table::borrow_mut<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(&mut arg0.markets, 0x1::option::extract<u64>(&mut v0)), arg2, arg3)
    }

    public fun create_new_admin_cap(arg0: &mut LendingProtocol, arg1: &LendingProtocolCap, arg2: &mut 0x2::tx_context::TxContext) : AdminCap {
        let v0 = AdminCap{id: 0x2::object::new(arg2)};
        arg0.admin_cap_id = 0x2::object::id<AdminCap>(&v0);
        v0
    }

    public fun create_partner(arg0: &mut LendingProtocol, arg1: &AdminCap, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::partner::PartnerCap {
        verify_version(arg0);
        verify_admin_cap(arg0, arg1);
        let (v0, v1) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::partner::create_partner(arg2, arg3, arg4);
        let v2 = v1;
        0x2::dynamic_field::add<0x2::object::ID, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::partner::Partner>(&mut arg0.id, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::partner::get_partner_id(&v2), v0);
        v2
    }

    public fun create_position(arg0: &mut LendingProtocol, arg1: &mut 0x2::tx_context::TxContext) : 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap {
        verify_version(arg0);
        let (v0, v1) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::create_position(0x2::tx_context::sender(arg1), 0x1::option::none<0x2::object::ID>(), 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_type_normal(), arg1);
        let v2 = v1;
        0x2::table::add<0x2::object::ID, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::Position>(&mut arg0.positions, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(&v2), v0);
        v2
    }

    public fun create_position_for_partner(arg0: &mut LendingProtocol, arg1: &0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::partner::PartnerCap, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) : 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap {
        verify_version(arg0);
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::partner::validate_partner_address(0x2::dynamic_field::borrow<0x2::object::ID, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::partner::Partner>(&arg0.id, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::partner::get_partner_id(arg1)), 0x2::tx_context::sender(arg3));
        let (v0, v1) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::create_position(0x2::tx_context::sender(arg3), 0x1::option::some<0x2::object::ID>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::partner::get_partner_id(arg1)), arg2, arg3);
        let v2 = v1;
        0x2::table::add<0x2::object::ID, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::Position>(&mut arg0.positions, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(&v2), v0);
        v2
    }

    fun find_market_by_coin(arg0: &LendingProtocol, arg1: 0x1::type_name::TypeName) : 0x1::option::Option<u64> {
        let v0 = 0x1::option::none<u64>();
        let v1 = 0;
        while (v1 < 0x2::table::length<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(&arg0.markets)) {
            if (0x2::table::contains<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(&arg0.markets, v1 + 1)) {
                let v2 = 0x2::table::borrow<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(&arg0.markets, v1 + 1);
                let v3 = if (0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_coin_type(v2) == arg1) {
                    if (0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_is_native(v2)) {
                        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_active(v2)
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v3) {
                    v0 = 0x1::option::some<u64>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_id(v2));
                    break
                };
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun flash_borrow<T0>(arg0: &mut LendingProtocol, arg1: &0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::LiquidityPromise<T0>, FlashTransactionHotPotato) {
        verify_version(arg0);
        let v0 = FlashTransactionHotPotato{position_id: 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(arg1)};
        assert!(0x2::table::contains<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(&arg0.markets, arg2), 25);
        let v1 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_partner_id(0x2::table::borrow_mut<0x2::object::ID, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::Position>(&mut arg0.positions, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(arg1)));
        if (0x1::option::is_some<0x2::object::ID>(&v1)) {
            0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::partner::validate_partner_is_active(0x2::dynamic_field::borrow<0x2::object::ID, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::partner::Partner>(&arg0.id, 0x1::option::extract<0x2::object::ID>(&mut v1)));
        };
        let v2 = borrow_internal<T0>(arg0, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(arg1), arg2, arg3, arg4);
        let v3 = BorrowEvent{
            cointype      : 0x1::type_name::get<T0>(),
            market_id     : arg2,
            position_id   : 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(arg1),
            borrow_amount : arg3,
            borrow_value  : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_spot_usd_value(0x2::table::borrow<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(&arg0.markets, arg2), &arg0.oracle, arg3), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(100))),
            borrow_fee    : 0,
            partner_id    : v1,
        };
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::events::emit_event<BorrowEvent>(v3);
        (v2, v0)
    }

    public fun flash_deposit<T0>(arg0: &mut LendingProtocol, arg1: &0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: FlashTransactionHotPotato, arg5: &0x2::clock::Clock) {
        verify_version(arg0);
        assert!(arg4.position_id == 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(arg1), 40);
        assert!(0x2::table::contains<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(&arg0.markets, arg2), 25);
        let v0 = 0x2::table::borrow_mut<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(&mut arg0.markets, arg2);
        assert!(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_coin_type(v0) == 0x1::type_name::get<T0>(), 42);
        let v1 = 0x2::coin::value<T0>(&arg3);
        let v2 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::add_liquidity<T0>(v0, arg3, arg5);
        let v3 = 0x2::table::borrow_mut<0x2::object::ID, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::Position>(&mut arg0.positions, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(arg1));
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::add_token_collateral<T0>(v3, arg2, v0, v2, arg5);
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::refresh(v3, &mut arg0.markets, &arg0.oracle, arg5);
        let v4 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_borrow_market_count(v3);
        let v5 = 0x2::table::borrow<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(&arg0.markets, arg2);
        if (0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::is_isolated(v5)) {
            assert!(v4 == 1, 2);
        };
        let FlashTransactionHotPotato {  } = arg4;
        let v6 = DepositEvent{
            cointype       : 0x1::type_name::get<T0>(),
            market_id      : arg2,
            position_id    : 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(arg1),
            deposit_amount : v1,
            deposit_value  : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_spot_usd_value(v5, &arg0.oracle, v1), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(100))),
            deposit_fee    : 0,
            partner_id     : 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_partner_id(v3),
        };
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::events::emit_event<DepositEvent>(v6);
        assert!(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::is_healthy(v3), 0);
    }

    public fun flash_repay<T0>(arg0: &mut LendingProtocol, arg1: &0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, arg2: FlashTransactionHotPotato, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        verify_version(arg0);
        assert!(arg2.position_id == 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(arg1), 40);
        assert!(0x2::table::contains<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(&arg0.markets, arg3), 25);
        assert!(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_coin_type(0x2::table::borrow_mut<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(&mut arg0.markets, arg3)) == 0x1::type_name::get<T0>(), 42);
        let v0 = repay_internal<T0>(arg0, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(arg1), arg3, arg4, arg5, arg6);
        let v1 = 0x2::coin::value<T0>(&arg4) - 0x2::coin::value<T0>(&v0);
        let FlashTransactionHotPotato {  } = arg2;
        let v2 = 0x2::table::borrow_mut<0x2::object::ID, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::Position>(&mut arg0.positions, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(arg1));
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::refresh(v2, &mut arg0.markets, &arg0.oracle, arg5);
        assert!(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::is_healthy(v2), 0);
        let v3 = RepayEvent{
            cointype     : 0x1::type_name::get<T0>(),
            market_id    : arg3,
            position_id  : 0x2::object::id<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::Position>(v2),
            repay_amount : v1,
            repay_value  : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_spot_usd_value(0x2::table::borrow_mut<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(&mut arg0.markets, arg3), &arg0.oracle, v1), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(100))),
        };
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::events::emit_event<RepayEvent>(v3);
        v0
    }

    public fun flash_withdraw<T0>(arg0: &mut LendingProtocol, arg1: &0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::LiquidityPromise<T0>, FlashTransactionHotPotato) {
        verify_version(arg0);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::Position>(&mut arg0.positions, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(arg1));
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::refresh(v0, &mut arg0.markets, &arg0.oracle, arg4);
        let v1 = FlashTransactionHotPotato{position_id: 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(arg1)};
        let v2 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_partner_id(v0);
        if (0x1::option::is_some<0x2::object::ID>(&v2)) {
            0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::partner::validate_partner_is_active(0x2::dynamic_field::borrow<0x2::object::ID, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::partner::Partner>(&arg0.id, 0x1::option::extract<0x2::object::ID>(&mut v2)));
        };
        let v3 = withdraw_internal_without_health_check<T0>(arg0, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(arg1), arg2, arg3, arg4);
        let v4 = WithdrawEvent{
            cointype        : 0x1::type_name::get<T0>(),
            market_id       : arg2,
            position_id     : 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(arg1),
            withdraw_amount : arg3,
            withdraw_value  : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_spot_usd_value(0x2::table::borrow<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(&arg0.markets, arg2), &arg0.oracle, arg3), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(100))),
            withdraw_fee    : 0,
            partner_id      : v2,
        };
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::events::emit_event<WithdrawEvent>(v4);
        (v3, v1)
    }

    public fun fulfill_promise<T0>(arg0: &mut LendingProtocol, arg1: 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::LiquidityPromise<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        verify_version(arg0);
        if (0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_promise_market_id<T0>(&arg1) == 0) {
            0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::destory_zero<T0>(arg1);
            return 0x2::coin::zero<T0>(arg3)
        };
        assert!(0x1::type_name::get<T0>() != 0x1::type_name::get<0x2::sui::SUI>(), 34);
        let v0 = 0x2::table::borrow_mut<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(&mut arg0.markets, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_promise_market_id<T0>(&arg1));
        let (v1, v2) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::fulfill_promise<T0>(v0, arg1, arg2, arg3);
        let v3 = v2;
        if (0x2::coin::value<T0>(&v3) > 0) {
            0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::add_fee<T0>(v0, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::add_liquidity<T0>(v0, v3, arg2));
        } else {
            0x2::coin::destroy_zero<T0>(v3);
        };
        v1
    }

    public fun fulfill_promise_SUI(arg0: &mut LendingProtocol, arg1: 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::LiquidityPromise<0x2::sui::SUI>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        verify_version(arg0);
        if (0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_promise_market_id<0x2::sui::SUI>(&arg1) == 0) {
            0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::destory_zero<0x2::sui::SUI>(arg1);
            return 0x2::coin::zero<0x2::sui::SUI>(arg4)
        };
        assert!(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_promise_coin_type<0x2::sui::SUI>(&arg1) == 0x1::type_name::get<0x2::sui::SUI>(), 34);
        let v0 = 0x2::table::borrow_mut<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(&mut arg0.markets, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_promise_market_id<0x2::sui::SUI>(&arg1));
        let (v1, v2) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::fulfill_promise_sui(v0, arg1, arg2, arg3, arg4);
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::add_fee<0x2::sui::SUI>(v0, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::add_liquidity<0x2::sui::SUI>(v0, v2, arg3));
        v1
    }

    public fun generate_new_market_cap(arg0: &mut LendingProtocol, arg1: &AdminCap, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::MarketCap {
        verify_admin_cap(arg0, arg1);
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::generate_new_market_cap(0x2::table::borrow_mut<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(&mut arg0.markets, arg2), arg3, arg4)
    }

    public fun get_asset_price(arg0: &mut LendingProtocol, arg1: u64) : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number {
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_token_spot_price(0x2::table::borrow<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(&arg0.markets, arg1), &arg0.oracle)
    }

    public fun get_borrow_amount(arg0: &mut LendingProtocol, arg1: u64, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) : u64 {
        assert!(0x2::table::contains<0x2::object::ID, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::Position>(&arg0.positions, arg2), 44);
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_borrow_amount(0x2::table::borrow_mut<0x2::object::ID, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::Position>(&mut arg0.positions, arg2), &mut arg0.markets, &arg0.oracle, arg3, arg1)
    }

    public fun get_claimable_rewards(arg0: &mut LendingProtocol, arg1: &0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, arg2: &0x2::clock::Clock) : vector<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::rewards::ClaimableReward> {
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_claimable_rewards(0x2::table::borrow_mut<0x2::object::ID, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::Position>(&mut arg0.positions, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(arg1)), &mut arg0.markets, arg2)
    }

    public fun get_collateral_amount(arg0: &mut LendingProtocol, arg1: u64, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) : u64 {
        assert!(0x2::table::contains<0x2::object::ID, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::Position>(&arg0.positions, arg2), 44);
        assert!(0x2::table::contains<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(&arg0.markets, arg1), 43);
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_collateral_amount(0x2::table::borrow_mut<0x2::object::ID, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::Position>(&mut arg0.positions, arg2), &mut arg0.markets, &arg0.oracle, arg3, arg1)
    }

    public fun get_price_identifier(arg0: &LendingProtocol, arg1: 0x1::type_name::TypeName) : 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::oracle::PriceIdentifier {
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::oracle::get_price_identifier(&arg0.oracle, arg1)
    }

    public fun get_safe_collateral_ratio(arg0: &LendingProtocol, arg1: u64) : u8 {
        assert!(0x2::table::contains<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(&arg0.markets, arg1), 43);
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_safe_collateral_ratio(0x2::table::borrow<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(&arg0.markets, arg1))
    }

    public fun get_version(arg0: &LendingProtocol) : u64 {
        arg0.version
    }

    fun init(arg0: ALPHA_LENDING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = new(v0, arg1);
        0x2::transfer::public_transfer<LendingProtocolCap>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"creator"));
        let v5 = 0x1::vector::empty<0x1::string::String>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"AlphaLend Position Cap"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"AlphaLend Protocol Postion Capability"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"AlphaLend"));
        let v7 = 0x2::package::claim<ALPHA_LENDING>(arg0, arg1);
        let v8 = 0x2::display::new_with_fields<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&v7, v3, v5, arg1);
        0x2::display::update_version<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(&mut v8);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v7, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>>(v8, 0x2::tx_context::sender(arg1));
    }

    public fun liquidate<T0, T1>(arg0: &mut LendingProtocol, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::LiquidityPromise<T1>, 0x2::coin::Coin<T0>) {
        verify_version(arg0);
        assert!(0x2::table::contains<0x2::object::ID, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::Position>(&arg0.positions, arg1), 44);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::Position>(&mut arg0.positions, arg1);
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::refresh(v0, &mut arg0.markets, &arg0.oracle, arg5);
        assert!(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::is_liquidatable(v0, arg5), 4);
        let (v1, v2, v3, v4, v5, v6) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::liquidate<T0, T1>(v0, &mut arg0.markets, arg3, arg2, arg4, &arg0.oracle, arg5, arg6);
        let v7 = v5;
        let v8 = v4;
        let v9 = v1;
        assert!(0x2::table::contains<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(&arg0.markets, arg2), 25);
        let v10 = 0x2::table::borrow_mut<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(&mut arg0.markets, arg2);
        let v11 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_spot_usd_value(v10, &arg0.oracle, 0x2::coin::value<T0>(&v7)), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(100)));
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::repay<T0>(v10, v7, arg5);
        assert!(0x2::table::contains<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(&arg0.markets, arg3), 25);
        let v12 = 0x2::table::borrow_mut<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(&mut arg0.markets, arg3);
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::add_fee<T1>(v12, v8);
        let v13 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::remove_liquidity<T1>(v12, v9, &arg0.oracle, arg5);
        let v14 = LiquidationEvent{
            repay_type         : 0x1::type_name::get<T0>(),
            withdraw_type      : 0x1::type_name::get<T1>(),
            position_id        : arg1,
            repay_amount       : v11,
            repay_value        : 0x2::coin::value<T0>(&v7),
            repay_market_id    : arg2,
            withdraw_amount    : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(v2, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(100))),
            withdraw_value     : 0x2::balance::value<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::XToken<T1>>(&v9) + 0x2::balance::value<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::XToken<T1>>(&v8),
            withdraw_market_id : arg3,
            liquidation_bonus  : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(v3, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(100))),
            liquidation_fee    : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0x2::balance::value<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::XToken<T1>>(&v8)), 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_xtoken_price(v12, &arg0.oracle)), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(100))),
        };
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::events::emit_event<LiquidationEvent>(v14);
        (v13, v6)
    }

    public fun liquidate_lp_position<T0, T1, T2>(arg0: &mut LendingProtocol, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: 0x2::coin::Coin<T2>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        verify_version(arg0);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::Position>(&mut arg0.positions, arg1);
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::update_bluefin_lp_collateral_usd_value<T0, T1>(v0, arg3, &arg0.oracle, arg6);
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::refresh(v0, &mut arg0.markets, &arg0.oracle, arg6);
        assert!(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::is_liquidatable(v0, arg6), 4);
        let (v1, v2, v3, v4, v5, v6, v7, v8, v9, v10) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::liquidate_bluefin_lp_position<T0, T1, T2>(v0, &mut arg0.markets, arg2, arg4, arg3, arg5, &arg0.oracle, arg6, arg7);
        let v11 = v6;
        let v12 = v2;
        let v13 = v1;
        let v14 = 0x2::table::borrow_mut<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(&mut arg0.markets, arg2);
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::repay<T2>(v14, v11, arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v9, arg0.protocol_fee_address);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v10, arg0.protocol_fee_address);
        let v15 = LpLiquidationEvent{
            repay_type        : 0x1::type_name::get<T1>(),
            position_id       : arg1,
            repay_amount      : 0x2::coin::value<T2>(&v11),
            repay_value       : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_spot_usd_value(v14, &arg0.oracle, 0x2::coin::value<T2>(&v11))),
            repay_market_id   : arg2,
            coin_a_amount     : 0x2::coin::value<T0>(&v13),
            coin_b_amount     : 0x2::coin::value<T1>(&v12),
            withdraw_value    : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(v3),
            liquidation_bonus : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(v4),
            liquidation_fee   : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(v5),
            lp_position_id    : v8,
            pool_id           : 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg3),
        };
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::events::emit_event<LpLiquidationEvent>(v15);
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::update_bluefin_lp_collateral_usd_value<T0, T1>(v0, arg3, &arg0.oracle, arg6);
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::refresh(v0, &mut arg0.markets, &arg0.oracle, arg6);
        (v13, v12, v7)
    }

    public fun loan_bailout<T0>(arg0: &mut LendingProtocol, arg1: u64, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        repay_internal<T0>(arg0, arg2, arg1, arg3, arg4, arg5)
    }

    public fun loan_writeoff(arg0: &mut LendingProtocol, arg1: &AdminCap, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) {
        verify_version(arg0);
        verify_admin_cap(arg0, arg1);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::Position>(&mut arg0.positions, arg2);
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::refresh(v0, &mut arg0.markets, &arg0.oracle, arg3);
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::loan_writeoff(v0, &mut arg0.markets, &arg0.oracle, arg3);
    }

    public fun remove_bluefin_lp_collateral(arg0: &mut LendingProtocol, arg1: &0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap) : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position {
        verify_version(arg0);
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::remove_bluefin_lp_collateral(0x2::table::borrow_mut<0x2::object::ID, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::Position>(&mut arg0.positions, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(arg1)))
    }

    public fun remove_collateral<T0>(arg0: &mut LendingProtocol, arg1: &0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) : 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::LiquidityPromise<T0> {
        verify_version(arg0);
        assert!(arg3 > 0, 31);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::Position>(&mut arg0.positions, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(arg1));
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::refresh(v0, &mut arg0.markets, &arg0.oracle, arg4);
        let v1 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_partner_id(v0);
        let v2 = withdraw_internal_without_health_check<T0>(arg0, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(arg1), arg2, arg3, arg4);
        let v3 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_liquidity_promise<T0>(&v2);
        let v4 = 0x2::table::borrow_mut<0x2::object::ID, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::Position>(&mut arg0.positions, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(arg1));
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::refresh(v4, &mut arg0.markets, &arg0.oracle, arg4);
        assert!(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::is_healthy(v4), 0);
        let v5 = WithdrawEvent{
            cointype        : 0x1::type_name::get<T0>(),
            market_id       : arg2,
            position_id     : 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(arg1),
            withdraw_amount : v3,
            withdraw_value  : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_spot_usd_value(0x2::table::borrow<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(&arg0.markets, arg2), &arg0.oracle, v3), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(100))),
            withdraw_fee    : 0,
            partner_id      : v1,
        };
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::events::emit_event<WithdrawEvent>(v5);
        v2
    }

    public fun repay<T0>(arg0: &mut LendingProtocol, arg1: &0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::coin::value<T0>(&arg3) > 0, 33);
        repay_internal<T0>(arg0, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(arg1), arg2, arg3, arg4, arg5)
    }

    fun repay_internal<T0>(arg0: &mut LendingProtocol, arg1: 0x2::object::ID, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        verify_version(arg0);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::Position>(&mut arg0.positions, arg1);
        assert!(0x2::table::contains<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(&arg0.markets, arg2), 25);
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::refresh(0x2::table::borrow_mut<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(&mut arg0.markets, arg2), arg4);
        let v1 = 0x2::table::borrow_mut<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(&mut arg0.markets, arg2);
        let v2 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::repay(v0, 0x1::type_name::get<T0>(), arg2, v1, 0x2::coin::value<T0>(&arg3), arg4);
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::repay<T0>(v1, 0x2::coin::split<T0>(&mut arg3, v2, arg5), arg4);
        let v3 = RepayEvent{
            cointype     : 0x1::type_name::get<T0>(),
            market_id    : arg2,
            position_id  : 0x2::object::id<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::Position>(v0),
            repay_amount : v2,
            repay_value  : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_spot_usd_value(v1, &arg0.oracle, v2), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(100))),
        };
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::events::emit_event<RepayEvent>(v3);
        arg3
    }

    public fun return_bluefin_lp_collateral<T0, T1>(arg0: &mut LendingProtocol, arg1: &0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg4: LpPositionBorrowHotPotato, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        assert!(arg4.lp_position_id == 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg3), 9);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::Position>(&mut arg0.positions, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(arg1));
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::return_bluefin_lp_collateral<T0, T1>(v0, arg3, &arg0.oracle, arg2, arg5);
        let LpPositionBorrowHotPotato {  } = arg4;
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::refresh(v0, &mut arg0.markets, &arg0.oracle, arg5);
        assert!(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::is_healthy(v0), 0);
    }

    public fun set_price_staleness_threshold(arg0: &mut LendingProtocol, arg1: &AdminCap, arg2: u64) {
        verify_version(arg0);
        verify_admin_cap(arg0, arg1);
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::oracle::set_price_staleness_threshold(&mut arg0.oracle, arg2);
    }

    public fun set_time_lock(arg0: &mut LendingProtocol, arg1: &0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::MarketCap, arg2: u64, arg3: &0x2::clock::Clock) {
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::set_time_lock(0x2::table::borrow_mut<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(&mut arg0.markets, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_market_id(arg1)), arg1, arg2, arg3);
    }

    public fun update_bluefin_lp_collateral_usd_value<T0, T1>(arg0: &mut LendingProtocol, arg1: 0x2::object::ID, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock) {
        verify_version(arg0);
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::update_bluefin_lp_collateral_usd_value<T0, T1>(0x2::table::borrow_mut<0x2::object::ID, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::Position>(&mut arg0.positions, arg1), arg2, &arg0.oracle, arg3);
    }

    public fun update_flow_limiter(arg0: &mut LendingProtocol, arg1: &0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::MarketCap, arg2: bool, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) {
        let v0 = 0x2::table::borrow_mut<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(&mut arg0.markets, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_market_id(arg1));
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::verify_market_cap(v0, arg1);
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::update_flow_limiter(v0, arg2, arg3, arg4, &arg0.oracle, arg5);
    }

    public fun update_lp_position_config(arg0: &mut LendingProtocol, arg1: &AdminCap, arg2: 0x2::object::ID, arg3: u8, arg4: u8, arg5: u64, arg6: u64, arg7: u8) {
        verify_version(arg0);
        verify_admin_cap(arg0, arg1);
        assert!(arg3 <= 100 && arg4 <= 100, 20);
        assert!(arg5 <= 10000 && arg6 <= 10000, 20);
        assert!(arg7 <= 100, 20);
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::update_lp_position_config(0x2::table::borrow_mut<0x2::object::ID, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::Position>(&mut arg0.positions, arg2), arg3, arg4, arg5, arg6, arg7);
    }

    public fun update_market_active(arg0: &mut LendingProtocol, arg1: &0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::MarketCap, arg2: bool, arg3: &0x2::clock::Clock) {
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::set_market_active(0x2::table::borrow_mut<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(&mut arg0.markets, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_market_id(arg1)), arg1, arg2, arg3);
    }

    public fun update_market_collateral_ratios(arg0: &mut LendingProtocol, arg1: &0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::MarketCap, arg2: u8, arg3: u8, arg4: &0x2::clock::Clock) {
        assert!(arg2 <= arg0.config.max_safe_collateral_ratio && arg3 <= arg0.config.max_liquidation_threshold, 20);
        assert!(arg2 < arg3, 21);
        assert!((arg3 as u16) - (arg2 as u16) >= 5, 21);
        let v0 = 0x2::table::borrow_mut<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(&mut arg0.markets, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_market_id(arg1));
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::verify_market_cap(v0, arg1);
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::update_collateral_ratios(v0, arg1, arg2, arg3, arg4);
    }

    public fun update_market_fee_config(arg0: &mut LendingProtocol, arg1: &0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::MarketCap, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock) {
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::update_fee_config(0x2::table::borrow_mut<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(&mut arg0.markets, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_market_id(arg1)), arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun update_market_interest_rate_config(arg0: &mut LendingProtocol, arg1: &0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::MarketCap, arg2: vector<u8>, arg3: vector<u64>, arg4: &0x2::clock::Clock) {
        assert!(0x1::vector::length<u8>(&arg2) == 0x1::vector::length<u64>(&arg3) && 0x1::vector::length<u8>(&arg2) > 0, 22);
        let v0 = 0x2::table::borrow_mut<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(&mut arg0.markets, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_market_id(arg1));
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::verify_market_cap(v0, arg1);
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::update_interest_rate_config(v0, arg1, arg2, arg3, arg4);
    }

    public fun update_market_isolation(arg0: &mut LendingProtocol, arg1: &AdminCap, arg2: u64, arg3: bool, arg4: u8, arg5: u8, arg6: &0x2::clock::Clock) {
        verify_version(arg0);
        verify_admin_cap(arg0, arg1);
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::update_market_isolation(0x2::table::borrow_mut<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(&mut arg0.markets, arg2), arg3, arg4, arg5, arg6);
    }

    public fun update_market_limits(arg0: &mut LendingProtocol, arg1: &0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::MarketCap, arg2: u64, arg3: u64, arg4: u8, arg5: &0x2::clock::Clock) {
        let v0 = 0x2::table::borrow_mut<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(&mut arg0.markets, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_market_id(arg1));
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::verify_market_cap(v0, arg1);
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::update_limits(v0, arg2, arg3, arg4, arg5);
    }

    public fun update_market_liquidation_config(arg0: &mut LendingProtocol, arg1: &0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::MarketCap, arg2: u64, arg3: u64, arg4: u8, arg5: &0x2::clock::Clock) {
        let v0 = if (arg2 <= arg0.config.max_liquidation_bonus_bps) {
            if (arg3 <= arg0.config.max_liquidation_fee_bps) {
                arg2 + arg3 <= 10000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 38);
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::update_liquidation_config(0x2::table::borrow_mut<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(&mut arg0.markets, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_market_id(arg1)), arg1, arg2, arg3, arg4, arg5);
    }

    public fun update_partner_cap_discount(arg0: &mut LendingProtocol, arg1: &AdminCap, arg2: 0x2::object::ID, arg3: u64) {
        verify_version(arg0);
        verify_admin_cap(arg0, arg1);
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::partner::update_fee_discount_bps(0x2::dynamic_field::borrow_mut<0x2::object::ID, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::partner::Partner>(&mut arg0.id, arg2), arg3);
    }

    public fun update_partner_is_active(arg0: &mut LendingProtocol, arg1: &AdminCap, arg2: u64, arg3: bool) {
        verify_admin_cap(arg0, arg1);
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::partner::update_is_active(0x2::dynamic_field::borrow_mut<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::partner::Partner>(&mut arg0.id, arg2), arg3);
    }

    public fun update_price(arg0: &mut LendingProtocol, arg1: &0x378b2a104e8bcd7ed0317f5e6a0ec4fd271d4d12e2fe6c99bcd1f12be725cf4f::oracle::PriceInfo) {
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::oracle::update_price(&mut arg0.oracle, arg1);
    }

    public fun update_protocol_config(arg0: &mut LendingProtocol, arg1: &AdminCap, arg2: u8, arg3: u8, arg4: u64, arg5: u64, arg6: u8, arg7: u8) {
        verify_version(arg0);
        verify_admin_cap(arg0, arg1);
        let v0 = if (arg2 <= 100) {
            if (arg3 <= 100) {
                if (arg4 <= 10000) {
                    if (arg5 <= 10000) {
                        if ((arg3 as u16) - (arg2 as u16) >= 5) {
                            if (arg6 <= 100) {
                                if (arg7 <= 100) {
                                    (arg7 as u16) - (arg6 as u16) >= 5
                                } else {
                                    false
                                }
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 20);
        arg0.config.max_safe_collateral_ratio = arg2;
        arg0.config.max_liquidation_threshold = arg3;
        arg0.config.max_liquidation_bonus_bps = arg4;
        arg0.config.max_liquidation_fee_bps = arg5;
        arg0.config.lp_position_safe_collateral_ratio = arg6;
        arg0.config.lp_position_liquidation_threshold = arg7;
    }

    public fun update_protocol_fee(arg0: &mut LendingProtocol, arg1: &AdminCap, arg2: u64, arg3: u64, arg4: u64) {
        verify_admin_cap(arg0, arg1);
        assert!(arg3 <= 10000 && arg4 <= 10000, 20);
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::update_protocol_fee_share(0x2::table::borrow_mut<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(&mut arg0.markets, arg2), arg3, arg4);
    }

    public fun update_reward_autocompounding(arg0: &mut LendingProtocol, arg1: &AdminCap, arg2: bool) {
        verify_admin_cap(arg0, arg1);
        arg0.config.reward_autocompounding = arg2;
    }

    public fun update_sui_staking_enabled(arg0: &mut LendingProtocol, arg1: &AdminCap, arg2: address, arg3: bool, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &mut 0x2::tx_context::TxContext) {
        verify_admin_cap(arg0, arg1);
        let v0 = find_market_by_coin(arg0, 0x1::type_name::get<0x2::sui::SUI>());
        assert!(0x1::option::is_some<u64>(&v0), 36);
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::set_sui_staking_enabled(0x2::table::borrow_mut<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(&mut arg0.markets, 0x1::option::extract<u64>(&mut v0)), arg2, arg3, arg4, arg5);
        arg0.config.sui_staking_enabled = arg3;
    }

    fun verify_admin_cap(arg0: &LendingProtocol, arg1: &AdminCap) {
        assert!(0x2::object::id<AdminCap>(arg1) == arg0.admin_cap_id, 3);
    }

    fun verify_version(arg0: &LendingProtocol) {
        assert!(arg0.version == 1, 8);
    }

    fun withdraw_internal_without_health_check<T0>(arg0: &mut LendingProtocol, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) : 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::LiquidityPromise<T0> {
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::Position>(&mut arg0.positions, arg1);
        0x2::table::borrow_mut<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(&mut arg0.markets, arg2);
        let v1 = if (arg3 == 18446744073709551615) {
            0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_collateral_xtoken_amount(v0, arg2)
        } else {
            0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg3), 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_xtoken_ratio(0x2::table::borrow<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(&arg0.markets, arg2))))
        };
        let v2 = 0x2::table::borrow_mut<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(&mut arg0.markets, arg2);
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::remove_liquidity<T0>(v2, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::remove_token_collateral<T0>(v0, arg2, v2, v1, arg4), &arg0.oracle, arg4)
    }

    public fun withdraw_market_fee<T0>(arg0: &mut LendingProtocol, arg1: &0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::MarketCap, arg2: &0x2::clock::Clock) : 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::LiquidityPromise<T0> {
        verify_version(arg0);
        let v0 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_market_id(arg1);
        let v1 = 0x2::table::borrow_mut<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(&mut arg0.markets, v0);
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::verify_market_cap(v1, arg1);
        assert!(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_coin_type(v1) == 0x1::type_name::get<T0>(), 5);
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::refresh(v1, arg2);
        let v2 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::withdraw_market_fee<T0>(v1, arg2);
        let v3 = CollectMarketFeeEvent{
            cointype   : 0x1::type_name::get<T0>(),
            market_id  : v0,
            fee_amount : 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_liquidity_promise<T0>(&v2),
        };
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::events::emit_event<CollectMarketFeeEvent>(v3);
        v2
    }

    public fun withdraw_protocol_fee<T0>(arg0: &mut LendingProtocol, arg1: &AdminCap, arg2: u64, arg3: &0x2::clock::Clock) : 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::LiquidityPromise<T0> {
        verify_version(arg0);
        verify_admin_cap(arg0, arg1);
        let v0 = 0x2::table::borrow_mut<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(&mut arg0.markets, arg2);
        assert!(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_coin_type(v0) == 0x1::type_name::get<T0>(), 39);
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::refresh(v0, arg3);
        let v1 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::withdraw_protocol_fee<T0>(v0, arg3);
        let v2 = CollectProtocolFeeEvent{
            cointype   : 0x1::type_name::get<T0>(),
            market_id  : arg2,
            fee_amount : 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_liquidity_promise<T0>(&v1),
        };
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::events::emit_event<CollectProtocolFeeEvent>(v2);
        v1
    }

    // decompiled from Move bytecode v6
}

