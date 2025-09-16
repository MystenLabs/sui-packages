module 0x4f0777c1d88297c17de9adf59abb736c96f9deab679a34d6dd3e24fccad03829::manager_info {
    struct AssetInfo has copy, drop {
        asset: u64,
        debt: u64,
        usd_asset: u64,
        usd_debt: u64,
    }

    struct ManagerInfo has copy, drop {
        base: AssetInfo,
        quote: AssetInfo,
        debt: u64,
        asset_usd: u64,
        debt_usd: u64,
        risk_ratio: u64,
        base_per_dollar: u64,
        quote_per_dollar: u64,
        debt_per_dollar: u64,
        user_liquidation_reward: u64,
        pool_liquidation_reward: u64,
        target_ratio: u64,
    }

    struct Fulfillment {
        manager_id: 0x2::object::ID,
        repay_amount: u64,
        pool_reward_amount: u64,
        default_amount: u64,
        base_exit_amount: u64,
        quote_exit_amount: u64,
        risk_ratio: u64,
    }

    public(friend) fun base_exit_amount(arg0: &Fulfillment) : u64 {
        arg0.base_exit_amount
    }

    public(friend) fun calculate_return_amounts(arg0: u64, arg1: u64, arg2: u64) : (u64, u64) {
        (0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::math::mul(arg0, arg1), 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::math::mul(arg0, arg2))
    }

    public(friend) fun calculate_usd_amount_to_repay(arg0: &ManagerInfo) : u64 {
        let v0 = arg0.target_ratio;
        let v1 = arg0.user_liquidation_reward + arg0.pool_liquidation_reward;
        0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::math::mul(0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::math::div(0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::math::mul(v0, 0x1::u64::max(arg0.base.usd_debt, arg0.quote.usd_debt)) - arg0.base.usd_asset + arg0.quote.usd_asset, v0 - 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::constants::float_scaling() + v1), 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::constants::float_scaling() + v1)
    }

    public(friend) fun default_amount(arg0: &Fulfillment) : u64 {
        arg0.default_amount
    }

    public(friend) fun drop(arg0: Fulfillment) {
        let Fulfillment {
            manager_id         : _,
            repay_amount       : _,
            pool_reward_amount : _,
            default_amount     : _,
            base_exit_amount   : _,
            quote_exit_amount  : _,
            risk_ratio         : _,
        } = arg0;
    }

    public(friend) fun fulfillment_risk_ratio(arg0: &Fulfillment) : u64 {
        arg0.risk_ratio
    }

    public(friend) fun manager_id(arg0: &Fulfillment) : 0x2::object::ID {
        arg0.manager_id
    }

    public(friend) fun new_manager_info<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: &0x4f0777c1d88297c17de9adf59abb736c96f9deab679a34d6dd3e24fccad03829::margin_registry::MarginRegistry, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x2::clock::Clock, arg8: 0x2::object::ID) : ManagerInfo {
        let v0 = 0x4f0777c1d88297c17de9adf59abb736c96f9deab679a34d6dd3e24fccad03829::oracle::calculate_target_amount<T0>(arg5, arg4, 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::constants::float_scaling(), arg7);
        let v1 = 0x4f0777c1d88297c17de9adf59abb736c96f9deab679a34d6dd3e24fccad03829::oracle::calculate_target_amount<T1>(arg6, arg4, 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::constants::float_scaling(), arg7);
        let v2 = if (arg2 > 0) {
            v0
        } else {
            v1
        };
        let v3 = if (arg2 > 0) {
            0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::math::div(arg2, v0)
        } else {
            0
        };
        let v4 = if (arg3 > 0) {
            0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::math::div(arg3, v1)
        } else {
            0
        };
        let v5 = 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::math::div(arg0, v0);
        let v6 = 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::math::div(arg1, v1);
        let v7 = v3 + v4;
        let v8 = v5 + v6;
        let v9 = 0x4f0777c1d88297c17de9adf59abb736c96f9deab679a34d6dd3e24fccad03829::margin_constants::max_risk_ratio();
        let v10 = if (v7 == 0 || v8 > 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::math::mul(v7, v9)) {
            v9
        } else {
            0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::math::div(v8, v7)
        };
        let v11 = AssetInfo{
            asset     : arg0,
            debt      : arg2,
            usd_asset : v5,
            usd_debt  : v3,
        };
        let v12 = AssetInfo{
            asset     : arg1,
            debt      : arg3,
            usd_asset : v6,
            usd_debt  : v4,
        };
        ManagerInfo{
            base                    : v11,
            quote                   : v12,
            debt                    : 0x1::u64::max(arg2, arg3),
            asset_usd               : v8,
            debt_usd                : v7,
            risk_ratio              : v10,
            base_per_dollar         : v0,
            quote_per_dollar        : v1,
            debt_per_dollar         : v2,
            user_liquidation_reward : 0x4f0777c1d88297c17de9adf59abb736c96f9deab679a34d6dd3e24fccad03829::margin_registry::user_liquidation_reward(arg4, arg8),
            pool_liquidation_reward : 0x4f0777c1d88297c17de9adf59abb736c96f9deab679a34d6dd3e24fccad03829::margin_registry::pool_liquidation_reward(arg4, arg8),
            target_ratio            : 0x4f0777c1d88297c17de9adf59abb736c96f9deab679a34d6dd3e24fccad03829::margin_registry::target_liquidation_risk_ratio(arg4, arg8),
        }
    }

    public(friend) fun pool_liquidation_reward(arg0: &ManagerInfo) : u64 {
        arg0.pool_liquidation_reward
    }

    public(friend) fun pool_reward_amount(arg0: &Fulfillment) : u64 {
        arg0.pool_reward_amount
    }

    public(friend) fun produce_fulfillment(arg0: &ManagerInfo, arg1: 0x2::object::ID) : Fulfillment {
        let v0 = 0x1::u64::min(arg0.asset_usd, calculate_usd_amount_to_repay(arg0));
        let v1 = 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::math::div(v0, 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::constants::float_scaling() + arg0.user_liquidation_reward + arg0.pool_liquidation_reward);
        let v2 = if (arg0.debt_usd > arg0.asset_usd) {
            arg0.debt_usd - v1
        } else {
            0
        };
        let (v3, v4) = if (arg0.base.debt > 0) {
            let v5 = 0x1::u64::min(v0, arg0.base.usd_asset);
            (v5, 0x1::u64::min(v0 - v5, arg0.quote.usd_asset))
        } else {
            let v6 = 0x1::u64::min(v0, arg0.quote.usd_asset);
            (0x1::u64::min(v0 - v6, arg0.base.usd_asset), v6)
        };
        Fulfillment{
            manager_id         : arg1,
            repay_amount       : 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::math::mul(v1, arg0.debt_per_dollar),
            pool_reward_amount : 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::math::mul(0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::math::mul(v1, arg0.pool_liquidation_reward), arg0.debt_per_dollar),
            default_amount     : 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::math::mul(v2, arg0.debt_per_dollar),
            base_exit_amount   : 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::math::mul(v3, arg0.base_per_dollar),
            quote_exit_amount  : 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::math::mul(v4, arg0.quote_per_dollar),
            risk_ratio         : arg0.risk_ratio,
        }
    }

    public(friend) fun quote_exit_amount(arg0: &Fulfillment) : u64 {
        arg0.quote_exit_amount
    }

    public(friend) fun repay_amount(arg0: &Fulfillment) : u64 {
        arg0.repay_amount
    }

    public fun risk_ratio(arg0: &ManagerInfo) : u64 {
        arg0.risk_ratio
    }

    public(friend) fun update_fulfillment(arg0: &mut Fulfillment, arg1: u64) : u64 {
        let v0 = arg0.repay_amount + arg0.pool_reward_amount;
        let v1 = arg1 >= v0;
        let v2 = if (v1) {
            0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::constants::float_scaling()
        } else {
            0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::math::div(arg1, v0)
        };
        let v3 = if (v1) {
            arg0.default_amount
        } else {
            0
        };
        arg0.repay_amount = 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::math::mul(v2, arg0.repay_amount);
        arg0.pool_reward_amount = 0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::math::mul(v2, arg0.pool_reward_amount);
        arg0.default_amount = v3;
        0xd5377267e2527db33040fedc063d3990f9942b629b406931190e3685ac45621e::constants::float_scaling() - v2
    }

    public(friend) fun user_liquidation_reward(arg0: &ManagerInfo) : u64 {
        arg0.user_liquidation_reward
    }

    // decompiled from Move bytecode v6
}

