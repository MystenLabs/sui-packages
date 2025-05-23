module 0xf52caf3b0fa707016d5e734fb5d0336c5ce058e5ef3ae5bb99d592b5d6e69e3a::market_query {
    struct PoolData has copy, drop, store {
        interestRate: 0x1::fixed_point32::FixedPoint32,
        borrowIndex: u64,
        lastUpdated: u64,
        type: 0x1::type_name::TypeName,
        baseBorrowRatePerSec: 0x1::fixed_point32::FixedPoint32,
        lowSlope: 0x1::fixed_point32::FixedPoint32,
        kink: 0x1::fixed_point32::FixedPoint32,
        highSlope: 0x1::fixed_point32::FixedPoint32,
        reserveFactor: 0x1::fixed_point32::FixedPoint32,
        minBorrowAmount: u64,
        borrowWeight: 0x1::fixed_point32::FixedPoint32,
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

    public fun collateral_data(arg0: &0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::market::Market) : vector<CollateralData> {
        let v0 = 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::market::risk_models(arg0);
        let v1 = 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::market::collateral_stats(arg0);
        let v2 = 0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::ac_table::keys<0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::risk_model::RiskModels, 0x1::type_name::TypeName, 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::risk_model::RiskModel>(v0);
        let v3 = 0;
        let v4 = 0x1::vector::empty<CollateralData>();
        while (v3 < 0x1::vector::length<0x1::type_name::TypeName>(&v2)) {
            let v5 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v2, v3);
            let v6 = 0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::ac_table::borrow<0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::risk_model::RiskModels, 0x1::type_name::TypeName, 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::risk_model::RiskModel>(v0, v5);
            let v7 = CollateralData{
                type                     : v5,
                collateralFactor         : 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::risk_model::collateral_factor(v6),
                liquidationFactor        : 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::risk_model::liq_factor(v6),
                liquidationPanelty       : 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::risk_model::liq_penalty(v6),
                liquidationDiscount      : 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::risk_model::liq_discount(v6),
                liquidationReserveFactor : 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::risk_model::liq_revenue_factor(v6),
                maxCollateralAmount      : 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::risk_model::max_collateral_Amount(v6),
                totalCollateralAmount    : 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::collateral_stats::collateral_amount(v1, v5),
            };
            0x1::vector::push_back<CollateralData>(&mut v4, v7);
            v3 = v3 + 1;
        };
        v4
    }

    public fun market_data(arg0: &0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::market::Market) {
        let v0 = MarketData{
            pools       : pool_data(arg0),
            collaterals : collateral_data(arg0),
        };
        0x2::event::emit<MarketData>(v0);
    }

    public fun pool_data(arg0: &0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::market::Market) : vector<PoolData> {
        let v0 = 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::market::borrow_dynamics(arg0);
        let v1 = 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::market::interest_models(arg0);
        let v2 = 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::reserve::balance_sheets(0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::market::vault(arg0));
        let v3 = 0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::ac_table::keys<0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::interest_model::InterestModels, 0x1::type_name::TypeName, 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::interest_model::InterestModel>(v1);
        let v4 = 0;
        let v5 = 0x1::vector::empty<PoolData>();
        while (v4 < 0x1::vector::length<0x1::type_name::TypeName>(&v3)) {
            let v6 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v3, v4);
            let v7 = 0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::wit_table::borrow<0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::borrow_dynamics::BorrowDynamics, 0x1::type_name::TypeName, 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::borrow_dynamics::BorrowDynamic>(v0, v6);
            let v8 = 0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::ac_table::borrow<0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::interest_model::InterestModels, 0x1::type_name::TypeName, 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::interest_model::InterestModel>(v1, v6);
            let (v9, v10, v11, v12) = 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::reserve::balance_sheet(0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::wit_table::borrow<0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::reserve::BalanceSheets, 0x1::type_name::TypeName, 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::reserve::BalanceSheet>(v2, v6));
            let v13 = PoolData{
                interestRate         : 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::borrow_dynamics::interest_rate(v7),
                borrowIndex          : 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::borrow_dynamics::borrow_index(v7),
                lastUpdated          : 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::borrow_dynamics::last_updated(v7),
                type                 : 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::interest_model::type_name(v8),
                baseBorrowRatePerSec : 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::interest_model::base_borrow_rate(v8),
                lowSlope             : 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::interest_model::low_slope(v8),
                kink                 : 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::interest_model::kink(v8),
                highSlope            : 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::interest_model::high_slope(v8),
                reserveFactor        : 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::interest_model::revenue_factor(v8),
                minBorrowAmount      : 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::interest_model::min_borrow_amount(v8),
                borrowWeight         : 0x2dd06d613df41798ba7c02d839c9d1c47e8bab30873f913d92398859476cb6d4::interest_model::borrow_weight(v8),
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

