module 0x2f7b0446b7d3e170e7e32859e46361fddcad8f29eb87552d4640e4d7b1efef99::market_query {
    struct PoolData has copy, drop, store {
        interestRate: 0x1::fixed_point32::FixedPoint32,
        borrowIndex: u64,
        lastUpdated: u64,
        type: 0x1::type_name::TypeName,
        baseBorrowRatePerSec: 0x1::fixed_point32::FixedPoint32,
        interestRateScale: u64,
        borrowRateOnMidKink: 0x1::fixed_point32::FixedPoint32,
        midKink: 0x1::fixed_point32::FixedPoint32,
        borrowRateOnHighKink: 0x1::fixed_point32::FixedPoint32,
        highKink: 0x1::fixed_point32::FixedPoint32,
        maxBorrowRate: 0x1::fixed_point32::FixedPoint32,
        reserveFactor: 0x1::fixed_point32::FixedPoint32,
        borrowWeight: 0x1::fixed_point32::FixedPoint32,
        minBorrowAmount: u64,
        cash: u64,
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

    public fun collateral_data(arg0: &0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::market::Market) : vector<CollateralData> {
        let v0 = 0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::market::risk_models(arg0);
        let v1 = 0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::market::collateral_stats(arg0);
        let v2 = 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::ac_table::keys<0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::risk_model::RiskModels, 0x1::type_name::TypeName, 0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::risk_model::RiskModel>(v0);
        let v3 = 0;
        let v4 = 0x1::vector::empty<CollateralData>();
        while (v3 < 0x1::vector::length<0x1::type_name::TypeName>(&v2)) {
            let v5 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v2, v3);
            let v6 = 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::ac_table::borrow<0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::risk_model::RiskModels, 0x1::type_name::TypeName, 0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::risk_model::RiskModel>(v0, v5);
            let v7 = CollateralData{
                type                     : v5,
                collateralFactor         : 0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::risk_model::collateral_factor(v6),
                liquidationFactor        : 0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::risk_model::liq_factor(v6),
                liquidationPanelty       : 0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::risk_model::liq_penalty(v6),
                liquidationDiscount      : 0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::risk_model::liq_discount(v6),
                liquidationReserveFactor : 0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::risk_model::liq_revenue_factor(v6),
                maxCollateralAmount      : 0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::risk_model::max_collateral_Amount(v6),
                totalCollateralAmount    : 0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::collateral_stats::collateral_amount(v1, v5),
            };
            0x1::vector::push_back<CollateralData>(&mut v4, v7);
            v3 = v3 + 1;
        };
        v4
    }

    public fun market_data(arg0: &0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::market::Market) {
        let v0 = MarketData{
            pools       : pool_data(arg0),
            collaterals : collateral_data(arg0),
        };
        0x2::event::emit<MarketData>(v0);
    }

    public fun pool_data(arg0: &0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::market::Market) : vector<PoolData> {
        let v0 = 0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::market::borrow_dynamics(arg0);
        let v1 = 0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::market::interest_models(arg0);
        let v2 = 0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::reserve::balance_sheets(0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::market::vault(arg0));
        let v3 = 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::ac_table::keys<0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::interest_model::InterestModels, 0x1::type_name::TypeName, 0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::interest_model::InterestModel>(v1);
        let v4 = 0;
        let v5 = 0x1::vector::empty<PoolData>();
        while (v4 < 0x1::vector::length<0x1::type_name::TypeName>(&v3)) {
            let v6 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v3, v4);
            let v7 = 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::borrow<0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::borrow_dynamics::BorrowDynamics, 0x1::type_name::TypeName, 0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::borrow_dynamics::BorrowDynamic>(v0, v6);
            let v8 = 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::ac_table::borrow<0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::interest_model::InterestModels, 0x1::type_name::TypeName, 0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::interest_model::InterestModel>(v1, v6);
            let (v9, v10, v11, v12) = 0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::reserve::balance_sheet(0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::borrow<0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::reserve::BalanceSheets, 0x1::type_name::TypeName, 0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::reserve::BalanceSheet>(v2, v6));
            let v13 = PoolData{
                interestRate         : 0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::borrow_dynamics::interest_rate(v7),
                borrowIndex          : 0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::borrow_dynamics::borrow_index(v7),
                lastUpdated          : 0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::borrow_dynamics::last_updated(v7),
                type                 : 0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::interest_model::type_name(v8),
                baseBorrowRatePerSec : 0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::interest_model::base_borrow_rate(v8),
                interestRateScale    : 0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::interest_model::interest_rate_scale(v8),
                borrowRateOnMidKink  : 0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::interest_model::borrow_rate_on_mid_kink(v8),
                midKink              : 0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::interest_model::mid_kink(v8),
                borrowRateOnHighKink : 0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::interest_model::borrow_rate_on_high_kink(v8),
                highKink             : 0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::interest_model::high_kink(v8),
                maxBorrowRate        : 0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::interest_model::max_borrow_rate(v8),
                reserveFactor        : 0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::interest_model::revenue_factor(v8),
                borrowWeight         : 0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::interest_model::borrow_weight(v8),
                minBorrowAmount      : 0x882e90a50f55bf72ce05ebab5603bac84668542d47cf1e2462894e9821aed23b::interest_model::min_borrow_amount(v8),
                cash                 : v9,
                debt                 : v10,
                reserve              : v11,
                marketCoinSupply     : v12,
            };
            0x1::vector::push_back<PoolData>(&mut v5, v13);
            v4 = v4 + 1;
        };
        v5
    }

    // decompiled from Move bytecode v6
}

