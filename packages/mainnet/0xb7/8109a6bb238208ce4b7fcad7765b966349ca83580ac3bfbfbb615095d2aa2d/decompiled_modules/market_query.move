module 0xb78109a6bb238208ce4b7fcad7765b966349ca83580ac3bfbfbb615095d2aa2d::market_query {
    struct PoolData has copy, drop, store {
        interestRate: 0x1::fixed_point32::FixedPoint32,
        borrowIndex: u64,
        lastUpdated: u64,
        type: 0x1::type_name::TypeName,
        baseBorrowRatePerSec: 0x1::fixed_point32::FixedPoint32,
        interestRateScale: u64,
        reserveFactor: 0x1::fixed_point32::FixedPoint32,
        borrowFeeRate: 0x1::fixed_point32::FixedPoint32,
        minBorrowAmount: u64,
        debt: u64,
        reserve: u64,
        marketCoinSupply: u64,
    }

    struct CollateralData has copy, drop, store {
        type: 0x1::type_name::TypeName,
        collateralFactor: 0x1::fixed_point32::FixedPoint32,
        liquidationFactor: 0x1::fixed_point32::FixedPoint32,
        liquidationPanelty: 0x1::fixed_point32::FixedPoint32,
        liquidationDiscount: 0x1::fixed_point32::FixedPoint32,
        liquidationReserveFactor: 0x1::fixed_point32::FixedPoint32,
        maxCollateralAmount: u64,
        totalCollateralAmount: u64,
    }

    struct MarketData has copy, drop, store {
        pools: vector<PoolData>,
        collaterals: vector<CollateralData>,
    }

    public fun collateral_data(arg0: &0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::market::Market) : vector<CollateralData> {
        let v0 = 0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::market::risk_models(arg0);
        let v1 = 0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::market::collateral_stats(arg0);
        let v2 = 0xeacdf466dded111fa8a065ab270a1077ffd6a5074f7cebfa1809ea558af854db::ac_table::keys<0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::risk_model::RiskModels, 0x1::type_name::TypeName, 0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::risk_model::RiskModel>(v0);
        let v3 = 0;
        let v4 = 0x1::vector::empty<CollateralData>();
        while (v3 < 0x1::vector::length<0x1::type_name::TypeName>(&v2)) {
            let v5 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v2, v3);
            let v6 = 0xeacdf466dded111fa8a065ab270a1077ffd6a5074f7cebfa1809ea558af854db::ac_table::borrow<0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::risk_model::RiskModels, 0x1::type_name::TypeName, 0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::risk_model::RiskModel>(v0, v5);
            let v7 = CollateralData{
                type                     : v5,
                collateralFactor         : 0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::risk_model::collateral_factor(v6),
                liquidationFactor        : 0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::risk_model::liq_factor(v6),
                liquidationPanelty       : 0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::risk_model::liq_penalty(v6),
                liquidationDiscount      : 0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::risk_model::liq_discount(v6),
                liquidationReserveFactor : 0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::risk_model::liq_revenue_factor(v6),
                maxCollateralAmount      : 0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::risk_model::max_collateral_amount(v6),
                totalCollateralAmount    : 0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::collateral_stats::collateral_amount(v1, v5),
            };
            0x1::vector::push_back<CollateralData>(&mut v4, v7);
            v3 = v3 + 1;
        };
        v4
    }

    public fun market_data(arg0: &0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::market::Market) {
        let v0 = MarketData{
            pools       : pool_data(arg0),
            collaterals : collateral_data(arg0),
        };
        0x2::event::emit<MarketData>(v0);
    }

    public fun pool_data(arg0: &0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::market::Market) : vector<PoolData> {
        let v0 = 0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::market::borrow_dynamics(arg0);
        let v1 = 0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::market::interest_models(arg0);
        let v2 = 0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::reserve::balance_sheets(0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::market::vault(arg0));
        let v3 = 0xeacdf466dded111fa8a065ab270a1077ffd6a5074f7cebfa1809ea558af854db::ac_table::keys<0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::interest_model::InterestModels, 0x1::type_name::TypeName, 0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::interest_model::InterestModel>(v1);
        let v4 = 0;
        let v5 = 0x1::vector::empty<PoolData>();
        while (v4 < 0x1::vector::length<0x1::type_name::TypeName>(&v3)) {
            let v6 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v3, v4);
            let v7 = 0xeacdf466dded111fa8a065ab270a1077ffd6a5074f7cebfa1809ea558af854db::wit_table::borrow<0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::borrow_dynamics::BorrowDynamics, 0x1::type_name::TypeName, 0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::borrow_dynamics::BorrowDynamic>(v0, v6);
            let v8 = 0xeacdf466dded111fa8a065ab270a1077ffd6a5074f7cebfa1809ea558af854db::ac_table::borrow<0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::interest_model::InterestModels, 0x1::type_name::TypeName, 0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::interest_model::InterestModel>(v1, v6);
            let (v9, v10, v11) = 0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::reserve::balance_sheet(0xeacdf466dded111fa8a065ab270a1077ffd6a5074f7cebfa1809ea558af854db::wit_table::borrow<0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::reserve::BalanceSheets, 0x1::type_name::TypeName, 0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::reserve::BalanceSheet>(v2, v6));
            let v12 = PoolData{
                interestRate         : 0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::borrow_dynamics::interest_rate(v7),
                borrowIndex          : 0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::borrow_dynamics::borrow_index(v7),
                lastUpdated          : 0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::borrow_dynamics::last_updated(v7),
                type                 : v6,
                baseBorrowRatePerSec : 0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::interest_model::base_borrow_rate(v8),
                interestRateScale    : 0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::interest_model::interest_rate_scale(v8),
                reserveFactor        : 0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::interest_model::revenue_factor(v8),
                borrowFeeRate        : *0x2::dynamic_field::borrow<0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::market_dynamic_keys::BorrowFeeKey, 0x1::fixed_point32::FixedPoint32>(0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::market::uid(arg0), 0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::market_dynamic_keys::borrow_fee_key(v6)),
                minBorrowAmount      : 0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::interest_model::min_borrow_amount(v8),
                debt                 : v9,
                reserve              : v10,
                marketCoinSupply     : v11,
            };
            0x1::vector::push_back<PoolData>(&mut v5, v12);
            v4 = v4 + 1;
        };
        v5
    }

    // decompiled from Move bytecode v6
}

