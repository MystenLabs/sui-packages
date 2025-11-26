module 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::market {
    struct Market has store, key {
        id: 0x2::object::UID,
        borrow_dynamics: 0xeb63c4b1c2f282d17e6dfe94be084ecc3f99729dc71c172f0930a7b8872235e0::wit_table::WitTable<0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::borrow_dynamics::BorrowDynamics, 0x1::type_name::TypeName, 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::borrow_dynamics::BorrowDynamic>,
        collateral_stats: 0xeb63c4b1c2f282d17e6dfe94be084ecc3f99729dc71c172f0930a7b8872235e0::wit_table::WitTable<0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::collateral_stats::CollateralStats, 0x1::type_name::TypeName, 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::collateral_stats::CollateralStat>,
        interest_models: 0xeb63c4b1c2f282d17e6dfe94be084ecc3f99729dc71c172f0930a7b8872235e0::ac_table::AcTable<0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::interest_model::InterestModels, 0x1::type_name::TypeName, 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::interest_model::InterestModel>,
        risk_models: 0xeb63c4b1c2f282d17e6dfe94be084ecc3f99729dc71c172f0930a7b8872235e0::ac_table::AcTable<0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::risk_model::RiskModels, 0x1::type_name::TypeName, 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::risk_model::RiskModel>,
        limiters: 0xeb63c4b1c2f282d17e6dfe94be084ecc3f99729dc71c172f0930a7b8872235e0::wit_table::WitTable<0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::limiter::Limiters, 0x1::type_name::TypeName, 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::limiter::Limiter>,
        asset_active_states: 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::asset_active_state::AssetActiveStates,
        vault: 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::reserve::Reserve,
        gusd_treasury_cap: 0x1::option::Option<0x2::coin::TreasuryCap<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD>>,
        paused: bool,
        auto_pause_enabled: bool,
        auto_pause_threshold: 0x1::fixed_point32::FixedPoint32,
        flash_loan_single_cap: u64,
    }

    struct MintEvent has copy, drop {
        minter: address,
        amount: u64,
    }

    struct BurnEvent has copy, drop {
        burner: address,
        amount: u64,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : (Market, 0xeb63c4b1c2f282d17e6dfe94be084ecc3f99729dc71c172f0930a7b8872235e0::ac_table::AcTableCap<0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::interest_model::InterestModels>, 0xeb63c4b1c2f282d17e6dfe94be084ecc3f99729dc71c172f0930a7b8872235e0::ac_table::AcTableCap<0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::risk_model::RiskModels>) {
        let (v0, v1) = 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::interest_model::new(arg0);
        let (v2, v3) = 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::risk_model::new(arg0);
        let v4 = Market{
            id                    : 0x2::object::new(arg0),
            borrow_dynamics       : 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::borrow_dynamics::new(arg0),
            collateral_stats      : 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::collateral_stats::new(arg0),
            interest_models       : v0,
            risk_models           : v2,
            limiters              : 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::limiter::init_table(arg0),
            asset_active_states   : 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::asset_active_state::new(arg0),
            vault                 : 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::reserve::new(arg0),
            gusd_treasury_cap     : 0x1::option::none<0x2::coin::TreasuryCap<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD>>(),
            paused                : false,
            auto_pause_enabled    : true,
            auto_pause_threshold  : 0x1::fixed_point32::create_from_rational(8, 100),
            flash_loan_single_cap : 50000,
        };
        (v4, v1, v3)
    }

    public fun is_base_asset_active(arg0: &Market, arg1: 0x1::type_name::TypeName) : bool {
        0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::asset_active_state::is_base_asset_active(&arg0.asset_active_states, arg1)
    }

    public fun is_collateral_active(arg0: &Market, arg1: 0x1::type_name::TypeName) : bool {
        0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::asset_active_state::is_collateral_active(&arg0.asset_active_states, arg1)
    }

    public(friend) fun set_base_asset_active_state<T0>(arg0: &mut Market, arg1: bool) {
        0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::asset_active_state::set_base_asset_active_state(&mut arg0.asset_active_states, 0x1::type_name::get<T0>(), arg1);
    }

    public(friend) fun set_collateral_active_state<T0>(arg0: &mut Market, arg1: bool) {
        0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::asset_active_state::set_collateral_active_state(&mut arg0.asset_active_states, 0x1::type_name::get<T0>(), arg1);
    }

    public fun borrow_dynamics(arg0: &Market) : &0xeb63c4b1c2f282d17e6dfe94be084ecc3f99729dc71c172f0930a7b8872235e0::wit_table::WitTable<0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::borrow_dynamics::BorrowDynamics, 0x1::type_name::TypeName, 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::borrow_dynamics::BorrowDynamic> {
        &arg0.borrow_dynamics
    }

    public(friend) fun register_coin<T0>(arg0: &mut Market, arg1: u64) {
        let v0 = 0x1::type_name::get<T0>();
        0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::reserve::register_coin<T0>(&mut arg0.vault);
        let v1 = 0xeb63c4b1c2f282d17e6dfe94be084ecc3f99729dc71c172f0930a7b8872235e0::ac_table::borrow<0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::interest_model::InterestModels, 0x1::type_name::TypeName, 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::interest_model::InterestModel>(&arg0.interest_models, v0);
        0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::borrow_dynamics::register_coin<T0>(&mut arg0.borrow_dynamics, 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::interest_model::base_borrow_rate(v1), 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::interest_model::interest_rate_scale(v1), arg1);
        0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::asset_active_state::set_base_asset_active_state(&mut arg0.asset_active_states, v0, true);
    }

    public fun collateral_stats(arg0: &Market) : &0xeb63c4b1c2f282d17e6dfe94be084ecc3f99729dc71c172f0930a7b8872235e0::wit_table::WitTable<0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::collateral_stats::CollateralStats, 0x1::type_name::TypeName, 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::collateral_stats::CollateralStat> {
        &arg0.collateral_stats
    }

    public fun interest_model(arg0: &Market, arg1: 0x1::type_name::TypeName) : &0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::interest_model::InterestModel {
        0xeb63c4b1c2f282d17e6dfe94be084ecc3f99729dc71c172f0930a7b8872235e0::ac_table::borrow<0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::interest_model::InterestModels, 0x1::type_name::TypeName, 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::interest_model::InterestModel>(&arg0.interest_models, arg1)
    }

    public(friend) fun accrue_all_interests(arg0: &mut Market, arg1: u64) {
        let v0 = 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::reserve::asset_types(&arg0.vault);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v2 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v1);
            if (0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::borrow_dynamics::last_updated_by_type(&arg0.borrow_dynamics, v2) == arg1) {
                v1 = v1 + 1;
                continue
            };
            0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::borrow_dynamics::update_borrow_index(&mut arg0.borrow_dynamics, v2, arg1);
            0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::reserve::increase_debt(&mut arg0.vault, v2, 0x47aee540b4cf13763b58341097db066dc43dfa0574cd74729b64694f097a4d5d::fixed_point32_empower::sub(0x1::fixed_point32::create_from_rational(0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::borrow_dynamics::borrow_index_by_type(&arg0.borrow_dynamics, v2), 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::borrow_dynamics::borrow_index_by_type(&arg0.borrow_dynamics, v2)), 0x47aee540b4cf13763b58341097db066dc43dfa0574cd74729b64694f097a4d5d::fixed_point32_empower::from_u64(1)), 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::interest_model::revenue_factor(0xeb63c4b1c2f282d17e6dfe94be084ecc3f99729dc71c172f0930a7b8872235e0::ac_table::borrow<0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::interest_model::InterestModels, 0x1::type_name::TypeName, 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::interest_model::InterestModel>(&arg0.interest_models, v2)));
            v1 = v1 + 1;
        };
    }

    public(friend) fun add_borrow_fee<T0>(arg0: &mut Market, arg1: 0x2::balance::Balance<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD>, arg2: &mut 0x2::tx_context::TxContext) {
        0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::reserve::add_borrow_fee<T0>(&mut arg0.vault, arg1, arg2);
    }

    public fun auto_pause_enabled(arg0: &Market) : bool {
        arg0.auto_pause_enabled
    }

    public fun auto_pause_threshold(arg0: &Market) : 0x1::fixed_point32::FixedPoint32 {
        arg0.auto_pause_threshold
    }

    public(friend) fun borrow_flash_loan(arg0: &mut Market, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD>, 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::reserve::FlashLoan<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD>) {
        assert!(arg1 <= arg0.flash_loan_single_cap, 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::error::flashloan_exceed_single_cap_error());
        let v0 = mint_gusd(arg0, arg1, arg2, arg3);
        (v0, 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::reserve::borrow_flash_loan(&mut arg0.vault, arg1))
    }

    public fun borrow_index(arg0: &Market, arg1: 0x1::type_name::TypeName) : u64 {
        0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::borrow_dynamics::borrow_index_by_type(&arg0.borrow_dynamics, arg1)
    }

    public(friend) fun burn_gusd(arg0: &mut Market, arg1: 0x2::coin::Coin<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<0x2::coin::TreasuryCap<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD>>(&arg0.gusd_treasury_cap), 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::error::invalid_params_error());
        0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::burn(0x1::option::borrow_mut<0x2::coin::TreasuryCap<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD>>(&mut arg0.gusd_treasury_cap), arg1);
        let v0 = BurnEvent{
            burner : 0x2::tx_context::sender(arg2),
            amount : 0x2::coin::value<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD>(&arg1),
        };
        0x2::event::emit<BurnEvent>(v0);
    }

    public(friend) fun compound_interests(arg0: &mut Market, arg1: u64) {
        accrue_all_interests(arg0, arg1);
    }

    public fun get_flash_loan_single_cap(arg0: &Market) : u64 {
        arg0.flash_loan_single_cap
    }

    public(friend) fun handle_add_collateral<T0>(arg0: &mut Market, arg1: u64) {
        let v0 = 0x1::type_name::get<T0>();
        0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::collateral_stats::increase(&mut arg0.collateral_stats, v0, arg1);
        assert!(0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::collateral_stats::collateral_amount(&arg0.collateral_stats, v0) <= 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::risk_model::max_collateral_amount(0xeb63c4b1c2f282d17e6dfe94be084ecc3f99729dc71c172f0930a7b8872235e0::ac_table::borrow<0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::risk_model::RiskModels, 0x1::type_name::TypeName, 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::risk_model::RiskModel>(&arg0.risk_models, v0)), 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::error::max_collateral_reached_error());
    }

    public(friend) fun handle_borrow(arg0: &mut Market, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD> {
        let v0 = mint_gusd(arg0, arg1, arg2, arg3);
        0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::reserve::handle_borrow<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD>(&mut arg0.vault, arg1);
        v0
    }

    public(friend) fun handle_inflow<T0>(arg0: &mut Market, arg1: u64, arg2: u64) {
        0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::limiter::reduce_outflow(&mut arg0.limiters, 0x1::type_name::get<T0>(), arg2, arg1);
    }

    public(friend) fun handle_liquidation<T0>(arg0: &mut Market, arg1: 0x2::balance::Balance<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD>, arg2: 0x2::balance::Balance<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::from_balance<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD>(0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::reserve::handle_liquidation<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD>(&mut arg0.vault, arg1, arg2), arg4);
        burn_gusd(arg0, v0, arg4);
        0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::collateral_stats::decrease(&mut arg0.collateral_stats, 0x1::type_name::get<T0>(), arg3);
    }

    public(friend) fun handle_outflow<T0>(arg0: &mut Market, arg1: u64, arg2: u64) {
        0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::limiter::add_outflow(&mut arg0.limiters, 0x1::type_name::get<T0>(), arg2, arg1);
    }

    public(friend) fun handle_repay<T0>(arg0: &mut Market, arg1: 0x2::coin::Coin<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::reserve::handle_repay<T0>(&mut arg0.vault, arg1);
        if (0x2::balance::value<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD>(&v0) > 0) {
            burn_gusd(arg0, 0x2::coin::from_balance<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD>(v0, arg2), arg2);
        } else {
            0x2::balance::destroy_zero<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD>(v0);
        };
    }

    public(friend) fun handle_withdraw_collateral<T0>(arg0: &mut Market, arg1: u64, arg2: u64) {
        accrue_all_interests(arg0, arg2);
        0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::collateral_stats::decrease(&mut arg0.collateral_stats, 0x1::type_name::get<T0>(), arg1);
    }

    public fun has_limiter(arg0: &Market, arg1: 0x1::type_name::TypeName) : bool {
        0xeb63c4b1c2f282d17e6dfe94be084ecc3f99729dc71c172f0930a7b8872235e0::wit_table::contains<0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::limiter::Limiters, 0x1::type_name::TypeName, 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::limiter::Limiter>(&arg0.limiters, arg1)
    }

    public fun has_risk_model(arg0: &Market, arg1: 0x1::type_name::TypeName) : bool {
        0xeb63c4b1c2f282d17e6dfe94be084ecc3f99729dc71c172f0930a7b8872235e0::ac_table::contains<0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::risk_model::RiskModels, 0x1::type_name::TypeName, 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::risk_model::RiskModel>(&arg0.risk_models, arg1)
    }

    public fun interest_models(arg0: &Market) : &0xeb63c4b1c2f282d17e6dfe94be084ecc3f99729dc71c172f0930a7b8872235e0::ac_table::AcTable<0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::interest_model::InterestModels, 0x1::type_name::TypeName, 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::interest_model::InterestModel> {
        &arg0.interest_models
    }

    public(friend) fun interest_models_mut(arg0: &mut Market) : &mut 0xeb63c4b1c2f282d17e6dfe94be084ecc3f99729dc71c172f0930a7b8872235e0::ac_table::AcTable<0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::interest_model::InterestModels, 0x1::type_name::TypeName, 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::interest_model::InterestModel> {
        &mut arg0.interest_models
    }

    public fun is_paused(arg0: &Market) : bool {
        arg0.paused
    }

    public(friend) fun mint_gusd(arg0: &mut Market, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD> {
        assert!(0x1::option::is_some<0x2::coin::TreasuryCap<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD>>(&arg0.gusd_treasury_cap), 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::error::invalid_params_error());
        accrue_all_interests(arg0, arg2);
        let v0 = MintEvent{
            minter : 0x2::tx_context::sender(arg3),
            amount : arg1,
        };
        0x2::event::emit<MintEvent>(v0);
        0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::mint(0x1::option::borrow_mut<0x2::coin::TreasuryCap<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD>>(&mut arg0.gusd_treasury_cap), arg1, arg3)
    }

    public(friend) fun rate_limiter_mut(arg0: &mut Market) : &mut 0xeb63c4b1c2f282d17e6dfe94be084ecc3f99729dc71c172f0930a7b8872235e0::wit_table::WitTable<0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::limiter::Limiters, 0x1::type_name::TypeName, 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::limiter::Limiter> {
        &mut arg0.limiters
    }

    public(friend) fun register_collateral<T0>(arg0: &mut Market) {
        let v0 = 0x1::type_name::get<T0>();
        0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::collateral_stats::init_collateral_if_none(&mut arg0.collateral_stats, v0);
        0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::asset_active_state::set_collateral_active_state(&mut arg0.asset_active_states, v0, true);
    }

    public(friend) fun repay_flash_loan(arg0: &mut Market, arg1: 0x2::coin::Coin<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD>, arg2: 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::reserve::FlashLoan<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::reserve::repay_flash_loan(&mut arg0.vault, arg1, arg2, arg3);
        burn_gusd(arg0, v0, arg3);
    }

    public fun risk_model(arg0: &Market, arg1: 0x1::type_name::TypeName) : &0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::risk_model::RiskModel {
        0xeb63c4b1c2f282d17e6dfe94be084ecc3f99729dc71c172f0930a7b8872235e0::ac_table::borrow<0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::risk_model::RiskModels, 0x1::type_name::TypeName, 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::risk_model::RiskModel>(&arg0.risk_models, arg1)
    }

    public fun risk_models(arg0: &Market) : &0xeb63c4b1c2f282d17e6dfe94be084ecc3f99729dc71c172f0930a7b8872235e0::ac_table::AcTable<0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::risk_model::RiskModels, 0x1::type_name::TypeName, 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::risk_model::RiskModel> {
        &arg0.risk_models
    }

    public(friend) fun risk_models_mut(arg0: &mut Market) : &mut 0xeb63c4b1c2f282d17e6dfe94be084ecc3f99729dc71c172f0930a7b8872235e0::ac_table::AcTable<0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::risk_model::RiskModels, 0x1::type_name::TypeName, 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::risk_model::RiskModel> {
        &mut arg0.risk_models
    }

    public(friend) fun set_auto_pause_enabled(arg0: &mut Market, arg1: bool) {
        arg0.auto_pause_enabled = arg1;
    }

    public(friend) fun set_auto_pause_threshold(arg0: &mut Market, arg1: 0x1::fixed_point32::FixedPoint32) {
        arg0.auto_pause_threshold = arg1;
    }

    public(friend) fun set_flash_loan_single_cap(arg0: &mut Market, arg1: u64) {
        arg0.flash_loan_single_cap = arg1;
    }

    public(friend) fun set_gusd_cap(arg0: &mut Market, arg1: 0x2::coin::TreasuryCap<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD>) {
        assert!(0x1::option::is_none<0x2::coin::TreasuryCap<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD>>(&arg0.gusd_treasury_cap), 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::error::invalid_params_error());
        0x1::option::fill<0x2::coin::TreasuryCap<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD>>(&mut arg0.gusd_treasury_cap, arg1);
    }

    public(friend) fun set_paused(arg0: &mut Market, arg1: bool) {
        arg0.paused = arg1;
    }

    public(friend) fun take_borrow_fee<T0>(arg0: &mut Market, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::reserve::take_borrow_fee<T0>(&mut arg0.vault, arg1, arg2)
    }

    public(friend) fun take_revenue<T0>(arg0: &mut Market, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::reserve::take_revenue<T0>(&mut arg0.vault, arg1, arg2)
    }

    public fun total_global_debt(arg0: &Market, arg1: 0x1::type_name::TypeName) : u64 {
        let (v0, _, _) = 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::reserve::balance_sheet(0xeb63c4b1c2f282d17e6dfe94be084ecc3f99729dc71c172f0930a7b8872235e0::wit_table::borrow<0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::reserve::BalanceSheets, 0x1::type_name::TypeName, 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::reserve::BalanceSheet>(0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::reserve::balance_sheets(&arg0.vault), arg1));
        v0
    }

    public fun uid(arg0: &Market) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun uid_mut(arg0: &mut Market) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun uid_mut_delegated(arg0: &mut Market, arg1: 0xeb63c4b1c2f282d17e6dfe94be084ecc3f99729dc71c172f0930a7b8872235e0::witness::Witness<Market>) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public(friend) fun update_interest_rates<T0>(arg0: &mut Market) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0xeb63c4b1c2f282d17e6dfe94be084ecc3f99729dc71c172f0930a7b8872235e0::ac_table::borrow<0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::interest_model::InterestModels, 0x1::type_name::TypeName, 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::interest_model::InterestModel>(&arg0.interest_models, v0);
        0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::borrow_dynamics::update_interest_rate(&mut arg0.borrow_dynamics, v0, 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::interest_model::base_borrow_rate(v1), 0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::interest_model::interest_rate_scale(v1));
    }

    public fun vault(arg0: &Market) : &0x9b0067de63ff34d9df609e0edd42b19bd3926466fb9c4d05445454d49db5388a::reserve::Reserve {
        &arg0.vault
    }

    // decompiled from Move bytecode v6
}

