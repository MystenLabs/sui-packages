module 0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::account_value {
    struct CollateralCalc has copy, drop, store {
        asset_type: 0x1::type_name::TypeName,
        asset_value: u64,
    }

    struct WeightedCollateralCalc has copy, drop, store {
        asset_type: 0x1::type_name::TypeName,
        asset_value: u64,
        weighted_asset_value: u64,
    }

    public fun account_value_usd(arg0: &0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::credit_account::CreditAccount, arg1: &0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::price_receipt::PriceReceipt, arg2: &0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::tier_registry::TierRegistry) : u64 {
        weighted_colllateral_value_usd(arg0, arg1, arg2) - debt_value_usd(arg1)
    }

    public fun colllateral_value_usd(arg0: &0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::credit_account::CreditAccount, arg1: &0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::price_receipt::PriceReceipt) : u64 {
        let v0 = 0;
        let v1 = 0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::credit_account::assets_list(arg0);
        let v2 = 0;
        while (v0 < 0x1::vector::length<0x1::type_name::TypeName>(v1)) {
            let v3 = 0x1::vector::borrow<0x1::type_name::TypeName>(v1, v0);
            let v4 = 0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::price_receipt::get_asset_value(arg1, *v3);
            v2 = v2 + v4;
            let v5 = CollateralCalc{
                asset_type  : *v3,
                asset_value : v4,
            };
            0x2::event::emit<CollateralCalc>(v5);
            v0 = v0 + 1;
        };
        v2
    }

    public fun debt_value_usd(arg0: &0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::price_receipt::PriceReceipt) : u64 {
        0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::price_receipt::get_debt_value(arg0)
    }

    public fun is_unhealthy(arg0: &0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::credit_account::CreditAccount, arg1: &0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::price_receipt::PriceReceipt, arg2: &0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::tier_registry::TierRegistry) : bool {
        weighted_colllateral_value_usd(arg0, arg1, arg2) <= debt_value_usd(arg1)
    }

    public fun max_borrow_amount_usd(arg0: &0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::credit_account::CreditAccount, arg1: &0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::price_receipt::PriceReceipt, arg2: &0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::tier_registry::TierRegistry) : u64 {
        0x1::fixed_point32::divide_u64(account_value_usd(arg0, arg1, arg2), weighted_collateral_pct(arg0, arg1, arg2))
    }

    public fun weighted_collateral_pct(arg0: &0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::credit_account::CreditAccount, arg1: &0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::price_receipt::PriceReceipt, arg2: &0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::tier_registry::TierRegistry) : 0x1::fixed_point32::FixedPoint32 {
        0x1::fixed_point32::create_from_rational(weighted_colllateral_value_usd(arg0, arg1, arg2), colllateral_value_usd(arg0, arg1))
    }

    public fun weighted_colllateral_value_usd(arg0: &0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::credit_account::CreditAccount, arg1: &0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::price_receipt::PriceReceipt, arg2: &0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::tier_registry::TierRegistry) : u64 {
        let v0 = 0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::tier::borrow_risk_config(0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::tier_registry::borrow_tier(arg2, 0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::credit_account::tier_id(arg0)));
        let v1 = 0;
        let v2 = 0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::credit_account::assets_list(arg0);
        let v3 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(v2)) {
            let v4 = 0x1::vector::borrow<0x1::type_name::TypeName>(v2, v1);
            let v5 = 0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::price_receipt::get_asset_value(arg1, *v4);
            let v6 = 0x1::fixed_point32::multiply_u64(v5, 0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::risk_model::get_collateral_pct(0x1d7b0d23f816d45598cc5227ab6f50453247f5c5504d2a73396abee80f75849e::risk_model::get_risk_model(v0, *v4)));
            let v7 = WeightedCollateralCalc{
                asset_type           : *v4,
                asset_value          : v5,
                weighted_asset_value : v6,
            };
            0x2::event::emit<WeightedCollateralCalc>(v7);
            v3 = v3 + v6;
            v1 = v1 + 1;
        };
        v3
    }

    // decompiled from Move bytecode v6
}

