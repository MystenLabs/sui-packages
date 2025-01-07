module 0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::account_value {
    public fun account_value_usd(arg0: &0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::credit_account::CreditAccount, arg1: &0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::price_receipt::PriceReceipt, arg2: &0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::tier_registry::TierRegistry) : u64 {
        weighted_colllateral_value_usd(arg0, arg1, arg2) - debt_value_usd(arg1)
    }

    public fun colllateral_value_usd(arg0: &0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::credit_account::CreditAccount, arg1: &0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::price_receipt::PriceReceipt) : u64 {
        let v0 = 0;
        let v1 = 0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::credit_account::assets_list(arg0);
        let v2 = 0;
        while (v0 < 0x1::vector::length<0x1::type_name::TypeName>(v1)) {
            v2 = v2 + 0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::price_receipt::get_asset_value(arg1, *0x1::vector::borrow<0x1::type_name::TypeName>(v1, v0));
        };
        v2
    }

    public fun debt_value_usd(arg0: &0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::price_receipt::PriceReceipt) : u64 {
        0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::price_receipt::get_debt_value(arg0)
    }

    public fun is_unhealthy(arg0: &0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::credit_account::CreditAccount, arg1: &0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::price_receipt::PriceReceipt, arg2: &0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::tier_registry::TierRegistry) : bool {
        weighted_colllateral_value_usd(arg0, arg1, arg2) <= debt_value_usd(arg1)
    }

    public fun max_borrow_amount_usd(arg0: &0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::credit_account::CreditAccount, arg1: &0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::price_receipt::PriceReceipt, arg2: &0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::tier_registry::TierRegistry) : u64 {
        0x1::fixed_point32::divide_u64(account_value_usd(arg0, arg1, arg2), weighted_collateral_pct(arg0, arg1, arg2))
    }

    public fun weighted_collateral_pct(arg0: &0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::credit_account::CreditAccount, arg1: &0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::price_receipt::PriceReceipt, arg2: &0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::tier_registry::TierRegistry) : 0x1::fixed_point32::FixedPoint32 {
        0x1::fixed_point32::create_from_rational(weighted_colllateral_value_usd(arg0, arg1, arg2), colllateral_value_usd(arg0, arg1))
    }

    public fun weighted_colllateral_value_usd(arg0: &0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::credit_account::CreditAccount, arg1: &0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::price_receipt::PriceReceipt, arg2: &0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::tier_registry::TierRegistry) : u64 {
        let v0 = 0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::tier::borrow_risk_config(0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::tier_registry::borrow_tier(arg2, 0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::credit_account::tier_id(arg0)));
        let v1 = 0;
        let v2 = 0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::credit_account::assets_list(arg0);
        let v3 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(v2)) {
            let v4 = 0x1::vector::borrow<0x1::type_name::TypeName>(v2, v1);
            v3 = v3 + 0x1::fixed_point32::multiply_u64(0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::price_receipt::get_asset_value(arg1, *v4), 0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::risk_model::get_collateral_pct(0xbdeb39e57a374985d9ac10e4e092faaea0529f1522a172d07ccb58c4f12a0ab0::risk_model::get_risk_model(v0, *v4)));
        };
        v3
    }

    // decompiled from Move bytecode v6
}

