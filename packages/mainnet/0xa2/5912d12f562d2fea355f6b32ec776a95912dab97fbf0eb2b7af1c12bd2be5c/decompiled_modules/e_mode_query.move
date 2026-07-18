module 0xa25912d12f562d2fea355f6b32ec776a95912dab97fbf0eb2b7af1c12bd2be5c::e_mode_query {
    struct EModeCategoryData has copy, drop, store {
        id: u8,
        collateralFactor: 0x1::fixed_point32::FixedPoint32,
        liquidationFactor: 0x1::fixed_point32::FixedPoint32,
        liquidationPenalty: 0x1::fixed_point32::FixedPoint32,
        liquidationDiscount: 0x1::fixed_point32::FixedPoint32,
        liquidationRevenueFactor: 0x1::fixed_point32::FixedPoint32,
        collateralAssets: vector<0x1::type_name::TypeName>,
        borrowAssets: vector<0x1::type_name::TypeName>,
    }

    public fun e_mode_category_exists(arg0: &0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::market::Market, arg1: u8) : bool {
        0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::e_mode::has_category(0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::market::uid(arg0), arg1)
    }

    public fun get_e_mode_category(arg0: &0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::market::Market, arg1: u8) : 0x1::option::Option<EModeCategoryData> {
        let v0 = 0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::market::uid(arg0);
        if (!0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::e_mode::has_category(v0, arg1)) {
            return 0x1::option::none<EModeCategoryData>()
        };
        let v1 = 0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::e_mode::get_category(v0, arg1);
        let v2 = EModeCategoryData{
            id                       : arg1,
            collateralFactor         : 0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::e_mode::collateral_factor(v1),
            liquidationFactor        : 0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::e_mode::liquidation_factor(v1),
            liquidationPenalty       : 0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::e_mode::liq_penalty(v1),
            liquidationDiscount      : 0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::e_mode::liq_discount(v1),
            liquidationRevenueFactor : 0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::e_mode::liq_revenue_factor(v1),
            collateralAssets         : *0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::e_mode::collateral_assets(v1),
            borrowAssets             : *0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::e_mode::borrow_assets(v1),
        };
        0x1::option::some<EModeCategoryData>(v2)
    }

    public fun get_obligation_e_mode(arg0: &0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::obligation::Obligation) : u8 {
        0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::obligation::e_mode_category(arg0)
    }

    // decompiled from Move bytecode v7
}

