module 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::market {
    struct Market has store, key {
        id: 0x2::object::UID,
        borrow_dynamics: 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::wit_table::WitTable<0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::borrow_dynamics::BorrowDynamics, 0x1::type_name::TypeName, 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::borrow_dynamics::BorrowDynamic>,
        collateral_stats: 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::wit_table::WitTable<0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::collateral_stats::CollateralStats, 0x1::type_name::TypeName, 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::collateral_stats::CollateralStat>,
        interest_models: 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::ac_table::AcTable<0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::interest_model::InterestModels, 0x1::type_name::TypeName, 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::interest_model::InterestModel>,
        risk_models: 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::ac_table::AcTable<0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::risk_model::RiskModels, 0x1::type_name::TypeName, 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::risk_model::RiskModel>,
        limiters: 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::wit_table::WitTable<0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::limiter::Limiters, 0x1::type_name::TypeName, 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::limiter::Limiter>,
        reward_factors: 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::wit_table::WitTable<0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::incentive_rewards::RewardFactors, 0x1::type_name::TypeName, 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::incentive_rewards::RewardFactor>,
        asset_active_states: 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::asset_active_state::AssetActiveStates,
        vault: 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::reserve::Reserve,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : (Market, 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::ac_table::AcTableCap<0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::interest_model::InterestModels>, 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::ac_table::AcTableCap<0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::risk_model::RiskModels>) {
        let (v0, v1) = 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::interest_model::new(arg0);
        let (v2, v3) = 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::risk_model::new(arg0);
        let v4 = Market{
            id                  : 0x2::object::new(arg0),
            borrow_dynamics     : 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::borrow_dynamics::new(arg0),
            collateral_stats    : 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::collateral_stats::new(arg0),
            interest_models     : v0,
            risk_models         : v2,
            limiters            : 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::limiter::init_table(arg0),
            reward_factors      : 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::incentive_rewards::init_table(arg0),
            asset_active_states : 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::asset_active_state::new(arg0),
            vault               : 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::reserve::new(arg0),
        };
        (v4, v1, v3)
    }

    public fun is_base_asset_active(arg0: &Market, arg1: 0x1::type_name::TypeName) : bool {
        0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::asset_active_state::is_base_asset_active(&arg0.asset_active_states, arg1)
    }

    public fun is_collateral_active(arg0: &Market, arg1: 0x1::type_name::TypeName) : bool {
        0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::asset_active_state::is_collateral_active(&arg0.asset_active_states, arg1)
    }

    public(friend) fun set_base_asset_active_state<T0>(arg0: &mut Market, arg1: bool) {
        0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::asset_active_state::set_base_asset_active_state(&mut arg0.asset_active_states, 0x1::type_name::get<T0>(), arg1);
    }

    public(friend) fun set_collateral_active_state<T0>(arg0: &mut Market, arg1: bool) {
        0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::asset_active_state::set_collateral_active_state(&mut arg0.asset_active_states, 0x1::type_name::get<T0>(), arg1);
    }

    public fun borrow_dynamics(arg0: &Market) : &0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::wit_table::WitTable<0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::borrow_dynamics::BorrowDynamics, 0x1::type_name::TypeName, 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::borrow_dynamics::BorrowDynamic> {
        &arg0.borrow_dynamics
    }

    public(friend) fun register_coin<T0>(arg0: &mut Market, arg1: u64) {
        let v0 = 0x1::type_name::get<T0>();
        0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::reserve::register_coin<T0>(&mut arg0.vault);
        let v1 = 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::ac_table::borrow<0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::interest_model::InterestModels, 0x1::type_name::TypeName, 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::interest_model::InterestModel>(&arg0.interest_models, v0);
        0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::borrow_dynamics::register_coin<T0>(&mut arg0.borrow_dynamics, 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::interest_model::base_borrow_rate(v1), 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::interest_model::interest_rate_scale(v1), arg1);
        0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::asset_active_state::set_base_asset_active_state(&mut arg0.asset_active_states, v0, true);
    }

    public fun collateral_stats(arg0: &Market) : &0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::wit_table::WitTable<0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::collateral_stats::CollateralStats, 0x1::type_name::TypeName, 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::collateral_stats::CollateralStat> {
        &arg0.collateral_stats
    }

    public fun interest_model(arg0: &Market, arg1: 0x1::type_name::TypeName) : &0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::interest_model::InterestModel {
        0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::ac_table::borrow<0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::interest_model::InterestModels, 0x1::type_name::TypeName, 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::interest_model::InterestModel>(&arg0.interest_models, arg1)
    }

    public(friend) fun accrue_all_interests(arg0: &mut Market, arg1: u64) {
        let v0 = 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::reserve::asset_types(&arg0.vault);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v2 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v1);
            if (0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::borrow_dynamics::last_updated_by_type(&arg0.borrow_dynamics, v2) == arg1) {
                v1 = v1 + 1;
                continue
            };
            0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::borrow_dynamics::update_borrow_index(&mut arg0.borrow_dynamics, v2, arg1);
            0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::reserve::increase_debt(&mut arg0.vault, v2, 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::fixed_point32_empower::sub(0x1::fixed_point32::create_from_rational(0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::borrow_dynamics::borrow_index_by_type(&arg0.borrow_dynamics, v2), 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::borrow_dynamics::borrow_index_by_type(&arg0.borrow_dynamics, v2)), 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::fixed_point32_empower::from_u64(1)), 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::interest_model::revenue_factor(0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::ac_table::borrow<0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::interest_model::InterestModels, 0x1::type_name::TypeName, 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::interest_model::InterestModel>(&arg0.interest_models, v2)));
            v1 = v1 + 1;
        };
    }

    public(friend) fun borrow_flash_loan<T0>(arg0: &mut Market, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::reserve::FlashLoan<T0>) {
        0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::reserve::borrow_flash_loan<T0>(&mut arg0.vault, arg1, arg2)
    }

    public fun borrow_index(arg0: &Market, arg1: 0x1::type_name::TypeName) : u64 {
        0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::borrow_dynamics::borrow_index_by_type(&arg0.borrow_dynamics, arg1)
    }

    public(friend) fun compound_interests(arg0: &mut Market, arg1: u64) {
        accrue_all_interests(arg0, arg1);
        update_interest_rates(arg0);
    }

    public(friend) fun handle_add_collateral<T0>(arg0: &mut Market, arg1: u64) {
        let v0 = 0x1::type_name::get<T0>();
        0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::collateral_stats::increase(&mut arg0.collateral_stats, v0, arg1);
        assert!(0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::collateral_stats::collateral_amount(&arg0.collateral_stats, v0) <= 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::risk_model::max_collateral_Amount(0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::ac_table::borrow<0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::risk_model::RiskModels, 0x1::type_name::TypeName, 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::risk_model::RiskModel>(&arg0.risk_models, v0)), 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::error::max_collateral_reached_error());
    }

    public(friend) fun handle_borrow<T0>(arg0: &mut Market, arg1: u64, arg2: u64) : 0x2::balance::Balance<T0> {
        accrue_all_interests(arg0, arg2);
        let v0 = 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::reserve::handle_borrow<T0>(&mut arg0.vault, arg1);
        update_interest_rates(arg0);
        v0
    }

    public(friend) fun handle_inflow<T0>(arg0: &mut Market, arg1: u64, arg2: u64) {
        0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::limiter::reduce_outflow(&mut arg0.limiters, 0x1::type_name::get<T0>(), arg2, arg1);
    }

    public(friend) fun handle_liquidation<T0, T1>(arg0: &mut Market, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T0>, arg3: u64) {
        0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::reserve::handle_liquidation<T0>(&mut arg0.vault, arg1, arg2);
        0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::collateral_stats::decrease(&mut arg0.collateral_stats, 0x1::type_name::get<T1>(), arg3);
        update_interest_rates(arg0);
    }

    public(friend) fun handle_mint<T0>(arg0: &mut Market, arg1: 0x2::balance::Balance<T0>, arg2: u64) : 0x2::balance::Balance<0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::reserve::MarketCoin<T0>> {
        accrue_all_interests(arg0, arg2);
        let v0 = 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::reserve::mint_market_coin<T0>(&mut arg0.vault, arg1);
        update_interest_rates(arg0);
        v0
    }

    public(friend) fun handle_outflow<T0>(arg0: &mut Market, arg1: u64, arg2: u64) {
        0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::limiter::add_outflow(&mut arg0.limiters, 0x1::type_name::get<T0>(), arg2, arg1);
    }

    public(friend) fun handle_redeem<T0>(arg0: &mut Market, arg1: 0x2::balance::Balance<0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::reserve::MarketCoin<T0>>, arg2: u64) : 0x2::balance::Balance<T0> {
        accrue_all_interests(arg0, arg2);
        let v0 = 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::reserve::redeem_underlying_coin<T0>(&mut arg0.vault, arg1);
        update_interest_rates(arg0);
        v0
    }

    public(friend) fun handle_repay<T0>(arg0: &mut Market, arg1: 0x2::balance::Balance<T0>) {
        0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::reserve::handle_repay<T0>(&mut arg0.vault, arg1);
        update_interest_rates(arg0);
    }

    public(friend) fun handle_withdraw_collateral<T0>(arg0: &mut Market, arg1: u64, arg2: u64) {
        accrue_all_interests(arg0, arg2);
        0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::collateral_stats::decrease(&mut arg0.collateral_stats, 0x1::type_name::get<T0>(), arg1);
        update_interest_rates(arg0);
    }

    public fun has_limiter(arg0: &Market, arg1: 0x1::type_name::TypeName) : bool {
        0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::wit_table::contains<0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::limiter::Limiters, 0x1::type_name::TypeName, 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::limiter::Limiter>(&arg0.limiters, arg1)
    }

    public fun has_risk_model(arg0: &Market, arg1: 0x1::type_name::TypeName) : bool {
        0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::ac_table::contains<0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::risk_model::RiskModels, 0x1::type_name::TypeName, 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::risk_model::RiskModel>(&arg0.risk_models, arg1)
    }

    public fun interest_models(arg0: &Market) : &0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::ac_table::AcTable<0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::interest_model::InterestModels, 0x1::type_name::TypeName, 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::interest_model::InterestModel> {
        &arg0.interest_models
    }

    public(friend) fun interest_models_mut(arg0: &mut Market) : &mut 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::ac_table::AcTable<0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::interest_model::InterestModels, 0x1::type_name::TypeName, 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::interest_model::InterestModel> {
        &mut arg0.interest_models
    }

    public fun risk_model(arg0: &Market, arg1: 0x1::type_name::TypeName) : &0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::risk_model::RiskModel {
        0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::ac_table::borrow<0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::risk_model::RiskModels, 0x1::type_name::TypeName, 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::risk_model::RiskModel>(&arg0.risk_models, arg1)
    }

    public(friend) fun rate_limiter_mut(arg0: &mut Market) : &mut 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::wit_table::WitTable<0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::limiter::Limiters, 0x1::type_name::TypeName, 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::limiter::Limiter> {
        &mut arg0.limiters
    }

    public(friend) fun register_collateral<T0>(arg0: &mut Market) {
        let v0 = 0x1::type_name::get<T0>();
        0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::collateral_stats::init_collateral_if_none(&mut arg0.collateral_stats, v0);
        0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::asset_active_state::set_collateral_active_state(&mut arg0.asset_active_states, v0, true);
    }

    public(friend) fun repay_flash_loan<T0>(arg0: &mut Market, arg1: 0x2::coin::Coin<T0>, arg2: 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::reserve::FlashLoan<T0>) {
        0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::reserve::repay_flash_loan<T0>(&mut arg0.vault, arg1, arg2);
    }

    public fun reward_factor(arg0: &Market, arg1: 0x1::type_name::TypeName) : &0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::incentive_rewards::RewardFactor {
        0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::wit_table::borrow<0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::incentive_rewards::RewardFactors, 0x1::type_name::TypeName, 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::incentive_rewards::RewardFactor>(&arg0.reward_factors, arg1)
    }

    public fun reward_factors(arg0: &Market) : &0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::wit_table::WitTable<0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::incentive_rewards::RewardFactors, 0x1::type_name::TypeName, 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::incentive_rewards::RewardFactor> {
        &arg0.reward_factors
    }

    public(friend) fun reward_factors_mut(arg0: &mut Market) : &mut 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::wit_table::WitTable<0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::incentive_rewards::RewardFactors, 0x1::type_name::TypeName, 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::incentive_rewards::RewardFactor> {
        &mut arg0.reward_factors
    }

    public fun risk_models(arg0: &Market) : &0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::ac_table::AcTable<0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::risk_model::RiskModels, 0x1::type_name::TypeName, 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::risk_model::RiskModel> {
        &arg0.risk_models
    }

    public(friend) fun risk_models_mut(arg0: &mut Market) : &mut 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::ac_table::AcTable<0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::risk_model::RiskModels, 0x1::type_name::TypeName, 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::risk_model::RiskModel> {
        &mut arg0.risk_models
    }

    public(friend) fun set_flash_loan_fee<T0>(arg0: &mut Market, arg1: u64) {
        0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::reserve::set_flash_loan_fee<T0>(&mut arg0.vault, arg1);
    }

    public(friend) fun take_revenue<T0>(arg0: &mut Market, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::reserve::take_revenue<T0>(&mut arg0.vault, arg1, arg2)
    }

    public fun uid(arg0: &Market) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun uid_mut(arg0: &mut Market) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun uid_mut_delegated(arg0: &mut Market, arg1: 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::witness::Witness<Market>) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    fun update_interest_rates(arg0: &mut Market) {
        let v0 = 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::reserve::asset_types(&arg0.vault);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v2 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v1);
            let (v3, v4) = 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::interest_model::calc_interest(0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::ac_table::borrow<0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::interest_model::InterestModels, 0x1::type_name::TypeName, 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::interest_model::InterestModel>(&arg0.interest_models, v2), 0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::reserve::util_rate(&arg0.vault, v2));
            0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::borrow_dynamics::update_interest_rate(&mut arg0.borrow_dynamics, v2, v3, v4);
            v1 = v1 + 1;
        };
    }

    public fun vault(arg0: &Market) : &0x36494001320e3f98ecf964f8a4b8869d7b1de5aa736919e594fe8100a082a5de::reserve::Reserve {
        &arg0.vault
    }

    // decompiled from Move bytecode v6
}

