module 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::market {
    struct Market has store, key {
        id: 0x2::object::UID,
        borrow_dynamics: 0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::wit_table::WitTable<0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::borrow_dynamics::BorrowDynamics, 0x1::type_name::TypeName, 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::borrow_dynamics::BorrowDynamic>,
        collateral_stats: 0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::wit_table::WitTable<0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::collateral_stats::CollateralStats, 0x1::type_name::TypeName, 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::collateral_stats::CollateralStat>,
        interest_models: 0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::ac_table::AcTable<0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::interest_model::InterestModels, 0x1::type_name::TypeName, 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::interest_model::InterestModel>,
        risk_models: 0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::ac_table::AcTable<0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::risk_model::RiskModels, 0x1::type_name::TypeName, 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::risk_model::RiskModel>,
        limiters: 0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::wit_table::WitTable<0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::limiter::Limiters, 0x1::type_name::TypeName, 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::limiter::Limiter>,
        vault: 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::reserve::Reserve,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : (Market, 0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::ac_table::AcTableCap<0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::interest_model::InterestModels>, 0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::ac_table::AcTableCap<0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::risk_model::RiskModels>) {
        let (v0, v1) = 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::interest_model::new(arg0);
        let (v2, v3) = 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::risk_model::new(arg0);
        let v4 = Market{
            id               : 0x2::object::new(arg0),
            borrow_dynamics  : 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::borrow_dynamics::new(arg0),
            collateral_stats : 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::collateral_stats::new(arg0),
            interest_models  : v0,
            risk_models      : v2,
            limiters         : 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::limiter::init_table(arg0),
            vault            : 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::reserve::new(arg0),
        };
        (v4, v1, v3)
    }

    public fun borrow_dynamics(arg0: &Market) : &0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::wit_table::WitTable<0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::borrow_dynamics::BorrowDynamics, 0x1::type_name::TypeName, 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::borrow_dynamics::BorrowDynamic> {
        &arg0.borrow_dynamics
    }

    public(friend) fun register_coin<T0>(arg0: &mut Market, arg1: u64) {
        0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::reserve::register_coin<T0>(&mut arg0.vault);
        0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::borrow_dynamics::register_coin<T0>(&mut arg0.borrow_dynamics, 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::interest_model::base_borrow_rate(0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::ac_table::borrow<0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::interest_model::InterestModels, 0x1::type_name::TypeName, 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::interest_model::InterestModel>(&arg0.interest_models, 0x1::type_name::get<T0>())), arg1);
    }

    public fun collateral_stats(arg0: &Market) : &0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::wit_table::WitTable<0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::collateral_stats::CollateralStats, 0x1::type_name::TypeName, 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::collateral_stats::CollateralStat> {
        &arg0.collateral_stats
    }

    public fun interest_model(arg0: &Market, arg1: 0x1::type_name::TypeName) : &0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::interest_model::InterestModel {
        0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::ac_table::borrow<0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::interest_model::InterestModels, 0x1::type_name::TypeName, 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::interest_model::InterestModel>(&arg0.interest_models, arg1)
    }

    public(friend) fun add_limiter<T0>(arg0: &mut Market, arg1: u64, arg2: u32, arg3: u32) {
        0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::limiter::add_limiter(&mut arg0.limiters, 0x1::type_name::get<T0>(), arg1, arg2, arg3);
    }

    public(friend) fun update_outflow_limit_params<T0>(arg0: &mut Market, arg1: u64) {
        0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::limiter::update_outflow_limit_params(&mut arg0.limiters, 0x1::type_name::get<T0>(), arg1);
    }

    public(friend) fun update_outflow_segment_params<T0>(arg0: &mut Market, arg1: u32, arg2: u32) {
        0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::limiter::update_outflow_segment_params(&mut arg0.limiters, 0x1::type_name::get<T0>(), arg1, arg2);
    }

    public(friend) fun accrue_all_interests(arg0: &mut Market, arg1: u64) {
        let v0 = 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::reserve::asset_types(&arg0.vault);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v2 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v1);
            0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::borrow_dynamics::update_borrow_index(&mut arg0.borrow_dynamics, v2, arg1);
            0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::reserve::increase_debt(&mut arg0.vault, v2, 0x9c564002970ce40370b0c1a8328d2e91924dab43ca2cb483af67aaf0f7cbe44e::fixed_point32_empower::sub(0x1::fixed_point32::create_from_rational(0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::borrow_dynamics::borrow_index_by_type(&arg0.borrow_dynamics, v2), 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::borrow_dynamics::borrow_index_by_type(&arg0.borrow_dynamics, v2)), 0x9c564002970ce40370b0c1a8328d2e91924dab43ca2cb483af67aaf0f7cbe44e::fixed_point32_empower::from_u64(1)), 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::interest_model::revenue_factor(0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::ac_table::borrow<0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::interest_model::InterestModels, 0x1::type_name::TypeName, 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::interest_model::InterestModel>(&arg0.interest_models, v2)));
            v1 = v1 + 1;
        };
    }

    public(friend) fun borrow_flash_loan<T0>(arg0: &mut Market, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::reserve::FlashLoan<T0>) {
        let (v0, v1) = 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::reserve::borrow_flash_loan<T0>(&mut arg0.vault, arg1);
        (0x2::coin::from_balance<T0>(v0, arg2), v1)
    }

    public fun borrow_index(arg0: &Market, arg1: 0x1::type_name::TypeName) : u64 {
        0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::borrow_dynamics::borrow_index_by_type(&arg0.borrow_dynamics, arg1)
    }

    public(friend) fun compound_interests(arg0: &mut Market, arg1: u64) {
        accrue_all_interests(arg0, arg1);
        update_interest_rates(arg0);
    }

    public(friend) fun handle_add_collateral<T0>(arg0: &mut Market, arg1: u64) {
        let v0 = 0x1::type_name::get<T0>();
        0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::collateral_stats::increase(&mut arg0.collateral_stats, v0, arg1);
        assert!(0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::collateral_stats::collateral_amount(&arg0.collateral_stats, v0) <= 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::risk_model::max_collateral_Amount(0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::ac_table::borrow<0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::risk_model::RiskModels, 0x1::type_name::TypeName, 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::risk_model::RiskModel>(&arg0.risk_models, v0)), 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::error::max_collateral_reached_error());
    }

    public(friend) fun handle_borrow<T0>(arg0: &mut Market, arg1: u64, arg2: u64) : 0x2::balance::Balance<T0> {
        accrue_all_interests(arg0, arg2);
        let v0 = 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::reserve::handle_borrow<T0>(&mut arg0.vault, arg1);
        update_interest_rates(arg0);
        v0
    }

    public(friend) fun handle_inflow<T0>(arg0: &mut Market, arg1: u64, arg2: u64) {
        0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::limiter::reduce_outflow(&mut arg0.limiters, 0x1::type_name::get<T0>(), arg2, arg1);
    }

    public(friend) fun handle_liquidation<T0>(arg0: &mut Market, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T0>) {
        0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::reserve::handle_liquidation<T0>(&mut arg0.vault, arg1, arg2);
        update_interest_rates(arg0);
    }

    public(friend) fun handle_mint<T0>(arg0: &mut Market, arg1: 0x2::balance::Balance<T0>, arg2: u64) : 0x2::balance::Balance<0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::reserve::MarketCoin<T0>> {
        accrue_all_interests(arg0, arg2);
        let v0 = 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::reserve::mint_market_coin<T0>(&mut arg0.vault, arg1);
        update_interest_rates(arg0);
        v0
    }

    public(friend) fun handle_outflow<T0>(arg0: &mut Market, arg1: u64, arg2: u64) {
        0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::limiter::add_outflow(&mut arg0.limiters, 0x1::type_name::get<T0>(), arg2, arg1);
    }

    public(friend) fun handle_redeem<T0>(arg0: &mut Market, arg1: 0x2::balance::Balance<0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::reserve::MarketCoin<T0>>, arg2: u64) : 0x2::balance::Balance<T0> {
        accrue_all_interests(arg0, arg2);
        let v0 = 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::reserve::redeem_underlying_coin<T0>(&mut arg0.vault, arg1);
        update_interest_rates(arg0);
        v0
    }

    public(friend) fun handle_repay<T0>(arg0: &mut Market, arg1: 0x2::balance::Balance<T0>) {
        0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::reserve::handle_repay<T0>(&mut arg0.vault, arg1);
        update_interest_rates(arg0);
    }

    public(friend) fun handle_withdraw_collateral<T0>(arg0: &mut Market, arg1: u64, arg2: u64) {
        accrue_all_interests(arg0, arg2);
        0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::collateral_stats::decrease(&mut arg0.collateral_stats, 0x1::type_name::get<T0>(), arg1);
        update_interest_rates(arg0);
    }

    public fun has_limiter(arg0: &Market, arg1: 0x1::type_name::TypeName) : bool {
        0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::wit_table::contains<0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::limiter::Limiters, 0x1::type_name::TypeName, 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::limiter::Limiter>(&arg0.limiters, arg1)
    }

    public fun has_risk_model(arg0: &Market, arg1: 0x1::type_name::TypeName) : bool {
        0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::ac_table::contains<0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::risk_model::RiskModels, 0x1::type_name::TypeName, 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::risk_model::RiskModel>(&arg0.risk_models, arg1)
    }

    public fun interest_models(arg0: &Market) : &0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::ac_table::AcTable<0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::interest_model::InterestModels, 0x1::type_name::TypeName, 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::interest_model::InterestModel> {
        &arg0.interest_models
    }

    public(friend) fun interest_models_mut(arg0: &mut Market) : &mut 0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::ac_table::AcTable<0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::interest_model::InterestModels, 0x1::type_name::TypeName, 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::interest_model::InterestModel> {
        &mut arg0.interest_models
    }

    public fun risk_model(arg0: &Market, arg1: 0x1::type_name::TypeName) : &0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::risk_model::RiskModel {
        0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::ac_table::borrow<0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::risk_model::RiskModels, 0x1::type_name::TypeName, 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::risk_model::RiskModel>(&arg0.risk_models, arg1)
    }

    public(friend) fun register_collateral<T0>(arg0: &mut Market) {
        0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::collateral_stats::init_collateral_if_none(&mut arg0.collateral_stats, 0x1::type_name::get<T0>());
    }

    public(friend) fun repay_flash_loan<T0>(arg0: &mut Market, arg1: 0x2::coin::Coin<T0>, arg2: 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::reserve::FlashLoan<T0>) {
        0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::reserve::repay_flash_loan<T0>(&mut arg0.vault, 0x2::coin::into_balance<T0>(arg1), arg2);
    }

    public fun risk_models(arg0: &Market) : &0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::ac_table::AcTable<0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::risk_model::RiskModels, 0x1::type_name::TypeName, 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::risk_model::RiskModel> {
        &arg0.risk_models
    }

    public(friend) fun risk_models_mut(arg0: &mut Market) : &mut 0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::ac_table::AcTable<0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::risk_model::RiskModels, 0x1::type_name::TypeName, 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::risk_model::RiskModel> {
        &mut arg0.risk_models
    }

    public(friend) fun set_flash_loan_fee<T0>(arg0: &mut Market, arg1: u64) {
        0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::reserve::set_flash_loan_fee<T0>(&mut arg0.vault, arg1);
    }

    public fun uid(arg0: &Market) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun uid_mut(arg0: &mut Market) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    fun update_interest_rates(arg0: &mut Market) {
        let v0 = 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::reserve::asset_types(&arg0.vault);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v2 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v1);
            0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::borrow_dynamics::update_interest_rate(&mut arg0.borrow_dynamics, v2, 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::interest_model::calc_interest(0x350fe3231df82efee1a1d15af4e132a92ba2b445cbdd92208ba5270132f68a79::ac_table::borrow<0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::interest_model::InterestModels, 0x1::type_name::TypeName, 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::interest_model::InterestModel>(&arg0.interest_models, v2), 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::reserve::ulti_rate(&arg0.vault, v2)));
            v1 = v1 + 1;
        };
    }

    public fun vault(arg0: &Market) : &0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::reserve::Reserve {
        &arg0.vault
    }

    // decompiled from Move bytecode v6
}

