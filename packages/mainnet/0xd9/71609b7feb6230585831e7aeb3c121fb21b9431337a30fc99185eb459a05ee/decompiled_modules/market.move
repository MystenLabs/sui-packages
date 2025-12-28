module 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market {
    struct Market has store, key {
        id: 0x2::object::UID,
        borrow_dynamics: 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::WitTable<0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::borrow_dynamics::BorrowDynamics, 0x1::type_name::TypeName, 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::borrow_dynamics::BorrowDynamic>,
        collateral_stats: 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::WitTable<0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::collateral_stats::CollateralStats, 0x1::type_name::TypeName, 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::collateral_stats::CollateralStat>,
        interest_models: 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::ac_table::AcTable<0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::interest_model::InterestModels, 0x1::type_name::TypeName, 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::interest_model::InterestModel>,
        risk_models: 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::ac_table::AcTable<0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::risk_model::RiskModels, 0x1::type_name::TypeName, 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::risk_model::RiskModel>,
        limiters: 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::WitTable<0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::limiter::Limiters, 0x1::type_name::TypeName, 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::limiter::Limiter>,
        reward_factors: 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::WitTable<0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::incentive_rewards::RewardFactors, 0x1::type_name::TypeName, 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::incentive_rewards::RewardFactor>,
        asset_active_states: 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::asset_active_state::AssetActiveStates,
        vault: 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::reserve::Reserve,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : (Market, 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::ac_table::AcTableCap<0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::interest_model::InterestModels>, 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::ac_table::AcTableCap<0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::risk_model::RiskModels>) {
        let (v0, v1) = 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::interest_model::new(arg0);
        let (v2, v3) = 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::risk_model::new(arg0);
        let v4 = Market{
            id                  : 0x2::object::new(arg0),
            borrow_dynamics     : 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::borrow_dynamics::new(arg0),
            collateral_stats    : 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::collateral_stats::new(arg0),
            interest_models     : v0,
            risk_models         : v2,
            limiters            : 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::limiter::init_table(arg0),
            reward_factors      : 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::incentive_rewards::init_table(arg0),
            asset_active_states : 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::asset_active_state::new(arg0),
            vault               : 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::reserve::new(arg0),
        };
        (v4, v1, v3)
    }

    public fun is_base_asset_active(arg0: &Market, arg1: 0x1::type_name::TypeName) : bool {
        0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::asset_active_state::is_base_asset_active(&arg0.asset_active_states, arg1)
    }

    public fun is_collateral_active(arg0: &Market, arg1: 0x1::type_name::TypeName) : bool {
        0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::asset_active_state::is_collateral_active(&arg0.asset_active_states, arg1)
    }

    public(friend) fun set_base_asset_active_state(arg0: &mut Market, arg1: 0x1::type_name::TypeName, arg2: bool) {
        0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::asset_active_state::set_base_asset_active_state(&mut arg0.asset_active_states, arg1, arg2);
    }

    public(friend) fun set_collateral_active_state(arg0: &mut Market, arg1: 0x1::type_name::TypeName, arg2: bool) {
        0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::asset_active_state::set_collateral_active_state(&mut arg0.asset_active_states, arg1, arg2);
    }

    public fun borrow_dynamics(arg0: &Market) : &0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::WitTable<0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::borrow_dynamics::BorrowDynamics, 0x1::type_name::TypeName, 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::borrow_dynamics::BorrowDynamic> {
        &arg0.borrow_dynamics
    }

    public(friend) fun register_coin<T0>(arg0: &mut Market, arg1: u64) {
        let v0 = 0x1::type_name::get<T0>();
        0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::reserve::register_coin<T0>(&mut arg0.vault);
        let v1 = 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::ac_table::borrow<0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::interest_model::InterestModels, 0x1::type_name::TypeName, 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::interest_model::InterestModel>(&arg0.interest_models, v0);
        0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::borrow_dynamics::register_coin<T0>(&mut arg0.borrow_dynamics, 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::interest_model::base_borrow_rate(v1), 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::interest_model::interest_rate_scale(v1), arg1);
        0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::asset_active_state::set_base_asset_active_state(&mut arg0.asset_active_states, v0, true);
    }

    public fun collateral_stats(arg0: &Market) : &0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::WitTable<0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::collateral_stats::CollateralStats, 0x1::type_name::TypeName, 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::collateral_stats::CollateralStat> {
        &arg0.collateral_stats
    }

    public fun interest_model(arg0: &Market, arg1: 0x1::type_name::TypeName) : &0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::interest_model::InterestModel {
        0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::ac_table::borrow<0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::interest_model::InterestModels, 0x1::type_name::TypeName, 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::interest_model::InterestModel>(&arg0.interest_models, arg1)
    }

    public(friend) fun accrue_all_interests(arg0: &mut Market, arg1: u64) {
        let v0 = 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::reserve::asset_types(&arg0.vault);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v2 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v1);
            if (0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::borrow_dynamics::last_updated_by_type(&arg0.borrow_dynamics, v2) == arg1) {
                v1 = v1 + 1;
                continue
            };
            0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::borrow_dynamics::update_borrow_index(&mut arg0.borrow_dynamics, v2, arg1);
            0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::reserve::increase_debt(&mut arg0.vault, v2, 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::sub(0x1::fixed_point32::create_from_rational(0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::borrow_dynamics::borrow_index_by_type(&arg0.borrow_dynamics, v2), 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::borrow_dynamics::borrow_index_by_type(&arg0.borrow_dynamics, v2)), 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::from_u64(1)), 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::interest_model::revenue_factor(0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::ac_table::borrow<0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::interest_model::InterestModels, 0x1::type_name::TypeName, 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::interest_model::InterestModel>(&arg0.interest_models, v2)));
            v1 = v1 + 1;
        };
    }

    public(friend) fun add_borrow_fee<T0>(arg0: &mut Market, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::reserve::add_borrow_fee<T0>(&mut arg0.vault, arg1, arg2);
    }

    public fun assert_whitelist_access(arg0: &Market, arg1: &0x2::tx_context::TxContext) {
        assert!(0x1318fdc90319ec9c24df1456d960a447521b0a658316155895014a6e39b5482f::whitelist::is_address_allowed(uid(arg0), 0x2::tx_context::sender(arg1)), 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::error::whitelist_error());
    }

    public(friend) fun borrow_flash_loan<T0>(arg0: &mut Market, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::reserve::FlashLoan<T0>) {
        0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::reserve::borrow_flash_loan<T0>(&mut arg0.vault, arg1, arg2)
    }

    public fun borrow_index(arg0: &Market, arg1: 0x1::type_name::TypeName) : u64 {
        0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::borrow_dynamics::borrow_index_by_type(&arg0.borrow_dynamics, arg1)
    }

    public(friend) fun compound_interests(arg0: &mut Market, arg1: u64) {
        accrue_all_interests(arg0, arg1);
        update_interest_rates(arg0);
    }

    public fun get_current_borrow_apr(arg0: &Market, arg1: 0x1::type_name::TypeName) : 0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::Decimal {
        let v0 = 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::borrow<0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::borrow_dynamics::BorrowDynamics, 0x1::type_name::TypeName, 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::borrow_dynamics::BorrowDynamic>(&arg0.borrow_dynamics, arg1);
        0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::mul(0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::div(0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::from_fixed_point32(0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::borrow_dynamics::interest_rate(v0)), 0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::from(0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::borrow_dynamics::interest_rate_scale(v0))), 0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::from(31536000))
    }

    public fun get_current_lending_apr(arg0: &Market, arg1: 0x1::type_name::TypeName) : 0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::Decimal {
        0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::mul(get_current_borrow_apr(arg0, arg1), 0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::mul(0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::from_fixed_point32(0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::reserve::util_rate(&arg0.vault, arg1)), 0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::sub(0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::from(1), 0x7caedbf4c4d64288771089889a8b3e8721e5522bb55d041b14a234bf5e4d242::decimal::from_fixed_point32(0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::interest_model::revenue_factor(0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::ac_table::borrow<0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::interest_model::InterestModels, 0x1::type_name::TypeName, 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::interest_model::InterestModel>(&arg0.interest_models, arg1))))))
    }

    public(friend) fun handle_add_collateral<T0>(arg0: &mut Market, arg1: u64) {
        let v0 = 0x1::type_name::get<T0>();
        0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::collateral_stats::increase(&mut arg0.collateral_stats, v0, arg1);
        assert!(0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::collateral_stats::collateral_amount(&arg0.collateral_stats, v0) <= 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::risk_model::max_collateral_Amount(0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::ac_table::borrow<0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::risk_model::RiskModels, 0x1::type_name::TypeName, 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::risk_model::RiskModel>(&arg0.risk_models, v0)), 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::error::max_collateral_reached_error());
    }

    public(friend) fun handle_borrow<T0>(arg0: &mut Market, arg1: u64, arg2: u64) : 0x2::balance::Balance<T0> {
        accrue_all_interests(arg0, arg2);
        let v0 = 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::reserve::handle_borrow<T0>(&mut arg0.vault, arg1);
        update_interest_rates(arg0);
        v0
    }

    public(friend) fun handle_inflow<T0>(arg0: &mut Market, arg1: u64, arg2: u64) {
        0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::limiter::reduce_outflow(&mut arg0.limiters, 0x1::type_name::get<T0>(), arg2, arg1);
    }

    public(friend) fun handle_liquidation<T0, T1>(arg0: &mut Market, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T0>, arg3: u64) {
        0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::reserve::handle_liquidation<T0>(&mut arg0.vault, arg1, arg2);
        0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::collateral_stats::decrease(&mut arg0.collateral_stats, 0x1::type_name::get<T1>(), arg3);
        update_interest_rates(arg0);
    }

    public(friend) fun handle_mint<T0>(arg0: &mut Market, arg1: 0x2::balance::Balance<T0>, arg2: u64) : 0x2::balance::Balance<0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::reserve::MarketCoin<T0>> {
        accrue_all_interests(arg0, arg2);
        let v0 = 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::reserve::mint_market_coin<T0>(&mut arg0.vault, arg1);
        update_interest_rates(arg0);
        v0
    }

    public(friend) fun handle_outflow<T0>(arg0: &mut Market, arg1: u64, arg2: u64) {
        0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::limiter::add_outflow(&mut arg0.limiters, 0x1::type_name::get<T0>(), arg2, arg1);
    }

    public(friend) fun handle_redeem<T0>(arg0: &mut Market, arg1: 0x2::balance::Balance<0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::reserve::MarketCoin<T0>>, arg2: u64) : 0x2::balance::Balance<T0> {
        accrue_all_interests(arg0, arg2);
        let v0 = 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::reserve::redeem_underlying_coin<T0>(&mut arg0.vault, arg1);
        update_interest_rates(arg0);
        v0
    }

    public(friend) fun handle_repay<T0>(arg0: &mut Market, arg1: 0x2::balance::Balance<T0>, arg2: u64) {
        assert!(0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::borrow_dynamics::last_updated_by_type(&arg0.borrow_dynamics, 0x1::type_name::get<T0>()) == arg2, 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::error::interest_is_not_accrued_error());
        0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::reserve::handle_repay<T0>(&mut arg0.vault, arg1);
        update_interest_rates(arg0);
    }

    public(friend) fun handle_withdraw_collateral<T0>(arg0: &mut Market, arg1: u64, arg2: u64) {
        accrue_all_interests(arg0, arg2);
        0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::collateral_stats::decrease(&mut arg0.collateral_stats, 0x1::type_name::get<T0>(), arg1);
        update_interest_rates(arg0);
    }

    public fun has_limiter(arg0: &Market, arg1: 0x1::type_name::TypeName) : bool {
        0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::contains<0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::limiter::Limiters, 0x1::type_name::TypeName, 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::limiter::Limiter>(&arg0.limiters, arg1)
    }

    public fun has_risk_model(arg0: &Market, arg1: 0x1::type_name::TypeName) : bool {
        0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::ac_table::contains<0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::risk_model::RiskModels, 0x1::type_name::TypeName, 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::risk_model::RiskModel>(&arg0.risk_models, arg1)
    }

    public(friend) fun init_market_coin_price_table(arg0: &mut Market, arg1: &mut 0x2::tx_context::TxContext) {
        0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::reserve::init_market_coin_price_table(&mut arg0.vault, arg1);
    }

    public fun interest_models(arg0: &Market) : &0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::ac_table::AcTable<0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::interest_model::InterestModels, 0x1::type_name::TypeName, 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::interest_model::InterestModel> {
        &arg0.interest_models
    }

    public(friend) fun interest_models_mut(arg0: &mut Market) : &mut 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::ac_table::AcTable<0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::interest_model::InterestModels, 0x1::type_name::TypeName, 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::interest_model::InterestModel> {
        &mut arg0.interest_models
    }

    public fun is_isolated_asset(arg0: &Market, arg1: 0x1::type_name::TypeName) : bool {
        let v0 = 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market_dynamic_keys::isolated_asset_key(arg1);
        if (!0x2::dynamic_field::exists_<0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market_dynamic_keys::IsolatedAssetKey>(&arg0.id, v0)) {
            return false
        };
        *0x2::dynamic_field::borrow<0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::market_dynamic_keys::IsolatedAssetKey, bool>(&arg0.id, v0)
    }

    public fun risk_model(arg0: &Market, arg1: 0x1::type_name::TypeName) : &0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::risk_model::RiskModel {
        0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::ac_table::borrow<0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::risk_model::RiskModels, 0x1::type_name::TypeName, 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::risk_model::RiskModel>(&arg0.risk_models, arg1)
    }

    public(friend) fun rate_limiter_mut(arg0: &mut Market) : &mut 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::WitTable<0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::limiter::Limiters, 0x1::type_name::TypeName, 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::limiter::Limiter> {
        &mut arg0.limiters
    }

    public(friend) fun register_collateral<T0>(arg0: &mut Market) {
        let v0 = 0x1::type_name::get<T0>();
        0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::collateral_stats::init_collateral_if_none(&mut arg0.collateral_stats, v0);
        0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::asset_active_state::set_collateral_active_state(&mut arg0.asset_active_states, v0, true);
    }

    public(friend) fun repay_flash_loan<T0>(arg0: &mut Market, arg1: 0x2::coin::Coin<T0>, arg2: 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::reserve::FlashLoan<T0>) {
        0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::reserve::repay_flash_loan<T0>(&mut arg0.vault, arg1, arg2);
    }

    public fun reward_factor(arg0: &Market, arg1: 0x1::type_name::TypeName) : &0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::incentive_rewards::RewardFactor {
        0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::borrow<0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::incentive_rewards::RewardFactors, 0x1::type_name::TypeName, 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::incentive_rewards::RewardFactor>(&arg0.reward_factors, arg1)
    }

    public fun reward_factors(arg0: &Market) : &0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::WitTable<0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::incentive_rewards::RewardFactors, 0x1::type_name::TypeName, 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::incentive_rewards::RewardFactor> {
        &arg0.reward_factors
    }

    public(friend) fun reward_factors_mut(arg0: &mut Market) : &mut 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::WitTable<0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::incentive_rewards::RewardFactors, 0x1::type_name::TypeName, 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::incentive_rewards::RewardFactor> {
        &mut arg0.reward_factors
    }

    public fun risk_models(arg0: &Market) : &0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::ac_table::AcTable<0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::risk_model::RiskModels, 0x1::type_name::TypeName, 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::risk_model::RiskModel> {
        &arg0.risk_models
    }

    public(friend) fun risk_models_mut(arg0: &mut Market) : &mut 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::ac_table::AcTable<0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::risk_model::RiskModels, 0x1::type_name::TypeName, 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::risk_model::RiskModel> {
        &mut arg0.risk_models
    }

    public(friend) fun set_flash_loan_fee<T0>(arg0: &mut Market, arg1: u64) {
        0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::reserve::set_flash_loan_fee<T0>(&mut arg0.vault, arg1);
    }

    public(friend) fun take_borrow_fee<T0>(arg0: &mut Market, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::reserve::take_borrow_fee<T0>(&mut arg0.vault, arg1, arg2)
    }

    public(friend) fun take_revenue<T0>(arg0: &mut Market, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::reserve::take_revenue<T0>(&mut arg0.vault, arg1, arg2)
    }

    public fun total_global_debt(arg0: &Market, arg1: 0x1::type_name::TypeName) : u64 {
        let (_, v1, _, _) = 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::reserve::balance_sheet(0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::borrow<0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::reserve::BalanceSheets, 0x1::type_name::TypeName, 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::reserve::BalanceSheet>(0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::reserve::balance_sheets(&arg0.vault), arg1));
        v1
    }

    public fun uid(arg0: &Market) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun uid_mut(arg0: &mut Market) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun uid_mut_delegated(arg0: &mut Market, arg1: 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::witness::Witness<Market>) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    fun update_interest_rates(arg0: &mut Market) {
        let v0 = 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::reserve::asset_types(&arg0.vault);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v2 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v1);
            let (v3, v4) = 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::interest_model::calc_interest(0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::ac_table::borrow<0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::interest_model::InterestModels, 0x1::type_name::TypeName, 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::interest_model::InterestModel>(&arg0.interest_models, v2), 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::reserve::util_rate(&arg0.vault, v2));
            0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::borrow_dynamics::update_interest_rate(&mut arg0.borrow_dynamics, v2, v3, v4);
            v1 = v1 + 1;
        };
    }

    public fun vault(arg0: &Market) : &0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::reserve::Reserve {
        &arg0.vault
    }

    // decompiled from Move bytecode v6
}

