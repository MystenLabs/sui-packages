module 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market {
    struct Market has store, key {
        id: 0x2::object::UID,
        borrow_dynamics: 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::WitTable<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::borrow_dynamics::BorrowDynamics, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::borrow_dynamics::BorrowDynamic>,
        collateral_stats: 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::WitTable<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::collateral_stats::CollateralStats, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::collateral_stats::CollateralStat>,
        interest_models: 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::ac_table::AcTable<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::interest_model::InterestModels, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::interest_model::InterestModel>,
        risk_models: 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::ac_table::AcTable<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::risk_model::RiskModels, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::risk_model::RiskModel>,
        limiters: 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::WitTable<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::limiter::Limiters, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::limiter::Limiter>,
        reward_factors: 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::WitTable<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::incentive_rewards::RewardFactors, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::incentive_rewards::RewardFactor>,
        asset_active_states: 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::asset_active_state::AssetActiveStates,
        vault: 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::Reserve,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : (Market, 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::ac_table::AcTableCap<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::interest_model::InterestModels>, 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::ac_table::AcTableCap<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::risk_model::RiskModels>) {
        let (v0, v1) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::interest_model::new(arg0);
        let (v2, v3) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::risk_model::new(arg0);
        let v4 = Market{
            id                  : 0x2::object::new(arg0),
            borrow_dynamics     : 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::borrow_dynamics::new(arg0),
            collateral_stats    : 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::collateral_stats::new(arg0),
            interest_models     : v0,
            risk_models         : v2,
            limiters            : 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::limiter::init_table(arg0),
            reward_factors      : 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::incentive_rewards::init_table(arg0),
            asset_active_states : 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::asset_active_state::new(arg0),
            vault               : 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::new(arg0),
        };
        (v4, v1, v3)
    }

    public fun is_base_asset_active(arg0: &Market, arg1: 0x1::type_name::TypeName) : bool {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::asset_active_state::is_base_asset_active(&arg0.asset_active_states, arg1)
    }

    public fun is_collateral_active(arg0: &Market, arg1: 0x1::type_name::TypeName) : bool {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::asset_active_state::is_collateral_active(&arg0.asset_active_states, arg1)
    }

    public(friend) fun set_base_asset_active_state<T0>(arg0: &mut Market, arg1: bool) {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::asset_active_state::set_base_asset_active_state(&mut arg0.asset_active_states, 0x1::type_name::get<T0>(), arg1);
    }

    public(friend) fun set_collateral_active_state<T0>(arg0: &mut Market, arg1: bool) {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::asset_active_state::set_collateral_active_state(&mut arg0.asset_active_states, 0x1::type_name::get<T0>(), arg1);
    }

    public fun borrow_dynamics(arg0: &Market) : &0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::WitTable<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::borrow_dynamics::BorrowDynamics, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::borrow_dynamics::BorrowDynamic> {
        &arg0.borrow_dynamics
    }

    public(friend) fun register_coin<T0>(arg0: &mut Market, arg1: u64) {
        let v0 = 0x1::type_name::get<T0>();
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::register_coin<T0>(&mut arg0.vault);
        let v1 = 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::ac_table::borrow<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::interest_model::InterestModels, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::interest_model::InterestModel>(&arg0.interest_models, v0);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::borrow_dynamics::register_coin<T0>(&mut arg0.borrow_dynamics, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::interest_model::base_borrow_rate(v1), 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::interest_model::interest_rate_scale(v1), arg1);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::asset_active_state::set_base_asset_active_state(&mut arg0.asset_active_states, v0, true);
    }

    public fun collateral_stats(arg0: &Market) : &0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::WitTable<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::collateral_stats::CollateralStats, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::collateral_stats::CollateralStat> {
        &arg0.collateral_stats
    }

    public fun interest_model(arg0: &Market, arg1: 0x1::type_name::TypeName) : &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::interest_model::InterestModel {
        0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::ac_table::borrow<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::interest_model::InterestModels, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::interest_model::InterestModel>(&arg0.interest_models, arg1)
    }

    public(friend) fun accrue_all_interests(arg0: &mut Market, arg1: u64) {
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::asset_types(&arg0.vault);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v2 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v1);
            if (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::borrow_dynamics::last_updated_by_type(&arg0.borrow_dynamics, v2) == arg1) {
                v1 = v1 + 1;
                continue
            };
            0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::borrow_dynamics::update_borrow_index(&mut arg0.borrow_dynamics, v2, arg1);
            0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::increase_debt(&mut arg0.vault, v2, 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::sub(0x1::fixed_point32::create_from_rational(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::borrow_dynamics::borrow_index_by_type(&arg0.borrow_dynamics, v2), 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::borrow_dynamics::borrow_index_by_type(&arg0.borrow_dynamics, v2)), 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::from_u64(1)), 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::interest_model::revenue_factor(0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::ac_table::borrow<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::interest_model::InterestModels, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::interest_model::InterestModel>(&arg0.interest_models, v2)));
            v1 = v1 + 1;
        };
    }

    public(friend) fun borrow_flash_loan<T0>(arg0: &mut Market, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::FlashLoan<T0>) {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::borrow_flash_loan<T0>(&mut arg0.vault, arg1, arg2)
    }

    public fun borrow_index(arg0: &Market, arg1: 0x1::type_name::TypeName) : u64 {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::borrow_dynamics::borrow_index_by_type(&arg0.borrow_dynamics, arg1)
    }

    public(friend) fun compound_interests(arg0: &mut Market, arg1: u64) {
        accrue_all_interests(arg0, arg1);
        update_interest_rates(arg0);
    }

    public(friend) fun handle_add_collateral<T0>(arg0: &mut Market, arg1: u64) {
        let v0 = 0x1::type_name::get<T0>();
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::collateral_stats::increase(&mut arg0.collateral_stats, v0, arg1);
        assert!(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::collateral_stats::collateral_amount(&arg0.collateral_stats, v0) <= 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::risk_model::max_collateral_Amount(0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::ac_table::borrow<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::risk_model::RiskModels, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::risk_model::RiskModel>(&arg0.risk_models, v0)), 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::error::max_collateral_reached_error());
    }

    public(friend) fun handle_borrow<T0>(arg0: &mut Market, arg1: u64, arg2: u64) : 0x2::balance::Balance<T0> {
        accrue_all_interests(arg0, arg2);
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::handle_borrow<T0>(&mut arg0.vault, arg1);
        update_interest_rates(arg0);
        v0
    }

    public(friend) fun handle_inflow<T0>(arg0: &mut Market, arg1: u64, arg2: u64) {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::limiter::reduce_outflow(&mut arg0.limiters, 0x1::type_name::get<T0>(), arg2, arg1);
    }

    public(friend) fun handle_liquidation<T0, T1>(arg0: &mut Market, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T0>, arg3: u64) {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::handle_liquidation<T0>(&mut arg0.vault, arg1, arg2);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::collateral_stats::decrease(&mut arg0.collateral_stats, 0x1::type_name::get<T1>(), arg3);
        update_interest_rates(arg0);
    }

    public(friend) fun handle_mint<T0>(arg0: &mut Market, arg1: 0x2::balance::Balance<T0>, arg2: u64) : 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>> {
        accrue_all_interests(arg0, arg2);
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::mint_market_coin<T0>(&mut arg0.vault, arg1);
        update_interest_rates(arg0);
        v0
    }

    public(friend) fun handle_outflow<T0>(arg0: &mut Market, arg1: u64, arg2: u64) {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::limiter::add_outflow(&mut arg0.limiters, 0x1::type_name::get<T0>(), arg2, arg1);
    }

    public(friend) fun handle_redeem<T0>(arg0: &mut Market, arg1: 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>, arg2: u64) : 0x2::balance::Balance<T0> {
        accrue_all_interests(arg0, arg2);
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::redeem_underlying_coin<T0>(&mut arg0.vault, arg1);
        update_interest_rates(arg0);
        v0
    }

    public(friend) fun handle_repay<T0>(arg0: &mut Market, arg1: 0x2::balance::Balance<T0>) {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::handle_repay<T0>(&mut arg0.vault, arg1);
        update_interest_rates(arg0);
    }

    public(friend) fun handle_withdraw_collateral<T0>(arg0: &mut Market, arg1: u64, arg2: u64) {
        accrue_all_interests(arg0, arg2);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::collateral_stats::decrease(&mut arg0.collateral_stats, 0x1::type_name::get<T0>(), arg1);
        update_interest_rates(arg0);
    }

    public fun has_limiter(arg0: &Market, arg1: 0x1::type_name::TypeName) : bool {
        0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::contains<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::limiter::Limiters, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::limiter::Limiter>(&arg0.limiters, arg1)
    }

    public fun has_risk_model(arg0: &Market, arg1: 0x1::type_name::TypeName) : bool {
        0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::ac_table::contains<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::risk_model::RiskModels, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::risk_model::RiskModel>(&arg0.risk_models, arg1)
    }

    public fun interest_models(arg0: &Market) : &0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::ac_table::AcTable<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::interest_model::InterestModels, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::interest_model::InterestModel> {
        &arg0.interest_models
    }

    public(friend) fun interest_models_mut(arg0: &mut Market) : &mut 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::ac_table::AcTable<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::interest_model::InterestModels, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::interest_model::InterestModel> {
        &mut arg0.interest_models
    }

    public fun is_isolated_asset(arg0: &Market, arg1: 0x1::type_name::TypeName) : bool {
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market_dynamic_keys::isolated_asset_key(arg1);
        if (!0x2::dynamic_field::exists_<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market_dynamic_keys::IsolatedAssetKey>(&arg0.id, v0)) {
            return false
        };
        *0x2::dynamic_field::borrow<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market_dynamic_keys::IsolatedAssetKey, bool>(&arg0.id, v0)
    }

    public fun risk_model(arg0: &Market, arg1: 0x1::type_name::TypeName) : &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::risk_model::RiskModel {
        0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::ac_table::borrow<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::risk_model::RiskModels, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::risk_model::RiskModel>(&arg0.risk_models, arg1)
    }

    public(friend) fun rate_limiter_mut(arg0: &mut Market) : &mut 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::WitTable<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::limiter::Limiters, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::limiter::Limiter> {
        &mut arg0.limiters
    }

    public(friend) fun register_collateral<T0>(arg0: &mut Market) {
        let v0 = 0x1::type_name::get<T0>();
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::collateral_stats::init_collateral_if_none(&mut arg0.collateral_stats, v0);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::asset_active_state::set_collateral_active_state(&mut arg0.asset_active_states, v0, true);
    }

    public(friend) fun repay_flash_loan<T0>(arg0: &mut Market, arg1: 0x2::coin::Coin<T0>, arg2: 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::FlashLoan<T0>) {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::repay_flash_loan<T0>(&mut arg0.vault, arg1, arg2);
    }

    public fun reward_factor(arg0: &Market, arg1: 0x1::type_name::TypeName) : &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::incentive_rewards::RewardFactor {
        0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::borrow<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::incentive_rewards::RewardFactors, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::incentive_rewards::RewardFactor>(&arg0.reward_factors, arg1)
    }

    public fun reward_factors(arg0: &Market) : &0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::WitTable<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::incentive_rewards::RewardFactors, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::incentive_rewards::RewardFactor> {
        &arg0.reward_factors
    }

    public(friend) fun reward_factors_mut(arg0: &mut Market) : &mut 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::WitTable<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::incentive_rewards::RewardFactors, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::incentive_rewards::RewardFactor> {
        &mut arg0.reward_factors
    }

    public fun risk_models(arg0: &Market) : &0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::ac_table::AcTable<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::risk_model::RiskModels, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::risk_model::RiskModel> {
        &arg0.risk_models
    }

    public(friend) fun risk_models_mut(arg0: &mut Market) : &mut 0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::ac_table::AcTable<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::risk_model::RiskModels, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::risk_model::RiskModel> {
        &mut arg0.risk_models
    }

    public(friend) fun set_flash_loan_fee<T0>(arg0: &mut Market, arg1: u64) {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::set_flash_loan_fee<T0>(&mut arg0.vault, arg1);
    }

    public(friend) fun take_revenue<T0>(arg0: &mut Market, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::take_revenue<T0>(&mut arg0.vault, arg1, arg2)
    }

    public fun total_global_debt(arg0: &Market, arg1: 0x1::type_name::TypeName) : u64 {
        let (_, v1, _, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheet(0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::borrow<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheets, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheet>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheets(&arg0.vault), arg1));
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
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::asset_types(&arg0.vault);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v2 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v1);
            let (v3, v4) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::interest_model::calc_interest(0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::ac_table::borrow<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::interest_model::InterestModels, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::interest_model::InterestModel>(&arg0.interest_models, v2), 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::util_rate(&arg0.vault, v2));
            0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::borrow_dynamics::update_interest_rate(&mut arg0.borrow_dynamics, v2, v3, v4);
            v1 = v1 + 1;
        };
    }

    public fun vault(arg0: &Market) : &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::Reserve {
        &arg0.vault
    }

    // decompiled from Move bytecode v6
}

