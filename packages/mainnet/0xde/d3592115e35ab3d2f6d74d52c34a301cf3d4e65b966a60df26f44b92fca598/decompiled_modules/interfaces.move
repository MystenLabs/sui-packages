module 0xded3592115e35ab3d2f6d74d52c34a301cf3d4e65b966a60df26f44b92fca598::interfaces {
    struct TokenLiquidityInfo has copy, drop {
        dola_pool_id: u16,
        token_liquidity: u256,
    }

    struct AppLiquidityInfo has copy, drop {
        app_id: u16,
        dola_pool_id: u16,
        token_liquidity: u256,
    }

    struct PoolLiquidityInfo has copy, drop {
        pool_address: 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::DolaAddress,
        pool_liquidity: u256,
        pool_equilibrium_fee: u256,
        pool_weight: u256,
    }

    struct LiquidityEquilibriumReward has copy, drop {
        reward: u256,
    }

    struct LiquidityEquilibriumFee has copy, drop {
        fee: u256,
    }

    struct AllPoolLiquidityInfo has copy, drop {
        pool_infos: vector<PoolLiquidityInfo>,
    }

    struct LendingReserveInfo has copy, drop {
        dola_pool_id: u16,
        pools: vector<PoolLiquidityInfo>,
        total_pool_weight: u256,
        collateral_coefficient: u256,
        borrow_coefficient: u256,
        borrow_apy: u256,
        supply_apy: u256,
        reserve: u256,
        available_value: u256,
        supply: u256,
        supply_value: u256,
        debt: u256,
        debt_value: u256,
        current_isolate_debt: u256,
        isolate_debt_ceiling: u256,
        is_isolate_asset: bool,
        borrowable_in_isolation: bool,
        utilization_rate: u256,
    }

    struct AllReserveInfo has copy, drop {
        total_market_size: u256,
        total_available: u256,
        total_borrows: u256,
        reserve_infos: vector<LendingReserveInfo>,
    }

    struct UserLendingInfo has copy, drop {
        health_factor: u256,
        profit_state: bool,
        net_apy: u256,
        total_supply_apy: u256,
        total_borrow_apy: u256,
        liquid_asset_infos: vector<UserLiquidAssetInfo>,
        total_liquid_value: u256,
        collateral_infos: vector<UserCollateralInfo>,
        total_collateral_value: u256,
        debt_infos: vector<UserDebtInfo>,
        total_debt_value: u256,
        isolation_mode: bool,
    }

    struct UserLiquidAssetInfo has copy, drop {
        dola_pool_id: u16,
        borrow_apy: u256,
        supply_apy: u256,
        liquid_amount: u256,
        liquid_value: u256,
    }

    struct UserCollateralInfo has copy, drop {
        dola_pool_id: u16,
        borrow_apy: u256,
        supply_apy: u256,
        collateral_amount: u256,
        collateral_value: u256,
    }

    struct UserDebtInfo has copy, drop {
        dola_pool_id: u16,
        borrow_apy: u256,
        supply_apy: u256,
        debt_amount: u256,
        debt_value: u256,
    }

    struct UserAllowedBorrow has copy, drop {
        borrow_token: vector<u8>,
        max_borrow_amount: u256,
        max_borrow_value: u256,
        borrow_amount: u256,
        borrow_value: u256,
    }

    struct UserAllowedWithdraw has copy, drop {
        withdraw_token: vector<u8>,
        max_withdraw_amount: u256,
        max_withdraw_value: u256,
        withdraw_amount: u256,
        withdraw_value: u256,
    }

    struct UserTotalAllowedBorrow has copy, drop {
        total_allowed_borrow: vector<UserTotalBorrowInfo>,
    }

    struct UserTotalBorrowInfo has copy, drop {
        dola_pool_id: u16,
        total_avaliable_borrow_amount: u256,
        total_avaliable_borrow_value: u256,
    }

    struct DolaPoolId has copy, drop {
        dola_pool_id: u16,
    }

    struct DolaUserId has copy, drop {
        dola_user_id: u64,
    }

    struct DolaUserAddresses has copy, drop {
        dola_user_addresses: vector<0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::DolaAddress>,
    }

    struct UserHealthFactor has copy, drop {
        health_factor: u256,
    }

    struct UserAllDebts has copy, drop {
        dola_pool_ids: vector<u16>,
    }

    struct UserAllCollaterals has copy, drop {
        dola_pool_ids: vector<u16>,
    }

    struct TokenPrice has copy, drop {
        dola_pool_id: u16,
        price: u256,
        decimal: u8,
    }

    struct AllTokenPrice has copy, drop {
        token_prices: vector<TokenPrice>,
    }

    struct LiquidationDiscount has copy, drop {
        discount: u256,
    }

    struct FeedTokens has copy, drop {
        feed_pool_ids: vector<u16>,
        skip_pool_ids: vector<u16>,
    }

    struct RewardPoolApy has copy, drop {
        reward_pool_info: address,
        apy: u256,
    }

    struct RewardPoolApys has copy, drop {
        apys: vector<RewardPoolApy>,
    }

    struct UserTotalRewardInfo has copy, drop {
        total_reward: u256,
        total_reward_value: u256,
        total_unclaimed_reward: u256,
        total_unclaimed_reward_value: u256,
        user_reward_infos: vector<UserRewardInfo>,
    }

    struct UserRewardInfo has copy, drop {
        dola_pool_id: u16,
        action: u8,
        reward_pool_info: address,
        unclaimed_reward: u256,
        unclaimed_reward_value: u256,
        claimed_reward: u256,
        claimed_reward_value: u256,
    }

    struct UserLiquidationQueryInfo has copy, drop {
        dola_user_id: u64,
        evm_address: vector<u8>,
        sui_address: vector<u8>,
        liquid_assets: vector<UserLiquidAssetInfo>,
        collaterals: vector<UserCollateralInfo>,
        debts: vector<UserDebtInfo>,
    }

    struct PoolLiquidationInfo has copy, drop {
        dola_pool_id: u16,
        pool_name: vector<u8>,
        total_liquidity: u256,
        available_liquidity: u256,
    }

    struct LiquidationPrice has copy, drop {
        dola_pool_id: u16,
        price: u256,
    }

    struct LiquidationPrices has copy, drop {
        prices: vector<LiquidationPrice>,
    }

    public entry fun get_pool_liquidity(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::PoolManagerInfo, arg1: u16, arg2: vector<u8>) {
        let v0 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::create_dola_address(arg1, arg2);
        let v1 = PoolLiquidityInfo{
            pool_address         : v0,
            pool_liquidity       : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::get_pool_liquidity(arg0, v0),
            pool_equilibrium_fee : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::get_pool_equilibrium_fee(arg0, v0),
            pool_weight          : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::get_pool_weight(arg0, v0),
        };
        0x2::event::emit<PoolLiquidityInfo>(v1);
    }

    public entry fun get_dola_user_id(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::user_manager::UserManagerInfo, arg1: u16, arg2: vector<u8>) {
        let v0 = DolaUserId{dola_user_id: 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::user_manager::get_dola_user_id(arg0, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::create_dola_address(arg1, arg2))};
        0x2::event::emit<DolaUserId>(v0);
    }

    public fun all_pool_liquidity(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::PoolManagerInfo, arg1: u16) : vector<PoolLiquidityInfo> {
        let v0 = 0x1::vector::empty<PoolLiquidityInfo>();
        if (0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::exist_pool_id(arg0, arg1)) {
            let v1 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::get_pools_by_id(arg0, arg1);
            let v2 = 0;
            while (v2 < 0x1::vector::length<0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::DolaAddress>(&v1)) {
                let v3 = *0x1::vector::borrow<0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::DolaAddress>(&v1, v2);
                let v4 = PoolLiquidityInfo{
                    pool_address         : v3,
                    pool_liquidity       : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::get_pool_liquidity(arg0, v3),
                    pool_equilibrium_fee : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::get_pool_equilibrium_fee(arg0, v3),
                    pool_weight          : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::get_pool_weight(arg0, v3),
                };
                0x1::vector::push_back<PoolLiquidityInfo>(&mut v0, v4);
                v2 = v2 + 1;
            };
        };
        v0
    }

    public entry fun calculate_changed_health_factor(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::PriceOracle, arg2: u64, arg3: u16, arg4: u256, arg5: bool, arg6: bool, arg7: bool, arg8: bool, arg9: bool, arg10: bool) {
        if (!0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::exist_user_info(arg0, arg2)) {
            let v0 = UserHealthFactor{health_factor: 115792089237316195423570985008687907853269984665640564039457584007913129639935};
            0x2::event::emit<UserHealthFactor>(v0);
            return
        };
        let v1 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::user_health_collateral_value(arg0, arg1, arg2);
        let v2 = v1;
        let v3 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::user_health_loan_value(arg0, arg1, arg2);
        let v4 = v3;
        let v5 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_collateral_coefficient(arg0, arg3);
        let v6 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_borrow_coefficient(arg0, arg3);
        if (arg5) {
            v2 = v1 + 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_mul(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::calculate_value(arg1, arg3, arg4), v5);
        };
        if (arg6) {
            v4 = v3 + 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_mul(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::calculate_value(arg1, arg3, arg4), v6);
        };
        if (arg7) {
            let v7 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::min(arg4, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::user_collateral_balance(arg0, arg2, arg3));
            arg4 = v7;
            v2 = v2 - 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_mul(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::calculate_value(arg1, arg3, v7), v5);
        };
        if (arg8) {
            let v8 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::user_loan_balance(arg0, arg2, arg3);
            let v9 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::min(arg4, v8);
            v4 = v4 - 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_mul(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::calculate_value(arg1, arg3, v9), v6);
            if (v9 > v8) {
                v2 = v2 + 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_mul(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::calculate_value(arg1, arg3, v9 - v8), v5);
            };
        };
        if (arg9) {
            v2 = v2 + 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_mul(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::user_collateral_value(arg0, arg1, arg2, arg3), v5);
        };
        if (arg10) {
            v2 = v2 - 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_mul(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::user_collateral_value(arg0, arg1, arg2, arg3), v5);
        };
        let v10 = if (v4 > 0) {
            0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_div(v2, v4)
        } else {
            115792089237316195423570985008687907853269984665640564039457584007913129639935
        };
        let v11 = UserHealthFactor{health_factor: v10};
        0x2::event::emit<UserHealthFactor>(v11);
    }

    public entry fun get_all_oracle_price(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::PriceOracle) {
        let v0 = 0x1::vector::empty<TokenPrice>();
        let v1 = 0;
        while (v1 < 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_reserve_length(arg0)) {
            let v2 = (v1 as u16);
            let (v3, v4, _) = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::get_token_price(arg1, v2);
            let v6 = TokenPrice{
                dola_pool_id : v2,
                price        : v3,
                decimal      : v4,
            };
            0x1::vector::push_back<TokenPrice>(&mut v0, v6);
            v1 = v1 + 1;
        };
        let v7 = AllTokenPrice{token_prices: v0};
        0x2::event::emit<AllTokenPrice>(v7);
    }

    public entry fun get_all_pool_liquidity(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::PoolManagerInfo, arg1: u16) {
        let v0 = AllPoolLiquidityInfo{pool_infos: all_pool_liquidity(arg0, arg1)};
        0x2::event::emit<AllPoolLiquidityInfo>(v0);
    }

    public entry fun get_all_reserve_info(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::PoolManagerInfo, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::PriceOracle, arg2: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage) {
        let v0 = 0x1::vector::empty<LendingReserveInfo>();
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        while (v4 < 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_reserve_length(arg2)) {
            let v5 = (v4 as u16);
            let v6 = all_pool_liquidity(arg0, v5);
            let v7 = if (0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::exist_pool_id(arg0, v5)) {
                0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::get_pool_total_weight(arg0, v5)
            } else {
                0
            };
            let v8 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::total_otoken_supply(arg2, v5);
            let v9 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::calculate_value(arg1, v5, v8);
            let v10 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::total_dtoken_supply(arg2, v5);
            let v11 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::calculate_value(arg1, v5, v10);
            let v12 = if (0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::exist_pool_id(arg0, v5)) {
                0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::get_app_liquidity(arg0, v5, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_app_id(arg2))
            } else {
                0
            };
            let v13 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::calculate_value(arg1, v5, v12);
            let v14 = 0;
            if (v10 > 0) {
                v14 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::rates::calculate_utilization(arg2, v5, v12) * 10000 / 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray();
            };
            let v15 = LendingReserveInfo{
                dola_pool_id            : v5,
                pools                   : v6,
                total_pool_weight       : v7,
                collateral_coefficient  : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_collateral_coefficient(arg2, v5),
                borrow_coefficient      : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_borrow_coefficient(arg2, v5),
                borrow_apy              : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_borrow_rate(arg2, v5) * 10000 / 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray(),
                supply_apy              : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_liquidity_rate(arg2, v5) * 10000 / 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray(),
                reserve                 : v12,
                available_value         : v13,
                supply                  : v8,
                supply_value            : v9,
                debt                    : v10,
                debt_value              : v11,
                current_isolate_debt    : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_isolate_debt(arg2, v5),
                isolate_debt_ceiling    : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_reserve_borrow_ceiling(arg2, v5),
                is_isolate_asset        : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::is_isolated_asset(arg2, v5),
                borrowable_in_isolation : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::can_borrow_in_isolation(arg2, v5),
                utilization_rate        : v14,
            };
            0x1::vector::push_back<LendingReserveInfo>(&mut v0, v15);
            v1 = v1 + v9;
            v2 = v2 + v13;
            v3 = v3 + v11;
            v4 = v4 + 1;
        };
        let v16 = AllReserveInfo{
            total_market_size : v1,
            total_available   : v2,
            total_borrows     : v3,
            reserve_infos     : v0,
        };
        0x2::event::emit<AllReserveInfo>(v16);
    }

    public entry fun get_app_token_liquidity(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::PoolManagerInfo, arg1: u16, arg2: u16) {
        let v0 = AppLiquidityInfo{
            app_id          : arg1,
            dola_pool_id    : arg2,
            token_liquidity : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::get_app_liquidity(arg0, arg2, arg1),
        };
        0x2::event::emit<AppLiquidityInfo>(v0);
    }

    public fun get_dola_pool_id(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::PoolManagerInfo, arg1: u16, arg2: vector<u8>) {
        let v0 = DolaPoolId{dola_pool_id: 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::get_id_by_pool(arg0, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::create_dola_address(arg1, arg2))};
        0x2::event::emit<DolaPoolId>(v0);
    }

    public entry fun get_dola_token_liquidity(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::PoolManagerInfo, arg1: u16) {
        let v0 = TokenLiquidityInfo{
            dola_pool_id    : arg1,
            token_liquidity : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::get_token_liquidity(arg0, arg1),
        };
        0x2::event::emit<TokenLiquidityInfo>(v0);
    }

    public entry fun get_dola_user_addresses(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::user_manager::UserManagerInfo, arg1: u64) {
        let v0 = DolaUserAddresses{dola_user_addresses: 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::user_manager::get_user_addresses(arg0, arg1)};
        0x2::event::emit<DolaUserAddresses>(v0);
    }

    public fun get_dola_user_addresses_with_return(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::user_manager::UserManagerInfo, arg1: u64) : DolaUserAddresses {
        DolaUserAddresses{dola_user_addresses: 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::user_manager::get_user_addresses(arg0, arg1)}
    }

    public entry fun get_equilibrium_fee(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::PoolManagerInfo, arg1: u16, arg2: vector<u8>, arg3: u256) {
        let v0 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::create_dola_address(arg1, arg2);
        let v1 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::get_id_by_pool(arg0, v0);
        let v2 = LiquidityEquilibriumFee{fee: 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::equilibrium_fee::calculate_equilibrium_fee(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::get_token_liquidity(arg0, v1), 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::get_pool_liquidity(arg0, v0), arg3, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::equilibrium_fee::calculate_expected_ratio(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::get_pool_total_weight(arg0, v1), 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::get_pool_weight(arg0, v0)), 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::get_default_alpha_1(), 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::get_default_lambda_1())};
        0x2::event::emit<LiquidityEquilibriumFee>(v2);
    }

    public entry fun get_equilibrium_reward(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::PoolManagerInfo, arg1: u16, arg2: vector<u8>, arg3: u256) {
        let v0 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::create_dola_address(arg1, arg2);
        let v1 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::get_id_by_pool(arg0, v0);
        let v2 = LiquidityEquilibriumReward{reward: 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::equilibrium_fee::calculate_equilibrium_reward(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::get_token_liquidity(arg0, v1), 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::get_pool_liquidity(arg0, v0), arg3, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::equilibrium_fee::calculate_expected_ratio(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::get_pool_total_weight(arg0, v1), 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::get_pool_weight(arg0, v0)), 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::get_pool_equilibrium_fee(arg0, v0), 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::get_default_lambda_1())};
        0x2::event::emit<LiquidityEquilibriumReward>(v2);
    }

    public entry fun get_feed_tokens(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::PriceOracle, arg2: u64, arg3: bool, arg4: u16, arg5: &0x2::clock::Clock) {
        let v0 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_user_loans(arg0, arg2);
        let v1 = vector[];
        let v2 = vector[];
        if (arg3) {
            if (!0x1::vector::contains<u16>(&v0, &arg4)) {
                0x1::vector::push_back<u16>(&mut v1, arg4);
            };
            0x1::vector::append<u16>(&mut v1, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_user_collaterals(arg0, arg2));
            0x1::vector::append<u16>(&mut v1, v0);
        } else if (0x1::vector::length<u16>(&v0) > 0) {
            0x1::vector::append<u16>(&mut v1, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_user_collaterals(arg0, arg2));
            0x1::vector::append<u16>(&mut v1, v0);
        };
        let v3 = 0x2::clock::timestamp_ms(arg5) / 1000;
        let v4 = 1;
        let (_, _, v7) = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::get_token_price(arg1, v4);
        if (v3 - v7 < 3600 - 60) {
            0x1::vector::push_back<u16>(&mut v2, v4);
        };
        let v8 = 2;
        let (_, _, v11) = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::get_token_price(arg1, v8);
        if (v3 - v11 < 3600 - 60) {
            0x1::vector::push_back<u16>(&mut v2, v8);
        };
        let v12 = FeedTokens{
            feed_pool_ids : v1,
            skip_pool_ids : v2,
        };
        0x2::event::emit<FeedTokens>(v12);
    }

    public fun get_feed_tokens_for_relayer(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::PoolManagerInfo, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::user_manager::UserManagerInfo, arg2: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg3: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg4: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::PriceOracle, arg5: vector<u8>, arg6: bool, arg7: bool, arg8: bool, arg9: &0x2::clock::Clock) : (vector<u16>, vector<u16>) {
        let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::take_payload(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg2, arg5, arg9));
        let v1 = vector[];
        let v2 = vector[];
        if (arg6) {
            let (v3, _, _, v6) = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_codec::decode_send_message_payload(v0);
            let (_, _, _, v10, _, v12) = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_codec::decode_withdraw_payload(v6);
            let v13 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::get_id_by_pool(arg0, v10);
            let v14 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::user_manager::get_dola_user_id(arg1, v3);
            let v15 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_user_loans(arg3, v14);
            if (!0x1::vector::contains<u16>(&v15, &v13)) {
                0x1::vector::push_back<u16>(&mut v1, v13);
            };
            if (0x1::vector::length<u16>(&v15) > 0 || v12 == 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_codec::get_borrow_type()) {
                0x1::vector::append<u16>(&mut v1, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_user_collaterals(arg3, v14));
                0x1::vector::append<u16>(&mut v1, v15);
            };
        };
        if (arg7) {
            let (v16, _, _, v19) = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_codec::decode_send_message_payload(v0);
            let (_, _, _, v23, _, _) = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_codec::decode_liquidate_payload_v2(v19);
            let v26 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::user_manager::get_dola_user_id(arg1, v16);
            0x1::vector::append<u16>(&mut v1, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_user_collaterals(arg3, v26));
            0x1::vector::append<u16>(&mut v1, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_user_loans(arg3, v26));
            0x1::vector::append<u16>(&mut v1, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_user_collaterals(arg3, v23));
            0x1::vector::append<u16>(&mut v1, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_user_loans(arg3, v23));
        };
        if (arg8) {
            let (v27, _, _, _) = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_codec::decode_send_message_payload(v0);
            let v31 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::user_manager::get_dola_user_id(arg1, v27);
            let v32 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_user_loans(arg3, v31);
            if (0x1::vector::length<u16>(&v32) > 0) {
                0x1::vector::append<u16>(&mut v1, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_user_collaterals(arg3, v31));
                0x1::vector::append<u16>(&mut v1, v32);
            };
        };
        let v33 = 0x2::clock::timestamp_ms(arg9) / 1000;
        let v34 = 1;
        let (_, _, v37) = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::get_token_price(arg4, v34);
        if (v33 - v37 < 3600 - 60) {
            0x1::vector::push_back<u16>(&mut v2, v34);
        };
        let v38 = 2;
        let (_, _, v41) = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::get_token_price(arg4, v38);
        if (v33 - v41 < 3600 - 60) {
            0x1::vector::push_back<u16>(&mut v2, v38);
        };
        (v1, v2)
    }

    public entry fun get_liquidation_discount(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::PriceOracle, arg2: u64, arg3: u64) {
        let v0 = LiquidationDiscount{discount: 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::calculate_liquidation_discount(arg0, arg1, arg2, arg3)};
        0x2::event::emit<LiquidationDiscount>(v0);
    }

    public entry fun get_oracle_price(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::PriceOracle, arg1: u16) {
        let (v0, v1, _) = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::get_token_price(arg0, arg1);
        let v3 = TokenPrice{
            dola_pool_id : arg1,
            price        : v0,
            decimal      : v1,
        };
        0x2::event::emit<TokenPrice>(v3);
    }

    public entry fun get_pool_liquidation_info(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg1: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::PriceOracle, arg2: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::PoolManagerInfo, arg3: u16) {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x1::ascii::into_bytes(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::get_pool_name_by_id(arg2, arg3)));
        let v1 = PoolLiquidationInfo{
            dola_pool_id        : arg3,
            pool_name           : v0,
            total_liquidity     : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::get_pool_liquidity(arg2, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::create_dola_address(1, 0x1::vector::empty<u8>())),
            available_liquidity : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::get_app_liquidity(arg2, arg3, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_app_id(arg0)),
        };
        0x2::event::emit<PoolLiquidationInfo>(v1);
    }

    public entry fun get_reserve_info(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::PoolManagerInfo, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::PriceOracle, arg2: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg3: u16) {
        let v0 = all_pool_liquidity(arg0, arg3);
        let v1 = if (0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::exist_pool_id(arg0, arg3)) {
            0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::get_pool_total_weight(arg0, arg3)
        } else {
            0
        };
        let v2 = if (0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::exist_pool_id(arg0, arg3)) {
            0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::get_app_liquidity(arg0, arg3, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_app_id(arg2))
        } else {
            0
        };
        let v3 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::total_otoken_supply(arg2, arg3);
        let v4 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::total_dtoken_supply(arg2, arg3);
        let v5 = 0;
        if (v4 > 0) {
            v5 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::rates::calculate_utilization(arg2, arg3, v2) * 10000 / 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray();
        };
        let v6 = LendingReserveInfo{
            dola_pool_id            : arg3,
            pools                   : v0,
            total_pool_weight       : v1,
            collateral_coefficient  : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_collateral_coefficient(arg2, arg3),
            borrow_coefficient      : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_borrow_coefficient(arg2, arg3),
            borrow_apy              : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_borrow_rate(arg2, arg3) * 10000 / 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray(),
            supply_apy              : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_liquidity_rate(arg2, arg3) * 10000 / 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray(),
            reserve                 : v2,
            available_value         : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::calculate_value(arg1, arg3, v2),
            supply                  : v3,
            supply_value            : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::calculate_value(arg1, arg3, v3),
            debt                    : v4,
            debt_value              : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::calculate_value(arg1, arg3, v4),
            current_isolate_debt    : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_isolate_debt(arg2, arg3),
            isolate_debt_ceiling    : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_reserve_borrow_ceiling(arg2, arg3),
            is_isolate_asset        : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::is_isolated_asset(arg2, arg3),
            borrowable_in_isolation : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::can_borrow_in_isolation(arg2, arg3),
            utilization_rate        : v5,
        };
        0x2::event::emit<LendingReserveInfo>(v6);
    }

    public fun get_reward_pool_apy(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::PriceOracle, arg2: u16, arg3: address, arg4: u16, arg5: &0x2::clock::Clock) : u256 {
        let v0 = if (arg2 == 3) {
            9
        } else if (arg2 == 8) {
            6
        } else {
            8
        };
        let v1 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::boost::get_reward_pool(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::boost::get_reward_pool_infos(arg0, arg4), 0x2::object::id_from_address(arg3));
        let v2 = if (0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::boost::get_start_time(v1) > 1717286400) {
            0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::boost::get_total_reward_share(arg0, arg4)
        } else if (0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::boost::get_reward_action(v1) == 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_codec::get_supply_type()) {
            0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::total_otoken_supply(arg0, arg4)
        } else {
            0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::total_dtoken_supply(arg0, arg4)
        };
        let v3 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::calculate_value(arg1, arg4, v2);
        let v4 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::boost::get_reward_per_second(v1) * 31536000;
        let v5 = v4;
        if (v0 > 8) {
            v5 = v4 / (0x2::math::pow(10, v0 - 8) as u256);
        } else if (v0 < 8) {
            v5 = v4 * (0x2::math::pow(10, 8 - v0) as u256);
        };
        if (v3 == 0 || 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_timestamp(arg5) >= 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::boost::get_end_time(v1)) {
            0
        } else {
            0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::calculate_value(arg1, arg2, v5) * 10000 / v3 / 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray()
        }
    }

    public entry fun get_reward_pool_apys(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::PriceOracle, arg2: vector<u16>, arg3: vector<address>, arg4: vector<u16>, arg5: &0x2::clock::Clock) {
        let v0 = 0x1::vector::empty<RewardPoolApy>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg3)) {
            let v2 = *0x1::vector::borrow<address>(&arg3, v1);
            let v3 = RewardPoolApy{
                reward_pool_info : v2,
                apy              : get_reward_pool_apy(arg0, arg1, *0x1::vector::borrow<u16>(&arg2, v1), v2, *0x1::vector::borrow<u16>(&arg4, v1), arg5),
            };
            0x1::vector::push_back<RewardPoolApy>(&mut v0, v3);
            v1 = v1 + 1;
        };
        let v4 = RewardPoolApys{apys: v0};
        0x2::event::emit<RewardPoolApys>(v4);
    }

    public entry fun get_user_all_collateral(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg1: u64) {
        let v0 = UserAllCollaterals{dola_pool_ids: 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_user_collaterals(arg0, arg1)};
        0x2::event::emit<UserAllCollaterals>(v0);
    }

    public entry fun get_user_all_debt(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg1: u64) {
        let v0 = UserAllDebts{dola_pool_ids: 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_user_loans(arg0, arg1)};
        0x2::event::emit<UserAllDebts>(v0);
    }

    public entry fun get_user_allowed_borrow(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::PoolManagerInfo, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg2: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::PriceOracle, arg3: u16, arg4: vector<u8>, arg5: u64, arg6: u16) {
        if (0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::user_health_factor(arg1, arg2, arg5) <= 1050000000000000000000000000) {
            let v0 = UserAllowedBorrow{
                borrow_token      : 0x1::ascii::into_bytes(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::get_pool_name_by_id(arg0, arg6)),
                max_borrow_amount : 0,
                max_borrow_value  : 0,
                borrow_amount     : 0,
                borrow_value      : 0,
            };
            0x2::event::emit<UserAllowedBorrow>(v0);
            return
        };
        let v1 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::calculate_amount(arg2, arg6, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_div(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_div(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::user_health_collateral_value(arg1, arg2, arg5), 1050000000000000000000000000) - 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::user_health_loan_value(arg1, arg2, arg5), 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_borrow_coefficient(arg1, arg6)));
        let v2 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::get_app_liquidity(arg0, arg6, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_app_id(arg1));
        let v3 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::min(v1, v2);
        let v4 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::min(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::min(v1, v2), 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::get_pool_liquidity(arg0, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::create_dola_address(arg3, arg4)));
        let v5 = UserAllowedBorrow{
            borrow_token      : 0x1::ascii::into_bytes(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::get_pool_name_by_id(arg0, arg6)),
            max_borrow_amount : v3,
            max_borrow_value  : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::calculate_value(arg2, arg6, v3),
            borrow_amount     : v4,
            borrow_value      : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::calculate_value(arg2, arg6, v4),
        };
        0x2::event::emit<UserAllowedBorrow>(v5);
    }

    public entry fun get_user_allowed_withdraw(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::PoolManagerInfo, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg2: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::PriceOracle, arg3: u16, arg4: vector<u8>, arg5: u64, arg6: u16, arg7: bool) {
        let v0 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::user_health_collateral_value(arg1, arg2, arg5);
        let v1 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::user_health_loan_value(arg1, arg2, arg5);
        let v2 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_collateral_coefficient(arg1, arg6);
        let v3 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::get_app_liquidity(arg0, arg6, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_app_id(arg1));
        let (v4, v5, v6) = if (0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::is_liquid_asset(arg1, arg5, arg6)) {
            let v7 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::user_collateral_balance(arg1, arg5, arg6);
            let v6 = v7;
            let v8 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::min(v7, v3);
            if (arg7) {
                v6 = v7 * 10;
            };
            (v8, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::calculate_value(arg2, arg6, v8), v6)
        } else {
            if (0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::user_health_factor(arg1, arg2, arg5) <= 1050000000000000000000000000) {
                let v9 = UserAllowedWithdraw{
                    withdraw_token      : 0x1::ascii::into_bytes(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::get_pool_name_by_id(arg0, arg6)),
                    max_withdraw_amount : 0,
                    max_withdraw_value  : 0,
                    withdraw_amount     : 0,
                    withdraw_value      : 0,
                };
                0x2::event::emit<UserAllowedWithdraw>(v9);
                return
            };
            let v10 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::calculate_amount(arg2, arg6, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_div(v0 - 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_mul(v1, 1050000000000000000000000000), v2));
            let v11 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::user_collateral_balance(arg1, arg5, arg6);
            let v12 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::min(v10, v11);
            let v6 = v12;
            let v13 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::min(v12, v3);
            let v14 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::calculate_value(arg2, arg6, v13);
            let v15 = if (v1 > 0) {
                0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_div(v0 - 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_mul(v14, v2), v1)
            } else {
                115792089237316195423570985008687907853269984665640564039457584007913129639935
            };
            if (arg7 && v15 > 1050000000000000000000000000 && v10 >= v11) {
                v6 = v12 * 10;
            };
            (v13, v14, v6)
        };
        let v16 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::min(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::min(v6, v3), 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::get_pool_liquidity(arg0, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::create_dola_address(arg3, arg4)));
        let v17 = UserAllowedWithdraw{
            withdraw_token      : 0x1::ascii::into_bytes(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::get_pool_name_by_id(arg0, arg6)),
            max_withdraw_amount : v4,
            max_withdraw_value  : v5,
            withdraw_amount     : v16,
            withdraw_value      : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::calculate_value(arg2, arg6, v16),
        };
        0x2::event::emit<UserAllowedWithdraw>(v17);
    }

    fun get_user_balance(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg1: u16, arg2: u64) : u256 {
        let v0 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::scaled_balance::balance_of(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_user_scaled_otoken_v2(arg0, arg2, arg1), 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_liquidity_index_v2(arg0, arg1));
        let v1 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::scaled_balance::balance_of(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_user_scaled_dtoken_v2(arg0, arg2, arg1), 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_borrow_index_v2(arg0, arg1));
        if (v1 > v0) {
            0
        } else {
            v0 - v1
        }
    }

    public entry fun get_user_collateral(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::PriceOracle, arg2: u64, arg3: u16) {
        let v0 = UserCollateralInfo{
            dola_pool_id      : arg3,
            borrow_apy        : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_borrow_rate(arg0, arg3) * 10000 / 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray(),
            supply_apy        : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_liquidity_rate(arg0, arg3) * 10000 / 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray(),
            collateral_amount : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::user_collateral_balance(arg0, arg2, arg3),
            collateral_value  : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::user_collateral_value(arg0, arg1, arg2, arg3),
        };
        0x2::event::emit<UserCollateralInfo>(v0);
    }

    public entry fun get_user_health_factor(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::PriceOracle, arg2: u64) {
        let v0 = UserHealthFactor{health_factor: 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::user_health_factor(arg0, arg1, arg2)};
        0x2::event::emit<UserHealthFactor>(v0);
    }

    public entry fun get_user_lending_info(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::PriceOracle, arg2: u64) {
        let v0 = 0x1::vector::empty<UserLiquidAssetInfo>();
        let v1 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_user_liquid_assets(arg0, arg2);
        let v2 = 0;
        let v3 = 0x1::vector::empty<UserCollateralInfo>();
        let v4 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_user_collaterals(arg0, arg2);
        let v5 = 0;
        let v6 = 0x1::vector::empty<UserDebtInfo>();
        let v7 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_user_loans(arg0, arg2);
        let v8 = 0;
        let v9 = 0;
        let v10 = 0;
        let v11 = 0;
        while (v11 < 0x1::vector::length<u16>(&v1)) {
            let v12 = 0x1::vector::borrow<u16>(&v1, v11);
            let v13 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_liquidity_rate(arg0, *v12);
            let v14 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::user_collateral_value(arg0, arg1, arg2, *v12);
            v9 = v9 + 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_mul(v14, v13);
            let v15 = UserLiquidAssetInfo{
                dola_pool_id  : *v12,
                borrow_apy    : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_borrow_rate(arg0, *v12) * 10000 / 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray(),
                supply_apy    : v13 * 10000 / 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray(),
                liquid_amount : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::user_collateral_balance(arg0, arg2, *v12),
                liquid_value  : v14,
            };
            0x1::vector::push_back<UserLiquidAssetInfo>(&mut v0, v15);
            v2 = v2 + v14;
            v11 = v11 + 1;
        };
        let v16 = 0;
        while (v16 < 0x1::vector::length<u16>(&v4)) {
            let v17 = 0x1::vector::borrow<u16>(&v4, v16);
            let v18 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_liquidity_rate(arg0, *v17);
            let v19 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::user_collateral_value(arg0, arg1, arg2, *v17);
            v9 = v9 + 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_mul(v19, v18);
            let v20 = UserCollateralInfo{
                dola_pool_id      : *v17,
                borrow_apy        : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_borrow_rate(arg0, *v17) * 10000 / 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray(),
                supply_apy        : v18 * 10000 / 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray(),
                collateral_amount : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::user_collateral_balance(arg0, arg2, *v17),
                collateral_value  : v19,
            };
            0x1::vector::push_back<UserCollateralInfo>(&mut v3, v20);
            v5 = v5 + v19;
            v16 = v16 + 1;
        };
        v16 = 0;
        while (v16 < 0x1::vector::length<u16>(&v7)) {
            let v21 = 0x1::vector::borrow<u16>(&v7, v16);
            let v22 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_borrow_rate(arg0, *v21);
            let v23 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::user_loan_value(arg0, arg1, arg2, *v21);
            v10 = v10 + 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_mul(v23, v22);
            let v24 = UserDebtInfo{
                dola_pool_id : *v21,
                borrow_apy   : v22 * 10000 / 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray(),
                supply_apy   : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_liquidity_rate(arg0, *v21) * 10000 / 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray(),
                debt_amount  : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::user_loan_balance(arg0, arg2, *v21),
                debt_value   : v23,
            };
            0x1::vector::push_back<UserDebtInfo>(&mut v6, v24);
            v8 = v8 + v23;
            v16 = v16 + 1;
        };
        let v25 = 0;
        let v26 = 0;
        if (v5 > 0) {
            v25 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_div(v9, v5);
        };
        if (v8 > 0) {
            v26 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_div(v10, v8);
        };
        let (v27, v28) = if (v9 >= v10) {
            (v9 - v10, true)
        } else {
            (v10 - v9, false)
        };
        let v29 = if (v2 + v5 >= v8) {
            v2 + v5 - v8
        } else {
            v8 - v2 + v5
        };
        let v30 = if (v29 > 0) {
            0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_div(v27, v29)
        } else {
            0
        };
        let v31 = UserLendingInfo{
            health_factor          : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::user_health_factor(arg0, arg1, arg2),
            profit_state           : v28,
            net_apy                : v30 * 10000 / 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray(),
            total_supply_apy       : v25 * 10000 / 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray(),
            total_borrow_apy       : v26 * 10000 / 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray(),
            liquid_asset_infos     : v0,
            total_liquid_value     : v2,
            collateral_infos       : v3,
            total_collateral_value : v5,
            debt_infos             : v6,
            total_debt_value       : v8,
            isolation_mode         : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::is_isolation_mode(arg0, arg2),
        };
        0x2::event::emit<UserLendingInfo>(v31);
    }

    public fun get_user_lending_info_with_return(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::PriceOracle, arg2: u64) : UserLendingInfo {
        let v0 = 0x1::vector::empty<UserLiquidAssetInfo>();
        let v1 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_user_liquid_assets(arg0, arg2);
        let v2 = 0;
        let v3 = 0x1::vector::empty<UserCollateralInfo>();
        let v4 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_user_collaterals(arg0, arg2);
        let v5 = 0;
        let v6 = 0x1::vector::empty<UserDebtInfo>();
        let v7 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_user_loans(arg0, arg2);
        let v8 = 0;
        let v9 = 0;
        let v10 = 0;
        let v11 = 0;
        while (v11 < 0x1::vector::length<u16>(&v1)) {
            let v12 = 0x1::vector::borrow<u16>(&v1, v11);
            let v13 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_liquidity_rate(arg0, *v12);
            let v14 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::user_collateral_value(arg0, arg1, arg2, *v12);
            v9 = v9 + 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_mul(v14, v13);
            let v15 = UserLiquidAssetInfo{
                dola_pool_id  : *v12,
                borrow_apy    : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_borrow_rate(arg0, *v12) * 10000 / 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray(),
                supply_apy    : v13 * 10000 / 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray(),
                liquid_amount : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::user_collateral_balance(arg0, arg2, *v12),
                liquid_value  : v14,
            };
            0x1::vector::push_back<UserLiquidAssetInfo>(&mut v0, v15);
            v2 = v2 + v14;
            v11 = v11 + 1;
        };
        let v16 = 0;
        while (v16 < 0x1::vector::length<u16>(&v4)) {
            let v17 = 0x1::vector::borrow<u16>(&v4, v16);
            let v18 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_liquidity_rate(arg0, *v17);
            let v19 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::user_collateral_value(arg0, arg1, arg2, *v17);
            v9 = v9 + 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_mul(v19, v18);
            let v20 = UserCollateralInfo{
                dola_pool_id      : *v17,
                borrow_apy        : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_borrow_rate(arg0, *v17) * 10000 / 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray(),
                supply_apy        : v18 * 10000 / 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray(),
                collateral_amount : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::user_collateral_balance(arg0, arg2, *v17),
                collateral_value  : v19,
            };
            0x1::vector::push_back<UserCollateralInfo>(&mut v3, v20);
            v5 = v5 + v19;
            v16 = v16 + 1;
        };
        v16 = 0;
        while (v16 < 0x1::vector::length<u16>(&v7)) {
            let v21 = 0x1::vector::borrow<u16>(&v7, v16);
            let v22 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_borrow_rate(arg0, *v21);
            let v23 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::user_loan_value(arg0, arg1, arg2, *v21);
            v10 = v10 + 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_mul(v23, v22);
            let v24 = UserDebtInfo{
                dola_pool_id : *v21,
                borrow_apy   : v22 * 10000 / 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray(),
                supply_apy   : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_liquidity_rate(arg0, *v21) * 10000 / 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray(),
                debt_amount  : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::user_loan_balance(arg0, arg2, *v21),
                debt_value   : v23,
            };
            0x1::vector::push_back<UserDebtInfo>(&mut v6, v24);
            v8 = v8 + v23;
            v16 = v16 + 1;
        };
        let v25 = 0;
        let v26 = 0;
        if (v5 > 0) {
            v25 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_div(v9, v5);
        };
        if (v8 > 0) {
            v26 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_div(v10, v8);
        };
        let (v27, v28) = if (v9 >= v10) {
            (v9 - v10, true)
        } else {
            (v10 - v9, false)
        };
        let v29 = if (v2 + v5 >= v8) {
            v2 + v5 - v8
        } else {
            v8 - v2 + v5
        };
        let v30 = if (v29 > 0) {
            0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_div(v27, v29)
        } else {
            0
        };
        UserLendingInfo{
            health_factor          : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::user_health_factor(arg0, arg1, arg2),
            profit_state           : v28,
            net_apy                : v30 * 10000 / 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray(),
            total_supply_apy       : v25 * 10000 / 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray(),
            total_borrow_apy       : v26 * 10000 / 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray(),
            liquid_asset_infos     : v0,
            total_liquid_value     : v2,
            collateral_infos       : v3,
            total_collateral_value : v5,
            debt_infos             : v6,
            total_debt_value       : v8,
            isolation_mode         : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::is_isolation_mode(arg0, arg2),
        }
    }

    public entry fun get_user_liquidation_query_info(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::PriceOracle, arg2: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::user_manager::UserManagerInfo, arg3: u64) {
        if (!0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::exist_user_info(arg0, arg3)) {
            return
        };
        let v0 = get_user_lending_info_with_return(arg0, arg1, arg3);
        let v1 = get_dola_user_addresses_with_return(arg2, arg3);
        let v2 = 0x1::vector::empty<u8>();
        let v3 = 0x1::vector::empty<u8>();
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::DolaAddress>(&v1.dola_user_addresses)) {
            let v5 = 0x1::vector::borrow<0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::DolaAddress>(&v1.dola_user_addresses, v4);
            if (0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::get_dola_chain_id(v5) == 2) {
                v2 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::get_dola_address(v5);
            } else if (0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::get_dola_chain_id(v5) == 0) {
                v3 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::get_dola_address(v5);
            };
            v4 = v4 + 1;
        };
        let v6 = UserLiquidationQueryInfo{
            dola_user_id  : arg3,
            evm_address   : v2,
            sui_address   : v3,
            liquid_assets : v0.liquid_asset_infos,
            collaterals   : v0.collateral_infos,
            debts         : v0.debt_infos,
        };
        0x2::event::emit<UserLiquidationQueryInfo>(v6);
    }

    public fun get_user_rewrad(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg1: address, arg2: u64, arg3: u16, arg4: &0x2::clock::Clock) : (u256, u256, u8) {
        let v0 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::boost::get_reward_pool(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::boost::get_reward_pool_infos(arg0, arg3), 0x2::object::id_from_address(arg1));
        let v1 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::boost::get_reward_action(v0);
        let v2 = if (0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::boost::get_start_time(v0) > 1717286400) {
            0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::boost::get_total_reward_share(arg0, arg3)
        } else {
            0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::boost::get_total_scaled_balance(arg0, arg3, v1)
        };
        let v3 = if (v2 == 0) {
            0
        } else {
            0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::boost::get_reward_index(v0) + 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::boost::get_reward_per_second(v0) * (0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::min(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::max(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_timestamp(arg4), 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::boost::get_start_time(v0)), 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::boost::get_end_time(v0)) - 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::boost::get_last_update_time(v0)) / v2
        };
        let v4 = 0;
        let (v5, v6) = if (!0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::boost::is_exist_user_reward(v0, arg2)) {
            (0, 0)
        } else {
            let (v7, v8, v9) = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::boost::get_user_reward_info(v0, arg2);
            v4 = v9;
            (v8, v7)
        };
        if (0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::boost::get_start_time(v0) > 1717286400) {
            v6 = v6 + 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_mul(v3 - v4, get_user_balance(arg0, arg3, arg2));
        } else {
            v6 = v6 + 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_mul(v3 - v4, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::boost::get_user_scaled_balance(arg0, arg3, arg2, v1));
        };
        (v6, v5, v1)
    }

    public entry fun get_user_token_debt(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::PriceOracle, arg2: u64, arg3: u16) {
        let v0 = UserDebtInfo{
            dola_pool_id : arg3,
            borrow_apy   : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_borrow_rate(arg0, arg3) * 10000 / 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray(),
            supply_apy   : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_liquidity_rate(arg0, arg3) * 10000 / 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray(),
            debt_amount  : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::user_loan_balance(arg0, arg2, arg3),
            debt_value   : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::user_loan_value(arg0, arg1, arg2, arg3),
        };
        0x2::event::emit<UserDebtInfo>(v0);
    }

    public fun get_user_total_allowed_borrow(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::PoolManagerInfo, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg2: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::PriceOracle, arg3: u64) {
        let v0 = 0x1::vector::empty<UserTotalBorrowInfo>();
        let v1 = true;
        if (0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::user_health_factor(arg1, arg2, arg3) <= 1050000000000000000000000000) {
            v1 = false;
        };
        let v2 = 0;
        while (v2 < 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_reserve_length(arg1)) {
            let v3 = (v2 as u16);
            let v4 = if (v1) {
                0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_div(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray_div(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::user_health_collateral_value(arg1, arg2, arg3), 1050000000000000000000000000) - 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::user_health_loan_value(arg1, arg2, arg3), 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_borrow_coefficient(arg1, v3))
            } else {
                0
            };
            let v5 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::min(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::calculate_amount(arg2, v3, v4), 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::get_app_liquidity(arg0, v3, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_app_id(arg1)));
            let v6 = UserTotalBorrowInfo{
                dola_pool_id                  : v3,
                total_avaliable_borrow_amount : v5,
                total_avaliable_borrow_value  : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::calculate_value(arg2, v3, v5),
            };
            0x1::vector::push_back<UserTotalBorrowInfo>(&mut v0, v6);
            v2 = v2 + 1;
        };
        let v7 = UserTotalAllowedBorrow{total_allowed_borrow: v0};
        0x2::event::emit<UserTotalAllowedBorrow>(v7);
    }

    public entry fun get_user_total_reward_info(arg0: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::PriceOracle, arg2: u64, arg3: vector<u16>, arg4: vector<u16>, arg5: vector<address>, arg6: &0x2::clock::Clock) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0x1::vector::empty<UserRewardInfo>();
        let v5 = 0;
        while (v5 < 0x1::vector::length<u16>(&arg4)) {
            let v6 = *0x1::vector::borrow<u16>(&arg4, v5);
            let v7 = *0x1::vector::borrow<address>(&arg5, v5);
            let v8 = *0x1::vector::borrow<u16>(&arg3, v5);
            let (v9, v10, v11) = get_user_rewrad(arg0, v7, arg2, v6, arg6);
            let v12 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::calculate_value(arg1, v8, v9);
            let v13 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::calculate_value(arg1, v8, v10);
            let v14 = v0 + v9;
            v0 = v14 + v10;
            let v15 = v1 + v12;
            v1 = v15 + v13;
            v2 = v2 + v9;
            v3 = v3 + v12;
            let v16 = UserRewardInfo{
                dola_pool_id           : v6,
                action                 : v11,
                reward_pool_info       : v7,
                unclaimed_reward       : v9,
                unclaimed_reward_value : v12,
                claimed_reward         : v10,
                claimed_reward_value   : v13,
            };
            0x1::vector::push_back<UserRewardInfo>(&mut v4, v16);
            v5 = v5 + 1;
        };
        let v17 = UserTotalRewardInfo{
            total_reward                 : v0,
            total_reward_value           : v1,
            total_unclaimed_reward       : v2,
            total_unclaimed_reward_value : v3,
            user_reward_infos            : v4,
        };
        0x2::event::emit<UserTotalRewardInfo>(v17);
    }

    // decompiled from Move bytecode v6
}

