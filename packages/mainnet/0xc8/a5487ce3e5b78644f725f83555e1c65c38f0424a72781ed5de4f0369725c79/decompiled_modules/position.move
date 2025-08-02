module 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position {
    struct PositionCap has store, key {
        id: 0x2::object::UID,
        position_id: 0x2::object::ID,
        client_address: address,
        image_url: 0x1::string::String,
    }

    struct Position has store, key {
        id: 0x2::object::UID,
        partner_id: 0x1::option::Option<0x2::object::ID>,
        lp_collaterals: 0x1::option::Option<LpPositionCollateral>,
        collaterals: 0x2::vec_map::VecMap<u64, u64>,
        loans: vector<Borrow>,
        total_collateral_usd: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        safe_collateral_usd: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        liquidation_value: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        additional_permissible_borrow_usd: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        total_loan_usd: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        spot_total_loan_usd: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        weighted_total_loan_usd: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        weighted_spot_total_loan_usd: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        is_position_healthy: bool,
        is_position_liquidatable: bool,
        reward_distributors: vector<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::rewards::UserRewardDistributor>,
        is_isolated_borrowed: bool,
        last_refreshed: u64,
        position_type: u8,
    }

    struct LpPositionCollateralConfig has drop, store {
        safe_collateral_ratio: u8,
        liquidation_threshold: u8,
        liquidation_bonus: u64,
        liquidation_fee: u64,
        close_factor_percentage: u8,
    }

    struct LpPositionCollateral has store {
        pool_id: 0x2::object::ID,
        lp_position_id: 0x2::object::ID,
        usd_value: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        safe_usd_value: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        liquidation_value: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        liquidity: u128,
        config: LpPositionCollateralConfig,
        last_updated: u64,
        lp_type: u8,
    }

    struct TokenCollateral<phantom T0> has store {
        market_id: u64,
        x_token: 0x2::balance::Balance<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::XToken<T0>>,
        reward_distributor_index: u64,
    }

    struct Borrow has store {
        coin_type: 0x1::type_name::TypeName,
        market_id: u64,
        amount: u64,
        borrow_time: u64,
        borrow_compounded_interest: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        reward_distributor_index: u64,
    }

    struct PositionCreateEvent has copy, drop {
        position_id: 0x2::object::ID,
        partner_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct PositionUpdateEvent has copy, drop {
        position_id: 0x2::object::ID,
        partner_id: 0x1::option::Option<0x2::object::ID>,
        total_collateral_usd: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        safe_collateral_usd: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        liquidation_value: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        additional_permissible_borrow_usd: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        total_loan_usd: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        spot_total_loan_usd: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        weighted_total_loan_usd: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        weighted_spot_total_loan_usd: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        is_position_healthy: bool,
        is_position_liquidatable: bool,
        is_isolated_borrowed: bool,
        last_refreshed: u64,
    }

    struct LPPositionCollateralUpdateEvent has copy, drop {
        position_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        lp_position_id: 0x2::object::ID,
        usd_value: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        safe_usd_value: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        liquidation_value: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        liquidity: u128,
        lp_type: u8,
        last_updated: u64,
    }

    struct TokenCollateralUpdateEvent has copy, drop {
        position_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        market_id: u64,
        x_token_balance: u64,
        reward_distributor_index: u64,
    }

    struct BorrowUpdateEvent has copy, drop {
        position_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        market_id: u64,
        amount: u64,
        borrow_time: u64,
        borrow_compounded_interest: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        reward_distributor_index: u64,
    }

    public(friend) fun add_bluefin_lp_collateral(arg0: &mut Position, arg1: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg2: u8, arg3: u8, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock) {
        let v0 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg1);
        let v1 = LpPositionCollateralConfig{
            safe_collateral_ratio   : arg2,
            liquidation_threshold   : arg3,
            liquidation_bonus       : 1000,
            liquidation_fee         : 500,
            close_factor_percentage : 20,
        };
        let v2 = LpPositionCollateral{
            pool_id           : arg4,
            lp_position_id    : v0,
            usd_value         : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0),
            safe_usd_value    : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0),
            liquidation_value : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0),
            liquidity         : 0,
            config            : v1,
            last_updated      : 0x2::clock::timestamp_ms(arg5),
            lp_type           : 0,
        };
        emit_position_collateral_update_event(arg0, &v2);
        0x1::option::fill<LpPositionCollateral>(&mut arg0.lp_collaterals, v2);
        0x2::dynamic_field::add<0x2::object::ID, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.id, v0, arg1);
    }

    public(friend) fun add_borrow(arg0: &mut Position, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market, arg6: &0x2::clock::Clock) {
        let v0 = 0x2::object::id<Position>(arg0);
        let v1 = 0x1::vector::length<Borrow>(&arg0.loans);
        let v2 = 0;
        while (v2 < v1) {
            let v3 = 0x1::vector::borrow_mut<Borrow>(&mut arg0.loans, v2);
            if (v3.market_id != arg2) {
                v2 = v2 + 1;
            } else {
                v3.amount = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(v3.amount), 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_compounded_interest(arg5)), v3.borrow_compounded_interest));
                v3.amount = v3.amount + arg3;
                v3.borrow_compounded_interest = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_compounded_interest(arg5);
                break
            };
        };
        if (v2 == v1) {
            let v4 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_borrow_reward_distributor(arg5);
            let v5 = find_or_add_user_reward_distributor(arg0, v4, arg6, false);
            let v6 = Borrow{
                coin_type                  : arg1,
                market_id                  : arg2,
                amount                     : arg3,
                borrow_time                : arg4,
                borrow_compounded_interest : 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_compounded_interest(arg5),
                reward_distributor_index   : v5,
            };
            0x1::vector::push_back<Borrow>(&mut arg0.loans, v6);
        };
        let v7 = 0x1::vector::borrow_mut<Borrow>(&mut arg0.loans, v2);
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::rewards::change_user_share(0x1::vector::borrow_mut<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::rewards::UserRewardDistributor>(&mut arg0.reward_distributors, v7.reward_distributor_index), 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_borrow_reward_distributor(arg5), v0, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(v7.amount), v7.borrow_compounded_interest)), arg6);
        emit_borrow_update_event(arg0, 0x1::vector::borrow<Borrow>(&arg0.loans, v2));
        let v8 = arg0.is_isolated_borrowed || 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::is_isolated(arg5);
        arg0.is_isolated_borrowed = v8;
        emit_position_update_event(arg0);
    }

    public(friend) fun add_token_collateral<T0>(arg0: &mut Position, arg1: u64, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market, arg3: 0x2::balance::Balance<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::XToken<T0>>, arg4: &0x2::clock::Clock) {
        let v0 = 0x2::balance::value<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::XToken<T0>>(&arg3);
        let v1 = v0;
        let v2 = 0x2::object::id<Position>(arg0);
        if (0x2::vec_map::contains<u64, u64>(&arg0.collaterals, &arg1)) {
            let v3 = 0x2::dynamic_field::borrow_mut<u64, TokenCollateral<T0>>(&mut arg0.id, arg1);
            0x2::balance::join<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::XToken<T0>>(&mut v3.x_token, arg3);
            let v4 = 0x2::balance::value<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::XToken<T0>>(&v3.x_token);
            v1 = v4;
            0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::rewards::change_user_share(0x1::vector::borrow_mut<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::rewards::UserRewardDistributor>(&mut arg0.reward_distributors, v3.reward_distributor_index), 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_deposit_reward_distributor(arg2), v2, v4, arg4);
            let (_, _) = 0x2::vec_map::remove<u64, u64>(&mut arg0.collaterals, &arg1);
            emit_token_collateral_update_event<T0>(arg0, 0x2::dynamic_field::borrow<u64, TokenCollateral<T0>>(&arg0.id, arg1));
        } else {
            let v7 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_deposit_reward_distributor(arg2);
            let v8 = find_or_add_user_reward_distributor(arg0, v7, arg4, true);
            let v9 = TokenCollateral<T0>{
                market_id                : arg1,
                x_token                  : arg3,
                reward_distributor_index : v8,
            };
            emit_token_collateral_update_event<T0>(arg0, &v9);
            0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::rewards::change_user_share(0x1::vector::borrow_mut<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::rewards::UserRewardDistributor>(&mut arg0.reward_distributors, v9.reward_distributor_index), 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_deposit_reward_distributor(arg2), v2, v0, arg4);
            0x2::dynamic_field::add<u64, TokenCollateral<T0>>(&mut arg0.id, arg1, v9);
        };
        0x2::vec_map::insert<u64, u64>(&mut arg0.collaterals, arg1, v1);
        emit_position_update_event(arg0);
    }

    public(friend) fun borrow_bluefin_lp_collateral(arg0: &mut Position) : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position {
        0x2::dynamic_field::remove<0x2::object::ID, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.id, 0x1::option::borrow<LpPositionCollateral>(&arg0.lp_collaterals).lp_position_id)
    }

    public(friend) fun borrowed_from_isolated(arg0: &Position) : bool {
        arg0.is_isolated_borrowed
    }

    public(friend) fun claim_rewards<T0>(arg0: &mut Position, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market, arg2: bool, arg3: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::XToken<T0>>, u64) {
        let v0 = 0x2::object::id<Position>(arg0);
        let v1 = 0;
        let v2 = if (arg2) {
            0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_deposit_reward_distributor(arg1)
        } else {
            0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_borrow_reward_distributor(arg1)
        };
        let v3 = 0x2::balance::zero<T0>();
        let v4 = 0x2::balance::zero<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::XToken<T0>>();
        let v5 = find_or_add_user_reward_distributor(arg0, v2, arg3, arg2);
        let v6 = 0x1::vector::borrow_mut<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::rewards::UserRewardDistributor>(&mut arg0.reward_distributors, v5);
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::rewards::refresh_user_reward_distributor(v6, v2, false, v0, arg3);
        let (v7, v8, v9, v10) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::rewards::claim_rewards<T0>(v6, v2, arg3);
        if (v8 > 0) {
            0x2::balance::join<T0>(&mut v3, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::rewards::remove_reward_balance<T0>(v2, v7, v8));
        };
        if (v10 > 0) {
            0x2::balance::join<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::XToken<T0>>(&mut v4, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::rewards::remove_reward_balance<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::XToken<T0>>(v2, v9, v10));
            v1 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::rewards::get_auto_compound_market_id(v2, v9);
        };
        (v3, v4, v1)
    }

    fun create_nft_url(arg0: vector<u8>) : 0x1::string::String {
        let v0 = b"https://api-staging.alphalend.xyz/nft/";
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(&arg0)) {
            let v3 = *0x1::vector::borrow<u8>(&arg0, v2);
            let v4 = v3 >> 4;
            let v5 = v3 & 15;
            let v6 = if (v4 < 10) {
                v4 + 48
            } else {
                v4 + 87
            };
            let v7 = if (v5 < 10) {
                v5 + 48
            } else {
                v5 + 87
            };
            0x1::vector::push_back<u8>(&mut v1, v6);
            0x1::vector::push_back<u8>(&mut v1, v7);
            v2 = v2 + 1;
        };
        0x1::vector::append<u8>(&mut v0, v1);
        0x1::string::utf8(v0)
    }

    public(friend) fun create_position(arg0: address, arg1: 0x1::option::Option<0x2::object::ID>, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) : (Position, PositionCap) {
        assert!(arg2 == 0, 9);
        let v0 = Position{
            id                                : 0x2::object::new(arg3),
            partner_id                        : arg1,
            lp_collaterals                    : 0x1::option::none<LpPositionCollateral>(),
            collaterals                       : 0x2::vec_map::empty<u64, u64>(),
            loans                             : 0x1::vector::empty<Borrow>(),
            total_collateral_usd              : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0),
            safe_collateral_usd               : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0),
            liquidation_value                 : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0),
            additional_permissible_borrow_usd : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0),
            total_loan_usd                    : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0),
            spot_total_loan_usd               : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0),
            weighted_total_loan_usd           : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0),
            weighted_spot_total_loan_usd      : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0),
            is_position_healthy               : true,
            is_position_liquidatable          : false,
            reward_distributors               : 0x1::vector::empty<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::rewards::UserRewardDistributor>(),
            is_isolated_borrowed              : false,
            last_refreshed                    : 0,
            position_type                     : arg2,
        };
        let v1 = PositionCap{
            id             : 0x2::object::new(arg3),
            position_id    : 0x2::object::id<Position>(&v0),
            client_address : arg0,
            image_url      : create_nft_url(0x2::object::uid_to_bytes(&v0.id)),
        };
        emit_position_create_event(&v0);
        (v0, v1)
    }

    fun emit_borrow_update_event(arg0: &Position, arg1: &Borrow) {
        let v0 = BorrowUpdateEvent{
            position_id                : 0x2::object::id<Position>(arg0),
            coin_type                  : arg1.coin_type,
            market_id                  : arg1.market_id,
            amount                     : arg1.amount,
            borrow_time                : arg1.borrow_time,
            borrow_compounded_interest : arg1.borrow_compounded_interest,
            reward_distributor_index   : arg1.reward_distributor_index,
        };
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::events::emit_event<BorrowUpdateEvent>(v0);
    }

    fun emit_position_collateral_update_event(arg0: &Position, arg1: &LpPositionCollateral) {
        let v0 = LPPositionCollateralUpdateEvent{
            position_id       : 0x2::object::id<Position>(arg0),
            pool_id           : arg1.pool_id,
            lp_position_id    : arg1.lp_position_id,
            usd_value         : arg1.usd_value,
            safe_usd_value    : arg1.safe_usd_value,
            liquidation_value : arg1.liquidation_value,
            liquidity         : arg1.liquidity,
            lp_type           : arg1.lp_type,
            last_updated      : arg1.last_updated,
        };
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::events::emit_event<LPPositionCollateralUpdateEvent>(v0);
    }

    fun emit_position_create_event(arg0: &Position) {
        let v0 = PositionCreateEvent{
            position_id : 0x2::object::id<Position>(arg0),
            partner_id  : arg0.partner_id,
        };
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::events::emit_event<PositionCreateEvent>(v0);
    }

    fun emit_position_update_event(arg0: &Position) {
        let v0 = PositionUpdateEvent{
            position_id                       : 0x2::object::id<Position>(arg0),
            partner_id                        : arg0.partner_id,
            total_collateral_usd              : arg0.total_collateral_usd,
            safe_collateral_usd               : arg0.safe_collateral_usd,
            liquidation_value                 : arg0.liquidation_value,
            additional_permissible_borrow_usd : arg0.additional_permissible_borrow_usd,
            total_loan_usd                    : arg0.total_loan_usd,
            spot_total_loan_usd               : arg0.spot_total_loan_usd,
            weighted_total_loan_usd           : arg0.weighted_total_loan_usd,
            weighted_spot_total_loan_usd      : arg0.weighted_spot_total_loan_usd,
            is_position_healthy               : arg0.is_position_healthy,
            is_position_liquidatable          : arg0.is_position_liquidatable,
            is_isolated_borrowed              : arg0.is_isolated_borrowed,
            last_refreshed                    : arg0.last_refreshed,
        };
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::events::emit_event<PositionUpdateEvent>(v0);
    }

    fun emit_token_collateral_update_event<T0>(arg0: &Position, arg1: &TokenCollateral<T0>) {
        let v0 = TokenCollateralUpdateEvent{
            position_id              : 0x2::object::id<Position>(arg0),
            coin_type                : 0x1::type_name::get<T0>(),
            market_id                : arg1.market_id,
            x_token_balance          : 0x2::balance::value<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::XToken<T0>>(&arg1.x_token),
            reward_distributor_index : arg1.reward_distributor_index,
        };
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::events::emit_event<TokenCollateralUpdateEvent>(v0);
    }

    fun find_borrow_by_market_id(arg0: &Position, arg1: u64) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Borrow>(&arg0.loans)) {
            if (0x1::vector::borrow<Borrow>(&arg0.loans, v0).market_id == arg1) {
                break
            };
            v0 = v0 + 1;
        };
        v0
    }

    fun find_or_add_user_reward_distributor(arg0: &mut Position, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::rewards::RewardDistributor, arg2: &0x2::clock::Clock, arg3: bool) : u64 {
        let v0 = find_user_reward_distributor(arg0, arg1);
        if (v0 == 0x1::vector::length<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::rewards::UserRewardDistributor>(&arg0.reward_distributors)) {
            let v1 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::rewards::create_user_reward_distributor(arg1, arg3, arg2);
            0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::rewards::refresh_user_reward_distributor(&mut v1, arg1, true, 0x2::object::id<Position>(arg0), arg2);
            0x1::vector::push_back<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::rewards::UserRewardDistributor>(&mut arg0.reward_distributors, v1);
        };
        v0
    }

    fun find_user_reward_distributor(arg0: &mut Position, arg1: &0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::rewards::RewardDistributor) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::rewards::UserRewardDistributor>(&arg0.reward_distributors)) {
            if (0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::rewards::get_reward_distributor_id(0x1::vector::borrow_mut<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::rewards::UserRewardDistributor>(&mut arg0.reward_distributors, v0)) == 0x2::object::id<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::rewards::RewardDistributor>(arg1)) {
                break
            };
            v0 = v0 + 1;
        };
        v0
    }

    public(friend) fun get_borrow_amount(arg0: &mut Position, arg1: &mut 0x2::table::Table<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>, arg2: &0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::oracle::Oracle, arg3: &0x2::clock::Clock, arg4: u64) : u64 {
        refresh(arg0, arg1, arg2, arg3);
        let v0 = find_borrow_by_market_id(arg0, arg4);
        if (v0 == 0x1::vector::length<Borrow>(&arg0.loans)) {
            0
        } else {
            0x1::vector::borrow<Borrow>(&arg0.loans, v0).amount
        }
    }

    public(friend) fun get_borrow_market_count(arg0: &Position) : u64 {
        0x1::vector::length<Borrow>(&arg0.loans)
    }

    public(friend) fun get_claimable_rewards(arg0: &mut Position, arg1: &mut 0x2::table::Table<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>, arg2: &0x2::clock::Clock) : vector<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::rewards::ClaimableReward> {
        let v0 = 0x1::vector::empty<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::rewards::ClaimableReward>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::rewards::UserRewardDistributor>(&arg0.reward_distributors)) {
            let v2 = 0x1::vector::borrow_mut<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::rewards::UserRewardDistributor>(&mut arg0.reward_distributors, v1);
            let v3 = if (0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::rewards::is_deposit_distributor(v2)) {
                0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_deposit_reward_distributor(0x2::table::borrow_mut<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(arg1, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::rewards::get_user_distributor_market_id(v2)))
            } else {
                0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_borrow_reward_distributor(0x2::table::borrow_mut<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(arg1, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::rewards::get_user_distributor_market_id(v2)))
            };
            0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::rewards::refresh_user_reward_distributor(v2, v3, false, 0x2::object::id<Position>(arg0), arg2);
            0x1::vector::append<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::rewards::ClaimableReward>(&mut v0, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::rewards::get_claimable_rewards(v2, v3, arg2));
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun get_collateral_amount(arg0: &mut Position, arg1: &mut 0x2::table::Table<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>, arg2: &0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::oracle::Oracle, arg3: &0x2::clock::Clock, arg4: u64) : u64 {
        if (!0x2::vec_map::contains<u64, u64>(&arg0.collaterals, &arg4)) {
            return 0
        };
        refresh(arg0, arg1, arg2, arg3);
        0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(*0x2::vec_map::get<u64, u64>(&arg0.collaterals, &arg4)), 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_xtoken_ratio(0x2::table::borrow<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(arg1, arg4))))
    }

    public(friend) fun get_collateral_xtoken_amount(arg0: &Position, arg1: u64) : u64 {
        if (0x2::vec_map::contains<u64, u64>(&arg0.collaterals, &arg1)) {
            *0x2::vec_map::get<u64, u64>(&arg0.collaterals, &arg1)
        } else {
            0
        }
    }

    public(friend) fun get_partner_id(arg0: &Position) : 0x1::option::Option<0x2::object::ID> {
        arg0.partner_id
    }

    public fun get_position_id(arg0: &PositionCap) : 0x2::object::ID {
        arg0.position_id
    }

    public(friend) fun get_position_type(arg0: &Position) : u8 {
        arg0.position_type
    }

    public(friend) fun get_position_type_normal() : u8 {
        0
    }

    public(friend) fun has_borrowed_from(arg0: &Position, arg1: u64) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Borrow>(&arg0.loans)) {
            if (0x1::vector::borrow<Borrow>(&arg0.loans, v0).market_id == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public(friend) fun has_borrows(arg0: &Position) : bool {
        0x1::vector::length<Borrow>(&arg0.loans) > 0
    }

    public(friend) fun has_deposited_to(arg0: &Position, arg1: u64) : bool {
        0x2::vec_map::contains<u64, u64>(&arg0.collaterals, &arg1)
    }

    public fun is_healthy(arg0: &Position) : bool {
        0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::ge(arg0.safe_collateral_usd, arg0.weighted_total_loan_usd)
    }

    public fun is_liquidatable(arg0: &Position, arg1: &0x2::clock::Clock) : bool {
        assert!(arg0.last_refreshed == 0x2::clock::timestamp_ms(arg1), 2);
        arg0.is_position_liquidatable
    }

    public(friend) fun liquidate<T0, T1>(arg0: &mut Position, arg1: &mut 0x2::table::Table<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>, arg2: u64, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: &0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::oracle::Oracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::XToken<T1>>, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number, 0x2::balance::Balance<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::XToken<T1>>, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>) {
        assert!(0x2::vec_map::contains<u64, u64>(&arg0.collaterals, &arg2), 1);
        assert!(is_liquidatable(arg0, arg6), 0);
        let v0 = 0x1::vector::borrow_mut<Borrow>(&mut arg0.loans, find_borrow_by_market_id(arg0, arg3));
        assert!(v0.coin_type == 0x1::type_name::get<T0>(), 1);
        let (v1, _) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_token_price(0x2::table::borrow<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(arg1, arg3), arg5);
        let v3 = 0x2::table::borrow_mut<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(arg1, v0.market_id);
        let (v4, _) = update_and_get_borrow_value(v0, v3, arg5, arg6);
        let v6 = if (0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::lt(arg0.spot_total_loan_usd, arg0.total_collateral_usd)) {
            0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_close_factor_percentage(0x2::table::borrow<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(arg1, arg2))
        } else {
            100
        };
        let v7 = if (0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::le(v4, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(5))) {
            0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::min(v4, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(v1, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0x2::coin::value<T0>(&arg4))))
        } else {
            0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::min(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::min(v4, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(arg0.spot_total_loan_usd, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_percentage((v6 as u16)))), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(v1, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0x2::coin::value<T0>(&arg4))))
        };
        let v8 = 0x2::table::borrow<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(arg1, arg2);
        let v9 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(v7, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_bps(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_liquidation_bonus_bps(v8)));
        let v10 = v9;
        let v11 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(v7, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_bps(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_liquidation_fee_bps(v8)));
        let v12 = v11;
        let v13 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::add(v7, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::add(v9, v11));
        let v14 = v13;
        let v15 = 0x2::dynamic_field::borrow_mut<u64, TokenCollateral<T1>>(&mut arg0.id, arg2);
        let v16 = 0x2::table::borrow_mut<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(arg1, arg2);
        let v17 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0x2::balance::value<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::XToken<T1>>(&v15.x_token)), 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_xtoken_spot_price(v16, arg5));
        let v18 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0x2::balance::value<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::XToken<T1>>(&v15.x_token));
        let v19 = v18;
        if (0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::lt(v17, v13)) {
            let v20 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(v17, v13);
            v14 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(v13, v20);
            v10 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(v9, v20);
            v12 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(v11, v20);
        } else {
            v19 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(v18, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(v13, v17));
        };
        let v21 = remove_token_collateral<T1>(arg0, arg2, v16, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(v19), arg6);
        let v22 = 0x2::coin::split<T0>(&mut arg4, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_token_count(0x2::table::borrow<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(arg1, arg3), arg5, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::sub(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::sub(v14, v10), v12))), arg7);
        let v23 = 0x2::table::borrow_mut<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(arg1, arg3);
        assert!(repay(arg0, 0x1::type_name::get<T0>(), arg3, v23, 0x2::coin::value<T0>(&v22), arg6) == 0x2::coin::value<T0>(&v22), 13906838761368453119);
        (v21, v14, v10, 0x2::balance::split<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::XToken<T1>>(&mut v21, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0x2::balance::value<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::XToken<T1>>(&v21)), v12), v14))), v22, arg4)
    }

    public(friend) fun liquidate_bluefin_lp_position<T0, T1, T2>(arg0: &mut Position, arg1: &mut 0x2::table::Table<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>, arg2: u64, arg3: 0x2::coin::Coin<T2>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::oracle::Oracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number, 0x2::coin::Coin<T2>, 0x2::coin::Coin<T2>, 0x2::object::ID, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x1::option::is_some<LpPositionCollateral>(&arg0.lp_collaterals), 1);
        assert!(is_liquidatable(arg0, arg7), 0);
        let v0 = 0x1::vector::borrow_mut<Borrow>(&mut arg0.loans, find_borrow_by_market_id(arg0, arg2));
        assert!(v0.coin_type == 0x1::type_name::get<T2>(), 1);
        let v1 = 0x2::table::borrow_mut<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(arg1, arg2);
        let (v2, _) = update_and_get_borrow_value(v0, v1, arg6, arg7);
        let v4 = if (0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::le(v2, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(1))) {
            0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::min(v2, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_token_spot_price(0x2::table::borrow<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(arg1, arg2), arg6), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0x2::coin::value<T2>(&arg3))))
        } else {
            0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::min(v2, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(arg0.spot_total_loan_usd, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_percentage((0x1::option::borrow<LpPositionCollateral>(&arg0.lp_collaterals).config.close_factor_percentage as u16))))
        };
        let v5 = 0x1::option::borrow<LpPositionCollateral>(&arg0.lp_collaterals);
        let v6 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(v4, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_bps(v5.config.liquidation_bonus));
        let v7 = v6;
        let v8 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(v4, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_bps(v5.config.liquidation_fee));
        let v9 = v8;
        let v10 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::add(v4, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::add(v6, v8));
        let v11 = v10;
        if (0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::lt(v5.usd_value, v10)) {
            let v12 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(v5.usd_value, v10);
            v11 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(v10, v12);
            v7 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(v6, v12);
            v9 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(v8, v12);
        };
        let v13 = 0x2::coin::split<T2>(&mut arg3, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_token_count(0x2::table::borrow<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(arg1, arg2), arg6, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::sub(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::sub(v11, v7), v9))), arg8);
        let v14 = 0x2::table::borrow_mut<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(arg1, arg2);
        let v15 = repay(arg0, 0x1::type_name::get<T2>(), arg2, v14, 0x2::coin::value<T2>(&v13), arg7);
        assert!(v15 == 0x2::coin::value<T2>(&v13), 13906839847995179007);
        let v16 = 0x2::dynamic_field::borrow_mut<0x2::object::ID, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.id, 0x1::option::borrow<LpPositionCollateral>(&arg0.lp_collaterals).lp_position_id);
        let v17 = 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v16);
        let v18 = 0x1::option::borrow<LpPositionCollateral>(&arg0.lp_collaterals);
        let (_, _, v21, v22) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T0, T1>(arg5, arg4, v16, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u128(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_u128(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(v16)), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::sub(v11, v9)), v18.usd_value)), arg7);
        let (_, _, v25, v26) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T0, T1>(arg5, arg4, v16, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u128(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_u128(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(v16)), v9), v18.usd_value)), arg7);
        (0x2::coin::from_balance<T0>(v21, arg8), 0x2::coin::from_balance<T1>(v22, arg8), v11, v7, v9, v13, arg3, v17, 0x2::coin::from_balance<T0>(v25, arg8), 0x2::coin::from_balance<T1>(v26, arg8))
    }

    public(friend) fun loan_writeoff(arg0: &mut Position, arg1: &mut 0x2::table::Table<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>, arg2: &0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::oracle::Oracle, arg3: &0x2::clock::Clock) {
        assert!(arg0.last_refreshed == 0x2::clock::timestamp_ms(arg3), 2);
        assert!(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::eq(arg0.total_collateral_usd, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0)), 6);
        let v0 = 0;
        while (v0 < 0x1::vector::length<Borrow>(&arg0.loans)) {
            let v1 = 0x1::vector::borrow_mut<Borrow>(&mut arg0.loans, v0);
            let v2 = 0x2::table::borrow_mut<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(arg1, v1.market_id);
            0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::refresh_with_price(v2, arg2, arg3);
            0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::writeoff_borrow(v2, v1.amount);
            repay(arg0, v1.coin_type, v1.market_id, v2, v1.amount, arg3);
            v0 = v0 + 1;
        };
    }

    public(friend) fun refresh(arg0: &mut Position, arg1: &mut 0x2::table::Table<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>, arg2: &0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::oracle::Oracle, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0x2::object::id<Position>(arg0);
        if (0x1::option::is_some<LpPositionCollateral>(&arg0.lp_collaterals)) {
            assert!(v0 - 0x1::option::borrow<LpPositionCollateral>(&arg0.lp_collaterals).last_updated <= 20, 7);
        };
        let v2 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0);
        let v3 = v2;
        let v4 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0);
        let v5 = v4;
        let v6 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0);
        let v7 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0);
        let v8 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0);
        let v9 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0);
        let v10 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0);
        let v11 = v10;
        if (0x1::option::is_some<LpPositionCollateral>(&arg0.lp_collaterals)) {
            let v12 = 0x1::option::borrow<LpPositionCollateral>(&arg0.lp_collaterals);
            v3 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::add(v2, v12.usd_value);
            v11 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::add(v10, v12.safe_usd_value);
            v5 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::add(v4, v12.liquidation_value);
        };
        let v13 = 0;
        while (v13 < 0x2::vec_map::size<u64, u64>(&arg0.collaterals)) {
            let (v14, v15) = 0x2::vec_map::get_entry_by_idx<u64, u64>(&arg0.collaterals, v13);
            let v16 = 0x2::table::borrow_mut<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(arg1, *v14);
            0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::refresh_with_price(v16, arg2, arg3);
            let v17 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(*v15), 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_xtoken_price(v16, arg2));
            v3 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::add(v3, v17);
            v5 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::add(v5, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_liquidation_value(v16, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(*v15), 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_xtoken_spot_price(v16, arg2))));
            v11 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::add(v11, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_ltv_value(v16, v17));
            let v18 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_deposit_reward_distributor(v16);
            let v19 = find_or_add_user_reward_distributor(arg0, v18, arg3, true);
            0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::rewards::refresh_user_reward_distributor(0x1::vector::borrow_mut<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::rewards::UserRewardDistributor>(&mut arg0.reward_distributors, v19), v18, false, v1, arg3);
            v13 = v13 + 1;
        };
        let v20 = 0;
        while (v20 < 0x1::vector::length<Borrow>(&arg0.loans)) {
            let v21 = 0x1::vector::borrow_mut<Borrow>(&mut arg0.loans, v20);
            let v22 = 0x2::table::borrow_mut<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(arg1, v21.market_id);
            let (v23, v24) = update_and_get_borrow_value(v21, v22, arg2, arg3);
            let v25 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::max(v23, v24);
            let v26 = 0x2::table::borrow_mut<u64, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market>(arg1, v21.market_id);
            let v27 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_borrow_weight(v26);
            v6 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::add(v6, v25);
            v7 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::add(v7, v23);
            v8 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::add(v8, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(v25, v27));
            v9 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::add(v9, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(v23, v27));
            let v28 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_borrow_reward_distributor(v26);
            let v29 = find_or_add_user_reward_distributor(arg0, v28, arg3, false);
            0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::rewards::refresh_user_reward_distributor(0x1::vector::borrow_mut<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::rewards::UserRewardDistributor>(&mut arg0.reward_distributors, v29), v28, false, v1, arg3);
            v20 = v20 + 1;
        };
        arg0.total_collateral_usd = v3;
        arg0.liquidation_value = v5;
        arg0.total_loan_usd = v6;
        arg0.spot_total_loan_usd = v7;
        arg0.weighted_total_loan_usd = v8;
        arg0.weighted_spot_total_loan_usd = v9;
        let v30 = if (0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::gt(v8, v11)) {
            0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0)
        } else {
            0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::sub(v11, v8)
        };
        arg0.additional_permissible_borrow_usd = v30;
        arg0.safe_collateral_usd = v11;
        arg0.is_position_liquidatable = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::gt(v9, v5);
        arg0.is_position_healthy = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::ge(v11, v8);
        arg0.last_refreshed = v0;
        emit_position_update_event(arg0);
    }

    public(friend) fun remove_bluefin_lp_collateral(arg0: &mut Position) : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position {
        let v0 = 0x1::option::borrow<LpPositionCollateral>(&arg0.lp_collaterals);
        assert!(0x1::vector::length<Borrow>(&arg0.loans) == 0, 4);
        let v1 = 0x2::dynamic_field::remove<0x2::object::ID, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.id, v0.lp_position_id);
        let LpPositionCollateral {
            pool_id           : _,
            lp_position_id    : _,
            usd_value         : _,
            safe_usd_value    : _,
            liquidation_value : _,
            liquidity         : _,
            config            : _,
            last_updated      : _,
            lp_type           : _,
        } = 0x1::option::extract<LpPositionCollateral>(&mut arg0.lp_collaterals);
        v1
    }

    public(friend) fun remove_token_collateral<T0>(arg0: &mut Position, arg1: u64, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market, arg3: u64, arg4: &0x2::clock::Clock) : 0x2::balance::Balance<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::XToken<T0>> {
        assert!(0x2::vec_map::contains<u64, u64>(&arg0.collaterals, &arg1), 13906837670446759935);
        let v0 = 0x2::dynamic_field::borrow_mut<u64, TokenCollateral<T0>>(&mut arg0.id, arg1);
        assert!(0x2::balance::value<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::XToken<T0>>(&v0.x_token) >= arg3, 3);
        let v1 = 0x2::balance::split<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::XToken<T0>>(&mut v0.x_token, arg3);
        let v2 = 0x2::balance::value<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::XToken<T0>>(&v0.x_token);
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::rewards::change_user_share(0x1::vector::borrow_mut<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::rewards::UserRewardDistributor>(&mut arg0.reward_distributors, v0.reward_distributor_index), 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_deposit_reward_distributor(arg2), 0x2::object::id<Position>(arg0), v2, arg4);
        if (v2 == 0) {
            let (_, _) = 0x2::vec_map::remove<u64, u64>(&mut arg0.collaterals, &arg1);
            let v5 = 0x2::dynamic_field::remove<u64, TokenCollateral<T0>>(&mut arg0.id, arg1);
            emit_token_collateral_update_event<T0>(arg0, &v5);
            let TokenCollateral {
                market_id                : _,
                x_token                  : v7,
                reward_distributor_index : _,
            } = v5;
            0x2::balance::destroy_zero<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::XToken<T0>>(v7);
            return v1
        };
        emit_token_collateral_update_event<T0>(arg0, 0x2::dynamic_field::borrow<u64, TokenCollateral<T0>>(&arg0.id, arg1));
        let (_, _) = 0x2::vec_map::remove<u64, u64>(&mut arg0.collaterals, &arg1);
        0x2::vec_map::insert<u64, u64>(&mut arg0.collaterals, arg1, v2);
        v1
    }

    public(friend) fun repay(arg0: &mut Position, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market, arg4: u64, arg5: &0x2::clock::Clock) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Borrow>(&arg0.loans)) {
            let v1 = 0x1::vector::borrow_mut<Borrow>(&mut arg0.loans, v0);
            if (v1.market_id != arg2) {
                v0 = v0 + 1;
                continue
            };
            assert!(v1.coin_type == arg1, 13906838190137802751);
            update_and_get_borrow_amount(v1, arg3);
            if (arg4 >= v1.amount) {
                let v2 = 0x1::vector::remove<Borrow>(&mut arg0.loans, v0);
                0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::rewards::change_user_share(0x1::vector::borrow_mut<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::rewards::UserRewardDistributor>(&mut arg0.reward_distributors, v2.reward_distributor_index), 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_borrow_reward_distributor(arg3), 0x2::object::id<Position>(arg0), 0, arg5);
                emit_borrow_update_event(arg0, &v2);
                let Borrow {
                    coin_type                  : _,
                    market_id                  : _,
                    amount                     : v5,
                    borrow_time                : _,
                    borrow_compounded_interest : _,
                    reward_distributor_index   : _,
                } = v2;
                emit_position_update_event(arg0);
                return v5
            };
            v1.amount = v1.amount - arg4;
            0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::rewards::change_user_share(0x1::vector::borrow_mut<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::rewards::UserRewardDistributor>(&mut arg0.reward_distributors, v1.reward_distributor_index), 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_borrow_reward_distributor(arg3), 0x2::object::id<Position>(arg0), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(v1.amount), v1.borrow_compounded_interest)), arg5);
            emit_borrow_update_event(arg0, 0x1::vector::borrow<Borrow>(&arg0.loans, v0));
            emit_position_update_event(arg0);
            return arg4
        };
        0
    }

    public(friend) fun return_bluefin_lp_collateral<T0, T1>(arg0: &mut Position, arg1: 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position, arg2: &0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::oracle::Oracle, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock) {
        let v0 = 0x1::option::borrow<LpPositionCollateral>(&arg0.lp_collaterals);
        assert!(v0.lp_position_id == 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg1), 8);
        0x2::dynamic_field::add<0x2::object::ID, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.id, v0.lp_position_id, arg1);
        update_bluefin_lp_collateral_usd_value<T0, T1>(arg0, arg3, arg2, arg4);
    }

    public(friend) fun update_and_get_borrow_amount(arg0: &mut Borrow, arg1: &0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market) : u64 {
        if (0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_last_auto_compound(arg1) == arg0.borrow_time) {
            return arg0.amount
        };
        arg0.amount = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg0.amount), 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_compounded_interest(arg1)), arg0.borrow_compounded_interest));
        arg0.borrow_time = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_last_auto_compound(arg1);
        arg0.borrow_compounded_interest = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_compounded_interest(arg1);
        arg0.amount
    }

    public(friend) fun update_and_get_borrow_value(arg0: &mut Borrow, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::Market, arg2: &0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::oracle::Oracle, arg3: &0x2::clock::Clock) : (0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number) {
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::refresh_with_price(arg1, arg2, arg3);
        let (v0, v1) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::market::get_token_price(arg1, arg2);
        let v2 = update_and_get_borrow_amount(arg0, arg1);
        (0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(v2), v0), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(v2), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::max(v0, v1)))
    }

    public(friend) fun update_bluefin_lp_collateral_usd_value<T0, T1>(arg0: &mut Position, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: &0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::oracle::Oracle, arg3: &0x2::clock::Clock) {
        let v0 = 0x1::option::borrow_mut<LpPositionCollateral>(&mut arg0.lp_collaterals);
        let v1 = 0x2::dynamic_field::borrow<0x2::object::ID, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg0.id, v0.lp_position_id);
        assert!(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::pool_id(v1) == 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg1), 5);
        let (v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::clmm_math::get_amount_by_liquidity(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::lower_tick(v1), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::upper_tick(v1), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg1), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg1), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(v1), false);
        let v4 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::oracle::get_price_identifier(arg2, 0x1::type_name::get<T0>());
        let (v5, v6) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::oracle::get_price(arg2, &v4);
        let v7 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::oracle::get_price_identifier(arg2, 0x1::type_name::get<T1>());
        let (v8, v9) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::oracle::get_price(arg2, &v7);
        v0.usd_value = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::add(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(v2), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::min(v5, v6)), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(v3), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::min(v8, v9)));
        v0.safe_usd_value = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(v0.usd_value, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_percentage((v0.config.safe_collateral_ratio as u16)));
        v0.liquidation_value = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::add(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(v2), v5), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(v3), v8)), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_percentage((v0.config.liquidation_threshold as u16)));
        v0.liquidity = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(v1);
        v0.last_updated = 0x2::clock::timestamp_ms(arg3);
        emit_position_collateral_update_event(arg0, 0x1::option::borrow<LpPositionCollateral>(&arg0.lp_collaterals));
    }

    public(friend) fun update_lp_position_close_factor(arg0: &mut Position, arg1: u8) {
        0x1::option::borrow_mut<LpPositionCollateral>(&mut arg0.lp_collaterals).config.close_factor_percentage = arg1;
    }

    public(friend) fun update_lp_position_config(arg0: &mut Position, arg1: u8, arg2: u8, arg3: u64, arg4: u64, arg5: u8) {
        let v0 = 0x1::option::borrow_mut<LpPositionCollateral>(&mut arg0.lp_collaterals);
        v0.config.safe_collateral_ratio = arg1;
        v0.config.liquidation_threshold = arg2;
        v0.config.liquidation_bonus = arg3;
        v0.config.liquidation_fee = arg4;
        v0.config.close_factor_percentage = arg5;
    }

    // decompiled from Move bytecode v6
}

