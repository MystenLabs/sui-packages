module 0x87ee319d04058b2bdabf83b21f2349d39a9ff33e9b44acbb97f22703fb7cef65::interfaces {
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
        pool_address: 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::dola_address::DolaAddress,
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
        supply: u256,
        debt: u256,
        current_isolate_debt: u256,
        isolate_debt_ceiling: u256,
        is_isolate_asset: bool,
        borrowable_in_isolation: bool,
        utilization_rate: u256,
    }

    struct AllReserveInfo has copy, drop {
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
        reason: 0x1::option::Option<0x1::ascii::String>,
    }

    struct DolaUserId has copy, drop {
        dola_user_id: u64,
    }

    struct DolaUserAddresses has copy, drop {
        dola_user_addresses: vector<0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::dola_address::DolaAddress>,
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

    public entry fun get_pool_liquidity(arg0: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_manager::PoolManagerInfo, arg1: u16, arg2: vector<u8>) {
        let v0 = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::dola_address::create_dola_address(arg1, arg2);
        let v1 = PoolLiquidityInfo{
            pool_address         : v0,
            pool_liquidity       : 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_manager::get_pool_liquidity(arg0, v0),
            pool_equilibrium_fee : 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_manager::get_pool_equilibrium_fee(arg0, v0),
            pool_weight          : 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_manager::get_pool_weight(arg0, v0),
        };
        0x2::event::emit<PoolLiquidityInfo>(v1);
    }

    public entry fun get_dola_user_id(arg0: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::user_manager::UserManagerInfo, arg1: u16, arg2: vector<u8>) {
        let v0 = DolaUserId{dola_user_id: 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::user_manager::get_dola_user_id(arg0, 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::dola_address::create_dola_address(arg1, arg2))};
        0x2::event::emit<DolaUserId>(v0);
    }

    public fun all_pool_liquidity(arg0: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_manager::PoolManagerInfo, arg1: u16) : vector<PoolLiquidityInfo> {
        let v0 = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_manager::get_pools_by_id(arg0, arg1);
        let v1 = 0;
        let v2 = 0x1::vector::empty<PoolLiquidityInfo>();
        while (v1 < 0x1::vector::length<0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::dola_address::DolaAddress>(&v0)) {
            let v3 = *0x1::vector::borrow<0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::dola_address::DolaAddress>(&v0, v1);
            let v4 = PoolLiquidityInfo{
                pool_address         : v3,
                pool_liquidity       : 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_manager::get_pool_liquidity(arg0, v3),
                pool_equilibrium_fee : 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_manager::get_pool_equilibrium_fee(arg0, v3),
                pool_weight          : 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_manager::get_pool_weight(arg0, v3),
            };
            0x1::vector::push_back<PoolLiquidityInfo>(&mut v2, v4);
            v1 = v1 + 1;
        };
        v2
    }

    public entry fun get_all_oracle_price(arg0: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_core_storage::Storage, arg1: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::oracle::PriceOracle) {
        let v0 = 0x1::vector::empty<TokenPrice>();
        let v1 = 0;
        while (v1 < 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_core_storage::get_reserve_length(arg0)) {
            let v2 = (v1 as u16);
            let (v3, v4, _) = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::oracle::get_token_price(arg1, v2);
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

    public entry fun get_all_pool_liquidity(arg0: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_manager::PoolManagerInfo, arg1: u16) {
        let v0 = AllPoolLiquidityInfo{pool_infos: all_pool_liquidity(arg0, arg1)};
        0x2::event::emit<AllPoolLiquidityInfo>(v0);
    }

    public entry fun get_all_reserve_info(arg0: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_manager::PoolManagerInfo, arg1: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_core_storage::Storage) {
        let v0 = 0x1::vector::empty<LendingReserveInfo>();
        let v1 = 0;
        while (v1 < 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_core_storage::get_reserve_length(arg1)) {
            let v2 = (v1 as u16);
            let v3 = all_pool_liquidity(arg0, v2);
            let v4 = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_logic::total_dtoken_supply(arg1, v2);
            let v5 = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_manager::get_app_liquidity(arg0, v2, 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_core_storage::get_app_id(arg1));
            let v6 = 0;
            if (v4 > 0) {
                v6 = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::rates::calculate_utilization(arg1, v2, v5) * 10000 / 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::ray_math::ray();
            };
            let v7 = LendingReserveInfo{
                dola_pool_id            : v2,
                pools                   : v3,
                total_pool_weight       : 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_manager::get_pool_total_weight(arg0, v2),
                collateral_coefficient  : 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_core_storage::get_collateral_coefficient(arg1, v2),
                borrow_coefficient      : 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_core_storage::get_borrow_coefficient(arg1, v2),
                borrow_apy              : 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_core_storage::get_borrow_rate(arg1, v2) * 10000 / 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::ray_math::ray(),
                supply_apy              : 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_core_storage::get_liquidity_rate(arg1, v2) * 10000 / 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::ray_math::ray(),
                reserve                 : v5,
                supply                  : 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_logic::total_otoken_supply(arg1, v2),
                debt                    : v4,
                current_isolate_debt    : 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_core_storage::get_isolate_debt(arg1, v2),
                isolate_debt_ceiling    : 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_core_storage::get_reserve_borrow_ceiling(arg1, v2),
                is_isolate_asset        : 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_core_storage::is_isolated_asset(arg1, v2),
                borrowable_in_isolation : 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_core_storage::can_borrow_in_isolation(arg1, v2),
                utilization_rate        : v6,
            };
            0x1::vector::push_back<LendingReserveInfo>(&mut v0, v7);
            v1 = v1 + 1;
        };
        let v8 = AllReserveInfo{reserve_infos: v0};
        0x2::event::emit<AllReserveInfo>(v8);
    }

    public entry fun get_app_token_liquidity(arg0: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_manager::PoolManagerInfo, arg1: u16, arg2: u16) {
        let v0 = AppLiquidityInfo{
            app_id          : arg1,
            dola_pool_id    : arg2,
            token_liquidity : 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_manager::get_app_liquidity(arg0, arg2, arg1),
        };
        0x2::event::emit<AppLiquidityInfo>(v0);
    }

    public entry fun get_dola_token_liquidity(arg0: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_manager::PoolManagerInfo, arg1: u16) {
        let v0 = TokenLiquidityInfo{
            dola_pool_id    : arg1,
            token_liquidity : 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_manager::get_token_liquidity(arg0, arg1),
        };
        0x2::event::emit<TokenLiquidityInfo>(v0);
    }

    public entry fun get_dola_user_addresses(arg0: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::user_manager::UserManagerInfo, arg1: u64) {
        let v0 = DolaUserAddresses{dola_user_addresses: 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::user_manager::get_user_addresses(arg0, arg1)};
        0x2::event::emit<DolaUserAddresses>(v0);
    }

    public entry fun get_equilibrium_fee(arg0: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_manager::PoolManagerInfo, arg1: u16, arg2: vector<u8>, arg3: u256) {
        let v0 = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::dola_address::create_dola_address(arg1, arg2);
        let v1 = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_manager::get_id_by_pool(arg0, v0);
        let v2 = LiquidityEquilibriumFee{fee: 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::equilibrium_fee::calculate_equilibrium_fee(0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_manager::get_token_liquidity(arg0, v1), 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_manager::get_pool_liquidity(arg0, v0), arg3, 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::equilibrium_fee::calculate_expected_ratio(0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_manager::get_pool_total_weight(arg0, v1), 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_manager::get_pool_weight(arg0, v0)), 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_manager::get_default_alpha_1(), 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_manager::get_default_lambda_1())};
        0x2::event::emit<LiquidityEquilibriumFee>(v2);
    }

    public entry fun get_equilibrium_reward(arg0: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_manager::PoolManagerInfo, arg1: u16, arg2: vector<u8>, arg3: u256) {
        let v0 = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::dola_address::create_dola_address(arg1, arg2);
        let v1 = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_manager::get_id_by_pool(arg0, v0);
        let v2 = LiquidityEquilibriumReward{reward: 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::equilibrium_fee::calculate_equilibrium_reward(0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_manager::get_token_liquidity(arg0, v1), 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_manager::get_pool_liquidity(arg0, v0), arg3, 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::equilibrium_fee::calculate_expected_ratio(0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_manager::get_pool_total_weight(arg0, v1), 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_manager::get_pool_weight(arg0, v0)), 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_manager::get_pool_equilibrium_fee(arg0, v0), 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_manager::get_default_lambda_1())};
        0x2::event::emit<LiquidityEquilibriumReward>(v2);
    }

    public entry fun get_liquidation_discount(arg0: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_core_storage::Storage, arg1: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::oracle::PriceOracle, arg2: u64, arg3: u64) {
        let v0 = LiquidationDiscount{discount: 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_logic::calculate_liquidation_discount(arg0, arg1, arg2, arg3)};
        0x2::event::emit<LiquidationDiscount>(v0);
    }

    public entry fun get_oracle_price(arg0: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::oracle::PriceOracle, arg1: u16) {
        let (v0, v1, _) = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::oracle::get_token_price(arg0, arg1);
        let v3 = TokenPrice{
            dola_pool_id : arg1,
            price        : v0,
            decimal      : v1,
        };
        0x2::event::emit<TokenPrice>(v3);
    }

    public entry fun get_reserve_info(arg0: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_manager::PoolManagerInfo, arg1: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_core_storage::Storage, arg2: u16) {
        let v0 = all_pool_liquidity(arg0, arg2);
        let v1 = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_logic::total_dtoken_supply(arg1, arg2);
        let v2 = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_manager::get_app_liquidity(arg0, arg2, 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_core_storage::get_app_id(arg1));
        let v3 = 0;
        if (v1 > 0) {
            v3 = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::rates::calculate_utilization(arg1, arg2, v2) * 10000 / 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::ray_math::ray();
        };
        let v4 = LendingReserveInfo{
            dola_pool_id            : arg2,
            pools                   : v0,
            total_pool_weight       : 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_manager::get_pool_total_weight(arg0, arg2),
            collateral_coefficient  : 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_core_storage::get_collateral_coefficient(arg1, arg2),
            borrow_coefficient      : 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_core_storage::get_borrow_coefficient(arg1, arg2),
            borrow_apy              : 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_core_storage::get_borrow_rate(arg1, arg2) * 10000 / 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::ray_math::ray(),
            supply_apy              : 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_core_storage::get_liquidity_rate(arg1, arg2) * 10000 / 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::ray_math::ray(),
            reserve                 : v2,
            supply                  : 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_logic::total_otoken_supply(arg1, arg2),
            debt                    : v1,
            current_isolate_debt    : 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_core_storage::get_isolate_debt(arg1, arg2),
            isolate_debt_ceiling    : 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_core_storage::get_reserve_borrow_ceiling(arg1, arg2),
            is_isolate_asset        : 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_core_storage::is_isolated_asset(arg1, arg2),
            borrowable_in_isolation : 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_core_storage::can_borrow_in_isolation(arg1, arg2),
            utilization_rate        : v3,
        };
        0x2::event::emit<LendingReserveInfo>(v4);
    }

    public entry fun get_user_all_collateral(arg0: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_core_storage::Storage, arg1: u64) {
        let v0 = UserAllCollaterals{dola_pool_ids: 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_core_storage::get_user_collaterals(arg0, arg1)};
        0x2::event::emit<UserAllCollaterals>(v0);
    }

    public entry fun get_user_all_debt(arg0: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_core_storage::Storage, arg1: u64) {
        let v0 = UserAllDebts{dola_pool_ids: 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_core_storage::get_user_loans(arg0, arg1)};
        0x2::event::emit<UserAllDebts>(v0);
    }

    public entry fun get_user_allowed_borrow(arg0: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_manager::PoolManagerInfo, arg1: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_core_storage::Storage, arg2: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::oracle::PriceOracle, arg3: u16, arg4: u64, arg5: u16) {
        if (0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_logic::is_collateral(arg1, arg4, arg5)) {
            let v0 = UserAllowedBorrow{
                borrow_token      : 0x1::ascii::into_bytes(0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_manager::get_pool_name_by_id(arg0, arg5)),
                max_borrow_amount : 0,
                max_borrow_value  : 0,
                borrow_amount     : 0,
                borrow_value      : 0,
                reason            : 0x1::option::some<0x1::ascii::String>(0x1::ascii::string(b"Borrowed token is collateral")),
            };
            0x2::event::emit<UserAllowedBorrow>(v0);
            return
        };
        let v1 = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_logic::calculate_amount(arg2, arg5, 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::ray_math::ray_div(0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_logic::user_health_collateral_value(arg1, arg2, arg4) - 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_logic::user_health_loan_value(arg1, arg2, arg4), 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_core_storage::get_borrow_coefficient(arg1, arg5)));
        let v2 = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_manager::find_pool_by_chain(arg0, arg5, arg3);
        let v3 = 0;
        if (0x1::option::is_some<0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::dola_address::DolaAddress>(&v2)) {
            v3 = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_manager::get_pool_liquidity(arg0, 0x1::option::extract<0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::dola_address::DolaAddress>(&mut v2));
        };
        let v4 = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::ray_math::min(v1, 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_manager::get_app_liquidity(arg0, arg5, 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_core_storage::get_app_id(arg1)));
        let v5 = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::ray_math::min(v1, v3);
        let v6 = UserAllowedBorrow{
            borrow_token      : 0x1::ascii::into_bytes(0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_manager::get_pool_name_by_id(arg0, arg5)),
            max_borrow_amount : v4,
            max_borrow_value  : 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_logic::calculate_value(arg2, arg5, v4),
            borrow_amount     : v5,
            borrow_value      : 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_logic::calculate_value(arg2, arg5, v5),
            reason            : 0x1::option::none<0x1::ascii::String>(),
        };
        0x2::event::emit<UserAllowedBorrow>(v6);
    }

    public entry fun get_user_collateral(arg0: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_core_storage::Storage, arg1: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::oracle::PriceOracle, arg2: u64, arg3: u16) {
        let v0 = UserCollateralInfo{
            dola_pool_id      : arg3,
            borrow_apy        : 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_core_storage::get_borrow_rate(arg0, arg3) * 10000 / 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::ray_math::ray(),
            supply_apy        : 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_core_storage::get_liquidity_rate(arg0, arg3) * 10000 / 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::ray_math::ray(),
            collateral_amount : 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_logic::user_collateral_balance(arg0, arg2, arg3),
            collateral_value  : 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_logic::user_collateral_value(arg0, arg1, arg2, arg3),
        };
        0x2::event::emit<UserCollateralInfo>(v0);
    }

    public entry fun get_user_health_factor(arg0: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_core_storage::Storage, arg1: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::oracle::PriceOracle, arg2: u64) {
        let v0 = UserHealthFactor{health_factor: 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_logic::user_health_factor(arg0, arg1, arg2)};
        0x2::event::emit<UserHealthFactor>(v0);
    }

    public entry fun get_user_lending_info(arg0: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_core_storage::Storage, arg1: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::oracle::PriceOracle, arg2: u64) {
        let v0 = 0x1::vector::empty<UserLiquidAssetInfo>();
        let v1 = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_core_storage::get_user_liquid_assets(arg0, arg2);
        let v2 = 0;
        let v3 = 0x1::vector::empty<UserCollateralInfo>();
        let v4 = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_core_storage::get_user_collaterals(arg0, arg2);
        let v5 = 0;
        let v6 = 0x1::vector::empty<UserDebtInfo>();
        let v7 = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_core_storage::get_user_loans(arg0, arg2);
        let v8 = 0;
        let v9 = 0;
        let v10 = 0;
        let v11 = 0;
        while (v11 < 0x1::vector::length<u16>(&v1)) {
            let v12 = 0x1::vector::borrow<u16>(&v1, v11);
            let v13 = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_core_storage::get_liquidity_rate(arg0, *v12);
            let v14 = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_logic::user_collateral_value(arg0, arg1, arg2, *v12);
            v9 = v9 + 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::ray_math::ray_mul(v14, v13);
            let v15 = UserLiquidAssetInfo{
                dola_pool_id  : *v12,
                borrow_apy    : 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_core_storage::get_borrow_rate(arg0, *v12) * 10000 / 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::ray_math::ray(),
                supply_apy    : v13 * 10000 / 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::ray_math::ray(),
                liquid_amount : 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_logic::user_collateral_balance(arg0, arg2, *v12),
                liquid_value  : v14,
            };
            0x1::vector::push_back<UserLiquidAssetInfo>(&mut v0, v15);
            v2 = v2 + v14;
            v11 = v11 + 1;
        };
        let v16 = 0;
        while (v16 < 0x1::vector::length<u16>(&v4)) {
            let v17 = 0x1::vector::borrow<u16>(&v4, v16);
            let v18 = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_core_storage::get_liquidity_rate(arg0, *v17);
            let v19 = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_logic::user_collateral_value(arg0, arg1, arg2, *v17);
            v9 = v9 + 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::ray_math::ray_mul(v19, v18);
            let v20 = UserCollateralInfo{
                dola_pool_id      : *v17,
                borrow_apy        : 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_core_storage::get_borrow_rate(arg0, *v17) * 10000 / 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::ray_math::ray(),
                supply_apy        : v18 * 10000 / 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::ray_math::ray(),
                collateral_amount : 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_logic::user_collateral_balance(arg0, arg2, *v17),
                collateral_value  : v19,
            };
            0x1::vector::push_back<UserCollateralInfo>(&mut v3, v20);
            v5 = v5 + v19;
            v16 = v16 + 1;
        };
        v16 = 0;
        while (v16 < 0x1::vector::length<u16>(&v7)) {
            let v21 = 0x1::vector::borrow<u16>(&v7, v16);
            let v22 = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_core_storage::get_borrow_rate(arg0, *v21);
            let v23 = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_logic::user_loan_value(arg0, arg1, arg2, *v21);
            v10 = v10 + 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::ray_math::ray_mul(v23, v22);
            let v24 = UserDebtInfo{
                dola_pool_id : *v21,
                borrow_apy   : v22 * 10000 / 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::ray_math::ray(),
                supply_apy   : 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_core_storage::get_liquidity_rate(arg0, *v21) * 10000 / 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::ray_math::ray(),
                debt_amount  : 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_logic::user_loan_balance(arg0, arg2, *v21),
                debt_value   : v23,
            };
            0x1::vector::push_back<UserDebtInfo>(&mut v6, v24);
            v8 = v8 + v23;
            v16 = v16 + 1;
        };
        let v25 = 0;
        let v26 = 0;
        if (v5 > 0) {
            v25 = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::ray_math::ray_div(v9, v5);
        };
        if (v8 > 0) {
            v26 = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::ray_math::ray_div(v10, v8);
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
            0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::ray_math::ray_div(v27, v29)
        } else {
            0
        };
        let v31 = UserLendingInfo{
            health_factor          : 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_logic::user_health_factor(arg0, arg1, arg2),
            profit_state           : v28,
            net_apy                : v30 * 10000 / 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::ray_math::ray(),
            total_supply_apy       : v25 * 10000 / 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::ray_math::ray(),
            total_borrow_apy       : v26 * 10000 / 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::ray_math::ray(),
            liquid_asset_infos     : v0,
            total_liquid_value     : v2,
            collateral_infos       : v3,
            total_collateral_value : v5,
            debt_infos             : v6,
            total_debt_value       : v8,
            isolation_mode         : 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_logic::is_isolation_mode(arg0, arg2),
        };
        0x2::event::emit<UserLendingInfo>(v31);
    }

    public entry fun get_user_token_debt(arg0: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_core_storage::Storage, arg1: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::oracle::PriceOracle, arg2: u64, arg3: u16) {
        let v0 = UserDebtInfo{
            dola_pool_id : arg3,
            borrow_apy   : 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_core_storage::get_borrow_rate(arg0, arg3) * 10000 / 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::ray_math::ray(),
            supply_apy   : 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_core_storage::get_liquidity_rate(arg0, arg3) * 10000 / 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::ray_math::ray(),
            debt_amount  : 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_logic::user_loan_balance(arg0, arg2, arg3),
            debt_value   : 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::lending_logic::user_loan_value(arg0, arg1, arg2, arg3),
        };
        0x2::event::emit<UserDebtInfo>(v0);
    }

    // decompiled from Move bytecode v6
}

