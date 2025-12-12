module 0x118eef81291b2388017648bb6b1e1106775f91b1b14307f2cbbefcac450e8c82::market_query {
    struct PoolData has copy, drop, store {
        interestRate: 0x1::fixed_point32::FixedPoint32,
        borrowIndex: u64,
        lastUpdated: u64,
        type: 0x1::type_name::TypeName,
        baseBorrowRatePerSec: 0x1::fixed_point32::FixedPoint32,
        interestRateScale: u64,
        borrowFeeRate: 0x1::fixed_point32::FixedPoint32,
        minBorrowAmount: u64,
        debt: u64,
        reserve: u64,
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

    public fun collateral_data(arg0: &0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::market::Market) : vector<CollateralData> {
        let v0 = 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::market::risk_models(arg0);
        let v1 = 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::market::collateral_stats(arg0);
        let v2 = 0x299eb03bc4316da144229d483b833ee0d994faa1d19fdaa6eeec6d65b5c81ff0::ac_table::keys<0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::risk_model::RiskModels, 0x1::type_name::TypeName, 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::risk_model::RiskModel>(v0);
        let v3 = 0;
        let v4 = 0x1::vector::empty<CollateralData>();
        while (v3 < 0x1::vector::length<0x1::type_name::TypeName>(&v2)) {
            let v5 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v2, v3);
            let v6 = 0x299eb03bc4316da144229d483b833ee0d994faa1d19fdaa6eeec6d65b5c81ff0::ac_table::borrow<0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::risk_model::RiskModels, 0x1::type_name::TypeName, 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::risk_model::RiskModel>(v0, v5);
            let v7 = CollateralData{
                type                     : v5,
                collateralFactor         : 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::risk_model::collateral_factor(v6),
                liquidationFactor        : 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::risk_model::liq_factor(v6),
                liquidationPanelty       : 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::risk_model::liq_penalty(v6),
                liquidationDiscount      : 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::risk_model::liq_discount(v6),
                liquidationReserveFactor : 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::risk_model::liq_revenue_factor(v6),
                maxCollateralAmount      : 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::risk_model::max_collateral_amount(v6),
                totalCollateralAmount    : 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::collateral_stats::collateral_amount(v1, v5),
            };
            0x1::vector::push_back<CollateralData>(&mut v4, v7);
            v3 = v3 + 1;
        };
        v4
    }

    public fun market_data(arg0: &0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::market::Market) {
        let v0 = MarketData{
            pools       : pool_data(arg0),
            collaterals : collateral_data(arg0),
        };
        0x2::event::emit<MarketData>(v0);
    }

    public fun pool_data(arg0: &0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::market::Market) : vector<PoolData> {
        let v0 = 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::market::borrow_dynamics(arg0);
        let v1 = 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::market::interest_models(arg0);
        let v2 = 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::reserve::balance_sheets(0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::market::vault(arg0));
        let v3 = 0x299eb03bc4316da144229d483b833ee0d994faa1d19fdaa6eeec6d65b5c81ff0::ac_table::keys<0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::interest_model::InterestModels, 0x1::type_name::TypeName, 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::interest_model::InterestModel>(v1);
        let v4 = 0;
        let v5 = 0x1::vector::empty<PoolData>();
        while (v4 < 0x1::vector::length<0x1::type_name::TypeName>(&v3)) {
            let v6 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v3, v4);
            let v7 = 0x299eb03bc4316da144229d483b833ee0d994faa1d19fdaa6eeec6d65b5c81ff0::wit_table::borrow<0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::borrow_dynamics::BorrowDynamics, 0x1::type_name::TypeName, 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::borrow_dynamics::BorrowDynamic>(v0, v6);
            let v8 = 0x299eb03bc4316da144229d483b833ee0d994faa1d19fdaa6eeec6d65b5c81ff0::ac_table::borrow<0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::interest_model::InterestModels, 0x1::type_name::TypeName, 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::interest_model::InterestModel>(v1, v6);
            let (v9, v10) = 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::reserve::balance_sheet(0x299eb03bc4316da144229d483b833ee0d994faa1d19fdaa6eeec6d65b5c81ff0::wit_table::borrow<0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::reserve::BalanceSheets, 0x1::type_name::TypeName, 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::reserve::BalanceSheet>(v2, v6));
            let v11 = PoolData{
                interestRate         : 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::borrow_dynamics::interest_rate(v7),
                borrowIndex          : 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::borrow_dynamics::borrow_index(v7),
                lastUpdated          : 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::borrow_dynamics::last_updated(v7),
                type                 : v6,
                baseBorrowRatePerSec : 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::interest_model::base_borrow_rate(v8),
                interestRateScale    : 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::interest_model::interest_rate_scale(v8),
                borrowFeeRate        : *0x2::dynamic_field::borrow<0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::market_dynamic_keys::BorrowFeeKey, 0x1::fixed_point32::FixedPoint32>(0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::market::uid(arg0), 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::market_dynamic_keys::borrow_fee_key(v6)),
                minBorrowAmount      : 0xae8efe2d8da673bc88a429e5c584c4b60114e3a0a3610ad7b789f39aa9051fc4::interest_model::min_borrow_amount(v8),
                debt                 : v9,
                reserve              : v10,
            };
            0x1::vector::push_back<PoolData>(&mut v5, v11);
            v4 = v4 + 1;
        };
        v5
    }

    // decompiled from Move bytecode v6
}

