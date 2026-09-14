module 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::collateral_debt_redistribution {
    struct CollateralDebtRedistribution<phantom T0> has store, key {
        id: 0x2::object::UID,
        debt_redistribution_amount: u256,
        collateral_redistribution_vault: 0x2::balance::Balance<T0>,
        lifetime_collateral: u256,
        lifetime_debt: u256,
        total_stakes: u256,
        total_stakes_snapshot: u256,
        total_collateral_snapshot: u256,
        last_collateral_error_redistribution: u256,
        last_debt_error_redistribution: u256,
    }

    struct ClaimCarry has drop, store {
        debt_scaled: u256,
        collateral_scaled: u256,
    }

    fun claim_carry_scaled<T0>(arg0: &CollateralDebtRedistribution<T0>) : (u256, u256) {
        if (0x2::dynamic_field::exists_with_type<vector<u8>, ClaimCarry>(&arg0.id, b"cdr_claim_carry_v1")) {
            let v2 = 0x2::dynamic_field::borrow<vector<u8>, ClaimCarry>(&arg0.id, b"cdr_claim_carry_v1");
            (v2.debt_scaled, v2.collateral_scaled)
        } else {
            (0, 0)
        }
    }

    fun clear_claim_carry<T0>(arg0: &mut CollateralDebtRedistribution<T0>) {
        if (0x2::dynamic_field::exists_with_type<vector<u8>, ClaimCarry>(&arg0.id, b"cdr_claim_carry_v1")) {
            0x2::dynamic_field::remove<vector<u8>, ClaimCarry>(&mut arg0.id, b"cdr_claim_carry_v1");
        };
    }

    public(friend) fun create_collateral_debt_redistribution<T0>(arg0: &mut 0x2::tx_context::TxContext) : CollateralDebtRedistribution<T0> {
        CollateralDebtRedistribution<T0>{
            id                                   : 0x2::object::new(arg0),
            debt_redistribution_amount           : 0,
            collateral_redistribution_vault      : 0x2::balance::zero<T0>(),
            lifetime_collateral                  : 0,
            lifetime_debt                        : 0,
            total_stakes                         : 0,
            total_stakes_snapshot                : 0,
            total_collateral_snapshot            : 0,
            last_collateral_error_redistribution : 0,
            last_debt_error_redistribution       : 0,
        }
    }

    public(friend) fun intern_after_liquidation_update_system_snapshots<T0>(arg0: 0x2::object::ID, arg1: &mut CollateralDebtRedistribution<T0>, arg2: u256) {
        arg1.total_stakes_snapshot = arg1.total_stakes;
        arg1.total_collateral_snapshot = arg2;
    }

    public(friend) fun intern_compute_collateral_debt_rewards<T0>(arg0: u256, arg1: u256, arg2: u256, arg3: &mut CollateralDebtRedistribution<T0>) : (0x2::balance::Balance<T0>, u64) {
        abort 0
    }

    public(friend) fun intern_compute_collateral_debt_rewards_v2<T0>(arg0: u256, arg1: u256, arg2: u256, arg3: &mut CollateralDebtRedistribution<T0>, arg4: u256) : (0x2::balance::Balance<T0>, u64) {
        let (v0, v1) = claim_carry_scaled<T0>(arg3);
        let v2 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_scaled_val(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::mul(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_scaled_val(arg0), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::sub(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_scaled_val(arg3.lifetime_debt), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_scaled_val(arg2)))) + v0 + arg3.last_debt_error_redistribution;
        let v3 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_scaled_val(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::mul(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_scaled_val(arg0), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::sub(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_scaled_val(arg3.lifetime_collateral), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_scaled_val(arg1)))) + v1 + arg3.last_collateral_error_redistribution;
        assert!(v2 <= arg3.debt_redistribution_amount, 58);
        let v4 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_dori(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_scaled_val(v2));
        let v5 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_scaled_val(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_dori(v4));
        let v6 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_token(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_scaled_val(v3), arg4);
        assert!(v6 <= 0x2::balance::value<T0>(&arg3.collateral_redistribution_vault), 58);
        let v7 = 0x2::balance::split<T0>(&mut arg3.collateral_redistribution_vault, v6);
        arg3.debt_redistribution_amount = arg3.debt_redistribution_amount - v5;
        arg3.last_debt_error_redistribution = 0;
        arg3.last_collateral_error_redistribution = 0;
        set_claim_carry_scaled<T0>(arg3, v2 - v5, v3 - 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_scaled_val(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_token(v6, arg4)), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_scaled_val(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_token(1, arg4)));
        (v7, v4)
    }

    public(friend) fun intern_get_pending_collateral_value<T0>(arg0: &CollateralDebtRedistribution<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.collateral_redistribution_vault)
    }

    public(friend) fun intern_get_pending_debt<T0>(arg0: &CollateralDebtRedistribution<T0>) : u256 {
        arg0.debt_redistribution_amount
    }

    public(friend) fun intern_redistribute_debt_and_collateral<T0>(arg0: 0x2::object::ID, arg1: u256, arg2: 0x2::balance::Balance<T0>, arg3: &mut CollateralDebtRedistribution<T0>) {
        abort 0
    }

    public(friend) fun intern_redistribute_debt_and_collateral_v2<T0>(arg0: 0x2::object::ID, arg1: u256, arg2: 0x2::balance::Balance<T0>, arg3: &mut CollateralDebtRedistribution<T0>, arg4: u256) {
        let v0 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_scaled_val(arg3.total_stakes);
        let v1 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::add(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_token(0x2::balance::value<T0>(&arg2), arg4), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_scaled_val(arg3.last_collateral_error_redistribution));
        let v2 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::add(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_scaled_val(arg1), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_scaled_val(arg3.last_debt_error_redistribution));
        let v3 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::div(v1, v0);
        let v4 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::div(v2, v0);
        arg3.last_collateral_error_redistribution = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_scaled_val(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::sub(v1, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::mul(v3, v0)));
        arg3.last_debt_error_redistribution = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_scaled_val(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::sub(v2, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::mul(v4, v0)));
        arg3.lifetime_collateral = arg3.lifetime_collateral + 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_scaled_val(v3);
        arg3.lifetime_debt = arg3.lifetime_debt + 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_scaled_val(v4);
        0x2::balance::join<T0>(&mut arg3.collateral_redistribution_vault, arg2);
        arg3.debt_redistribution_amount = arg3.debt_redistribution_amount + arg1;
    }

    public(friend) fun intern_settle_final_redistribution_dust_and_reset<T0>(arg0: &mut CollateralDebtRedistribution<T0>) : 0x2::balance::Balance<T0> {
        assert!(arg0.total_stakes == 0, 58);
        assert!(arg0.debt_redistribution_amount < 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_scaled_val(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_dori(1)), 58);
        let (v0, _) = claim_carry_scaled<T0>(arg0);
        assert!(v0 <= arg0.debt_redistribution_amount, 58);
        let v2 = 0x2::balance::withdraw_all<T0>(&mut arg0.collateral_redistribution_vault);
        clear_claim_carry<T0>(arg0);
        arg0.debt_redistribution_amount = 0;
        arg0.lifetime_collateral = 0;
        arg0.lifetime_debt = 0;
        arg0.total_stakes = 0;
        arg0.total_stakes_snapshot = 0;
        arg0.total_collateral_snapshot = 0;
        arg0.last_collateral_error_redistribution = 0;
        arg0.last_debt_error_redistribution = 0;
        v2
    }

    public(friend) fun intern_update_and_get_new_stake<T0>(arg0: 0x2::object::ID, arg1: u256, arg2: u256, arg3: &mut CollateralDebtRedistribution<T0>) : (u256, u256, u256) {
        let v0 = if (arg3.total_collateral_snapshot == 0) {
            arg2
        } else {
            0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_scaled_val(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::div(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::mul(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_scaled_val(arg2), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_scaled_val(arg3.total_stakes_snapshot)), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_scaled_val(arg3.total_collateral_snapshot)))
        };
        arg3.total_stakes = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_scaled_val(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::add(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::sub(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_scaled_val(arg3.total_stakes), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_scaled_val(arg1)), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_scaled_val(v0)));
        (v0, arg3.lifetime_collateral, arg3.lifetime_debt)
    }

    public(friend) fun migrate_fix_lifetime_collateral_scale<T0>(arg0: &mut CollateralDebtRedistribution<T0>, arg1: u256) {
        abort 0
    }

    fun set_claim_carry_scaled<T0>(arg0: &mut CollateralDebtRedistribution<T0>, arg1: u256, arg2: u256, arg3: u256) {
        assert!(arg1 < 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_scaled_val(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_native_dori(1)), 58);
        assert!(arg3 > 0, 58);
        assert!(arg2 < arg3, 58);
        if (arg1 == 0 && arg2 == 0) {
            if (0x2::dynamic_field::exists_with_type<vector<u8>, ClaimCarry>(&arg0.id, b"cdr_claim_carry_v1")) {
                0x2::dynamic_field::remove<vector<u8>, ClaimCarry>(&mut arg0.id, b"cdr_claim_carry_v1");
            };
        } else if (0x2::dynamic_field::exists_with_type<vector<u8>, ClaimCarry>(&arg0.id, b"cdr_claim_carry_v1")) {
            let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, ClaimCarry>(&mut arg0.id, b"cdr_claim_carry_v1");
            v0.debt_scaled = arg1;
            v0.collateral_scaled = arg2;
        } else {
            let v1 = ClaimCarry{
                debt_scaled       : arg1,
                collateral_scaled : arg2,
            };
            0x2::dynamic_field::add<vector<u8>, ClaimCarry>(&mut arg0.id, b"cdr_claim_carry_v1", v1);
        };
    }

    // decompiled from Move bytecode v6
}

