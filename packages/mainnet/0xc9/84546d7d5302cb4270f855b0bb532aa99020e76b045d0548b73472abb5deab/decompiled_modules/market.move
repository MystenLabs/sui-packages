module 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::market {
    struct Market has store, key {
        id: 0x2::object::UID,
        borrow_dynamics: 0x24ec82bf6f98081ffbd57e0c26ea95e372be62ec9fadeafb6bdb1d5c8de3b769::wit_table::WitTable<0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::borrow_dynamics::BorrowDynamics, 0x1::type_name::TypeName, 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::borrow_dynamics::BorrowDynamic>,
        collateral_stats: 0x24ec82bf6f98081ffbd57e0c26ea95e372be62ec9fadeafb6bdb1d5c8de3b769::wit_table::WitTable<0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::collateral_stats::CollateralStats, 0x1::type_name::TypeName, 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::collateral_stats::CollateralStat>,
        interest_models: 0x24ec82bf6f98081ffbd57e0c26ea95e372be62ec9fadeafb6bdb1d5c8de3b769::ac_table::AcTable<0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::interest_model::InterestModels, 0x1::type_name::TypeName, 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::interest_model::InterestModel>,
        risk_models: 0x24ec82bf6f98081ffbd57e0c26ea95e372be62ec9fadeafb6bdb1d5c8de3b769::ac_table::AcTable<0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::risk_model::RiskModels, 0x1::type_name::TypeName, 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::risk_model::RiskModel>,
        limiters: 0x24ec82bf6f98081ffbd57e0c26ea95e372be62ec9fadeafb6bdb1d5c8de3b769::wit_table::WitTable<0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::limiter::Limiters, 0x1::type_name::TypeName, 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::limiter::Limiter>,
        asset_active_states: 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::asset_active_state::AssetActiveStates,
        vault: 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::reserve::Reserve,
        gusd_treasury_cap: 0x1::option::Option<0x2::coin::TreasuryCap<0xfcf33234f8173973253b61f9c354f4f21c12a6d4bfee6cb79cb478db9124895d::coin_gusd::COIN_GUSD>>,
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

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : (Market, 0x24ec82bf6f98081ffbd57e0c26ea95e372be62ec9fadeafb6bdb1d5c8de3b769::ac_table::AcTableCap<0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::interest_model::InterestModels>, 0x24ec82bf6f98081ffbd57e0c26ea95e372be62ec9fadeafb6bdb1d5c8de3b769::ac_table::AcTableCap<0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::risk_model::RiskModels>) {
        let (v0, v1) = 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::interest_model::new(arg0);
        let (v2, v3) = 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::risk_model::new(arg0);
        let v4 = Market{
            id                    : 0x2::object::new(arg0),
            borrow_dynamics       : 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::borrow_dynamics::new(arg0),
            collateral_stats      : 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::collateral_stats::new(arg0),
            interest_models       : v0,
            risk_models           : v2,
            limiters              : 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::limiter::init_table(arg0),
            asset_active_states   : 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::asset_active_state::new(arg0),
            vault                 : 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::reserve::new(arg0),
            gusd_treasury_cap     : 0x1::option::none<0x2::coin::TreasuryCap<0xfcf33234f8173973253b61f9c354f4f21c12a6d4bfee6cb79cb478db9124895d::coin_gusd::COIN_GUSD>>(),
            paused                : false,
            auto_pause_enabled    : true,
            auto_pause_threshold  : 0x1::fixed_point32::create_from_rational(8, 100),
            flash_loan_single_cap : 50000,
        };
        (v4, v1, v3)
    }

    public fun is_base_asset_active(arg0: &Market, arg1: 0x1::type_name::TypeName) : bool {
        0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::asset_active_state::is_base_asset_active(&arg0.asset_active_states, arg1)
    }

    public fun is_collateral_active(arg0: &Market, arg1: 0x1::type_name::TypeName) : bool {
        0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::asset_active_state::is_collateral_active(&arg0.asset_active_states, arg1)
    }

    public(friend) fun set_base_asset_active_state<T0>(arg0: &mut Market, arg1: bool) {
        0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::asset_active_state::set_base_asset_active_state(&mut arg0.asset_active_states, 0x1::type_name::get<T0>(), arg1);
    }

    public(friend) fun set_collateral_active_state<T0>(arg0: &mut Market, arg1: bool) {
        0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::asset_active_state::set_collateral_active_state(&mut arg0.asset_active_states, 0x1::type_name::get<T0>(), arg1);
    }

    public fun borrow_dynamics(arg0: &Market) : &0x24ec82bf6f98081ffbd57e0c26ea95e372be62ec9fadeafb6bdb1d5c8de3b769::wit_table::WitTable<0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::borrow_dynamics::BorrowDynamics, 0x1::type_name::TypeName, 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::borrow_dynamics::BorrowDynamic> {
        &arg0.borrow_dynamics
    }

    public(friend) fun register_coin<T0>(arg0: &mut Market, arg1: u64) {
        let v0 = 0x1::type_name::get<T0>();
        0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::reserve::register_coin<T0>(&mut arg0.vault);
        let v1 = 0x24ec82bf6f98081ffbd57e0c26ea95e372be62ec9fadeafb6bdb1d5c8de3b769::ac_table::borrow<0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::interest_model::InterestModels, 0x1::type_name::TypeName, 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::interest_model::InterestModel>(&arg0.interest_models, v0);
        0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::borrow_dynamics::register_coin<T0>(&mut arg0.borrow_dynamics, 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::interest_model::base_borrow_rate(v1), 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::interest_model::interest_rate_scale(v1), arg1);
        0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::asset_active_state::set_base_asset_active_state(&mut arg0.asset_active_states, v0, true);
    }

    public fun collateral_stats(arg0: &Market) : &0x24ec82bf6f98081ffbd57e0c26ea95e372be62ec9fadeafb6bdb1d5c8de3b769::wit_table::WitTable<0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::collateral_stats::CollateralStats, 0x1::type_name::TypeName, 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::collateral_stats::CollateralStat> {
        &arg0.collateral_stats
    }

    public fun interest_model(arg0: &Market, arg1: 0x1::type_name::TypeName) : &0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::interest_model::InterestModel {
        0x24ec82bf6f98081ffbd57e0c26ea95e372be62ec9fadeafb6bdb1d5c8de3b769::ac_table::borrow<0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::interest_model::InterestModels, 0x1::type_name::TypeName, 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::interest_model::InterestModel>(&arg0.interest_models, arg1)
    }

    public(friend) fun accrue_all_interests(arg0: &mut Market, arg1: u64) {
        let v0 = 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::reserve::asset_types(&arg0.vault);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v2 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v1);
            if (0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::borrow_dynamics::last_updated_by_type(&arg0.borrow_dynamics, v2) == arg1) {
                v1 = v1 + 1;
                continue
            };
            0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::borrow_dynamics::update_borrow_index(&mut arg0.borrow_dynamics, v2, arg1);
            0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::reserve::increase_debt(&mut arg0.vault, v2, 0xea7eb073880686001519321fa66299ef645d1414c3d7c4fb7c1c55a10d84ab6::fixed_point32_empower::sub(0x1::fixed_point32::create_from_rational(0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::borrow_dynamics::borrow_index_by_type(&arg0.borrow_dynamics, v2), 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::borrow_dynamics::borrow_index_by_type(&arg0.borrow_dynamics, v2)), 0xea7eb073880686001519321fa66299ef645d1414c3d7c4fb7c1c55a10d84ab6::fixed_point32_empower::from_u64(1)));
            v1 = v1 + 1;
        };
    }

    public(friend) fun add_borrow_fee<T0>(arg0: &mut Market, arg1: 0x2::balance::Balance<0xfcf33234f8173973253b61f9c354f4f21c12a6d4bfee6cb79cb478db9124895d::coin_gusd::COIN_GUSD>, arg2: &mut 0x2::tx_context::TxContext) {
        0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::reserve::add_borrow_fee<T0>(&mut arg0.vault, arg1, arg2);
    }

    public fun auto_pause_enabled(arg0: &Market) : bool {
        arg0.auto_pause_enabled
    }

    public fun auto_pause_threshold(arg0: &Market) : 0x1::fixed_point32::FixedPoint32 {
        arg0.auto_pause_threshold
    }

    public(friend) fun borrow_flash_loan(arg0: &mut Market, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xfcf33234f8173973253b61f9c354f4f21c12a6d4bfee6cb79cb478db9124895d::coin_gusd::COIN_GUSD>, 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::reserve::FlashLoan<0xfcf33234f8173973253b61f9c354f4f21c12a6d4bfee6cb79cb478db9124895d::coin_gusd::COIN_GUSD>) {
        assert!(arg1 <= arg0.flash_loan_single_cap, 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::error::flashloan_exceed_single_cap_error());
        let v0 = mint_gusd(arg0, arg1, arg2, arg3);
        (v0, 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::reserve::borrow_flash_loan(&mut arg0.vault, arg1))
    }

    public fun borrow_index(arg0: &Market, arg1: 0x1::type_name::TypeName) : u64 {
        0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::borrow_dynamics::borrow_index_by_type(&arg0.borrow_dynamics, arg1)
    }

    public(friend) fun burn_gusd(arg0: &mut Market, arg1: 0x2::coin::Coin<0xfcf33234f8173973253b61f9c354f4f21c12a6d4bfee6cb79cb478db9124895d::coin_gusd::COIN_GUSD>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<0x2::coin::TreasuryCap<0xfcf33234f8173973253b61f9c354f4f21c12a6d4bfee6cb79cb478db9124895d::coin_gusd::COIN_GUSD>>(&arg0.gusd_treasury_cap), 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::error::invalid_params_error());
        0xfcf33234f8173973253b61f9c354f4f21c12a6d4bfee6cb79cb478db9124895d::coin_gusd::burn(0x1::option::borrow_mut<0x2::coin::TreasuryCap<0xfcf33234f8173973253b61f9c354f4f21c12a6d4bfee6cb79cb478db9124895d::coin_gusd::COIN_GUSD>>(&mut arg0.gusd_treasury_cap), arg1);
        let v0 = BurnEvent{
            burner : 0x2::tx_context::sender(arg2),
            amount : 0x2::coin::value<0xfcf33234f8173973253b61f9c354f4f21c12a6d4bfee6cb79cb478db9124895d::coin_gusd::COIN_GUSD>(&arg1),
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
        0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::collateral_stats::increase(&mut arg0.collateral_stats, v0, arg1);
        assert!(0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::collateral_stats::collateral_amount(&arg0.collateral_stats, v0) <= 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::risk_model::max_collateral_amount(0x24ec82bf6f98081ffbd57e0c26ea95e372be62ec9fadeafb6bdb1d5c8de3b769::ac_table::borrow<0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::risk_model::RiskModels, 0x1::type_name::TypeName, 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::risk_model::RiskModel>(&arg0.risk_models, v0)), 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::error::max_collateral_reached_error());
    }

    public(friend) fun handle_borrow(arg0: &mut Market, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xfcf33234f8173973253b61f9c354f4f21c12a6d4bfee6cb79cb478db9124895d::coin_gusd::COIN_GUSD> {
        let v0 = mint_gusd(arg0, arg1, arg2, arg3);
        0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::reserve::handle_borrow<0xfcf33234f8173973253b61f9c354f4f21c12a6d4bfee6cb79cb478db9124895d::coin_gusd::COIN_GUSD>(&mut arg0.vault, arg1);
        v0
    }

    public(friend) fun handle_inflow<T0>(arg0: &mut Market, arg1: u64, arg2: u64) {
        0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::limiter::reduce_outflow(&mut arg0.limiters, 0x1::type_name::get<T0>(), arg2, arg1);
    }

    public(friend) fun handle_liquidation<T0>(arg0: &mut Market, arg1: 0x2::balance::Balance<0xfcf33234f8173973253b61f9c354f4f21c12a6d4bfee6cb79cb478db9124895d::coin_gusd::COIN_GUSD>, arg2: 0x2::balance::Balance<0xfcf33234f8173973253b61f9c354f4f21c12a6d4bfee6cb79cb478db9124895d::coin_gusd::COIN_GUSD>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::reserve::handle_liquidation<0xfcf33234f8173973253b61f9c354f4f21c12a6d4bfee6cb79cb478db9124895d::coin_gusd::COIN_GUSD>(&mut arg0.vault, arg1, arg2, arg4);
        if (0x2::balance::value<0xfcf33234f8173973253b61f9c354f4f21c12a6d4bfee6cb79cb478db9124895d::coin_gusd::COIN_GUSD>(&v0) == 0) {
            0x2::balance::destroy_zero<0xfcf33234f8173973253b61f9c354f4f21c12a6d4bfee6cb79cb478db9124895d::coin_gusd::COIN_GUSD>(v0);
            0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::collateral_stats::decrease(&mut arg0.collateral_stats, 0x1::type_name::get<T0>(), arg3);
            return
        };
        burn_gusd(arg0, 0x2::coin::from_balance<0xfcf33234f8173973253b61f9c354f4f21c12a6d4bfee6cb79cb478db9124895d::coin_gusd::COIN_GUSD>(v0, arg5), arg5);
        0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::collateral_stats::decrease(&mut arg0.collateral_stats, 0x1::type_name::get<T0>(), arg3);
    }

    public(friend) fun handle_outflow<T0>(arg0: &mut Market, arg1: u64, arg2: u64) {
        0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::limiter::add_outflow(&mut arg0.limiters, 0x1::type_name::get<T0>(), arg2, arg1);
    }

    public(friend) fun handle_repay<T0>(arg0: &mut Market, arg1: 0x2::coin::Coin<0xfcf33234f8173973253b61f9c354f4f21c12a6d4bfee6cb79cb478db9124895d::coin_gusd::COIN_GUSD>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::reserve::handle_repay<T0>(&mut arg0.vault, arg1, arg2);
        if (0x2::balance::value<0xfcf33234f8173973253b61f9c354f4f21c12a6d4bfee6cb79cb478db9124895d::coin_gusd::COIN_GUSD>(&v0) > 0) {
            burn_gusd(arg0, 0x2::coin::from_balance<0xfcf33234f8173973253b61f9c354f4f21c12a6d4bfee6cb79cb478db9124895d::coin_gusd::COIN_GUSD>(v0, arg3), arg3);
        } else {
            0x2::balance::destroy_zero<0xfcf33234f8173973253b61f9c354f4f21c12a6d4bfee6cb79cb478db9124895d::coin_gusd::COIN_GUSD>(v0);
        };
    }

    public(friend) fun handle_withdraw_collateral<T0>(arg0: &mut Market, arg1: u64, arg2: u64) {
        accrue_all_interests(arg0, arg2);
        0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::collateral_stats::decrease(&mut arg0.collateral_stats, 0x1::type_name::get<T0>(), arg1);
    }

    public fun has_limiter(arg0: &Market, arg1: 0x1::type_name::TypeName) : bool {
        0x24ec82bf6f98081ffbd57e0c26ea95e372be62ec9fadeafb6bdb1d5c8de3b769::wit_table::contains<0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::limiter::Limiters, 0x1::type_name::TypeName, 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::limiter::Limiter>(&arg0.limiters, arg1)
    }

    public fun has_risk_model(arg0: &Market, arg1: 0x1::type_name::TypeName) : bool {
        0x24ec82bf6f98081ffbd57e0c26ea95e372be62ec9fadeafb6bdb1d5c8de3b769::ac_table::contains<0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::risk_model::RiskModels, 0x1::type_name::TypeName, 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::risk_model::RiskModel>(&arg0.risk_models, arg1)
    }

    public fun interest_models(arg0: &Market) : &0x24ec82bf6f98081ffbd57e0c26ea95e372be62ec9fadeafb6bdb1d5c8de3b769::ac_table::AcTable<0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::interest_model::InterestModels, 0x1::type_name::TypeName, 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::interest_model::InterestModel> {
        &arg0.interest_models
    }

    public(friend) fun interest_models_mut(arg0: &mut Market) : &mut 0x24ec82bf6f98081ffbd57e0c26ea95e372be62ec9fadeafb6bdb1d5c8de3b769::ac_table::AcTable<0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::interest_model::InterestModels, 0x1::type_name::TypeName, 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::interest_model::InterestModel> {
        &mut arg0.interest_models
    }

    public fun is_paused(arg0: &Market) : bool {
        arg0.paused
    }

    public(friend) fun mint_gusd(arg0: &mut Market, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xfcf33234f8173973253b61f9c354f4f21c12a6d4bfee6cb79cb478db9124895d::coin_gusd::COIN_GUSD> {
        assert!(0x1::option::is_some<0x2::coin::TreasuryCap<0xfcf33234f8173973253b61f9c354f4f21c12a6d4bfee6cb79cb478db9124895d::coin_gusd::COIN_GUSD>>(&arg0.gusd_treasury_cap), 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::error::invalid_params_error());
        accrue_all_interests(arg0, arg2);
        let v0 = MintEvent{
            minter : 0x2::tx_context::sender(arg3),
            amount : arg1,
        };
        0x2::event::emit<MintEvent>(v0);
        0xfcf33234f8173973253b61f9c354f4f21c12a6d4bfee6cb79cb478db9124895d::coin_gusd::mint(0x1::option::borrow_mut<0x2::coin::TreasuryCap<0xfcf33234f8173973253b61f9c354f4f21c12a6d4bfee6cb79cb478db9124895d::coin_gusd::COIN_GUSD>>(&mut arg0.gusd_treasury_cap), arg1, arg3)
    }

    public fun risk_model(arg0: &Market, arg1: 0x1::type_name::TypeName) : &0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::risk_model::RiskModel {
        0x24ec82bf6f98081ffbd57e0c26ea95e372be62ec9fadeafb6bdb1d5c8de3b769::ac_table::borrow<0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::risk_model::RiskModels, 0x1::type_name::TypeName, 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::risk_model::RiskModel>(&arg0.risk_models, arg1)
    }

    public(friend) fun rate_limiter_mut(arg0: &mut Market) : &mut 0x24ec82bf6f98081ffbd57e0c26ea95e372be62ec9fadeafb6bdb1d5c8de3b769::wit_table::WitTable<0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::limiter::Limiters, 0x1::type_name::TypeName, 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::limiter::Limiter> {
        &mut arg0.limiters
    }

    public(friend) fun register_collateral<T0>(arg0: &mut Market) {
        let v0 = 0x1::type_name::get<T0>();
        0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::collateral_stats::init_collateral_if_none(&mut arg0.collateral_stats, v0);
        0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::asset_active_state::set_collateral_active_state(&mut arg0.asset_active_states, v0, true);
    }

    public(friend) fun repay_flash_loan(arg0: &mut Market, arg1: 0x2::coin::Coin<0xfcf33234f8173973253b61f9c354f4f21c12a6d4bfee6cb79cb478db9124895d::coin_gusd::COIN_GUSD>, arg2: 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::reserve::FlashLoan<0xfcf33234f8173973253b61f9c354f4f21c12a6d4bfee6cb79cb478db9124895d::coin_gusd::COIN_GUSD>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::reserve::repay_flash_loan(&mut arg0.vault, arg1, arg2, arg3);
        burn_gusd(arg0, v0, arg3);
    }

    public fun risk_models(arg0: &Market) : &0x24ec82bf6f98081ffbd57e0c26ea95e372be62ec9fadeafb6bdb1d5c8de3b769::ac_table::AcTable<0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::risk_model::RiskModels, 0x1::type_name::TypeName, 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::risk_model::RiskModel> {
        &arg0.risk_models
    }

    public(friend) fun risk_models_mut(arg0: &mut Market) : &mut 0x24ec82bf6f98081ffbd57e0c26ea95e372be62ec9fadeafb6bdb1d5c8de3b769::ac_table::AcTable<0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::risk_model::RiskModels, 0x1::type_name::TypeName, 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::risk_model::RiskModel> {
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

    public(friend) fun set_gusd_cap(arg0: &mut Market, arg1: 0x2::coin::TreasuryCap<0xfcf33234f8173973253b61f9c354f4f21c12a6d4bfee6cb79cb478db9124895d::coin_gusd::COIN_GUSD>) {
        assert!(0x1::option::is_none<0x2::coin::TreasuryCap<0xfcf33234f8173973253b61f9c354f4f21c12a6d4bfee6cb79cb478db9124895d::coin_gusd::COIN_GUSD>>(&arg0.gusd_treasury_cap), 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::error::invalid_params_error());
        0x1::option::fill<0x2::coin::TreasuryCap<0xfcf33234f8173973253b61f9c354f4f21c12a6d4bfee6cb79cb478db9124895d::coin_gusd::COIN_GUSD>>(&mut arg0.gusd_treasury_cap, arg1);
    }

    public(friend) fun set_paused(arg0: &mut Market, arg1: bool) {
        arg0.paused = arg1;
    }

    public(friend) fun take_borrow_fee<T0>(arg0: &mut Market, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::reserve::take_borrow_fee<T0>(&mut arg0.vault, arg1, arg2)
    }

    public(friend) fun take_revenue<T0>(arg0: &mut Market, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::reserve::take_revenue<T0>(&mut arg0.vault, arg1, arg2)
    }

    public fun total_global_debt(arg0: &Market, arg1: 0x1::type_name::TypeName) : u64 {
        let (v0, _) = 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::reserve::balance_sheet(0x24ec82bf6f98081ffbd57e0c26ea95e372be62ec9fadeafb6bdb1d5c8de3b769::wit_table::borrow<0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::reserve::BalanceSheets, 0x1::type_name::TypeName, 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::reserve::BalanceSheet>(0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::reserve::balance_sheets(&arg0.vault), arg1));
        v0
    }

    public fun uid(arg0: &Market) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun uid_mut(arg0: &mut Market) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun uid_mut_delegated(arg0: &mut Market, arg1: 0x24ec82bf6f98081ffbd57e0c26ea95e372be62ec9fadeafb6bdb1d5c8de3b769::witness::Witness<Market>) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public(friend) fun update_interest_rates<T0>(arg0: &mut Market) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x24ec82bf6f98081ffbd57e0c26ea95e372be62ec9fadeafb6bdb1d5c8de3b769::ac_table::borrow<0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::interest_model::InterestModels, 0x1::type_name::TypeName, 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::interest_model::InterestModel>(&arg0.interest_models, v0);
        0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::borrow_dynamics::update_interest_rate(&mut arg0.borrow_dynamics, v0, 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::interest_model::base_borrow_rate(v1), 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::interest_model::interest_rate_scale(v1));
    }

    public fun vault(arg0: &Market) : &0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::reserve::Reserve {
        &arg0.vault
    }

    // decompiled from Move bytecode v6
}

