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
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_liquidation_update_snapshot_event(arg0, arg1.total_stakes_snapshot, arg1.total_collateral_snapshot);
    }

    public(friend) fun intern_compute_collateral_debt_rewards<T0>(arg0: u256, arg1: u256, arg2: u256, arg3: &mut CollateralDebtRedistribution<T0>) : (0x2::balance::Balance<T0>, u64) {
        abort 0
    }

    public(friend) fun intern_compute_collateral_debt_rewards_v2<T0>(arg0: u256, arg1: u256, arg2: u256, arg3: &mut CollateralDebtRedistribution<T0>, arg4: u256) : (0x2::balance::Balance<T0>, u64) {
        let v0 = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::mul(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_scaled_val(arg0), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::sub(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_scaled_val(arg3.lifetime_debt), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_scaled_val(arg2)));
        arg3.debt_redistribution_amount = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_scaled_val(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::sub(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_scaled_val(arg3.debt_redistribution_amount), v0));
        (0x2::balance::split<T0>(&mut arg3.collateral_redistribution_vault, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_token(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::mul(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_scaled_val(arg0), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::sub(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_scaled_val(arg3.lifetime_collateral), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_scaled_val(arg1))), arg4)), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_dori(v0))
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
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_collateral_debt_redistribution_event(arg0, arg3.lifetime_collateral, arg3.lifetime_debt, 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_scaled_val(v0), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_native_dori(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_scaled_val(arg3.debt_redistribution_amount)), 0x2::balance::value<T0>(&arg3.collateral_redistribution_vault));
    }

    public(friend) fun intern_update_and_get_new_stake<T0>(arg0: 0x2::object::ID, arg1: u256, arg2: u256, arg3: &mut CollateralDebtRedistribution<T0>) : (u256, u256, u256) {
        let v0 = if (arg3.total_collateral_snapshot == 0) {
            arg2
        } else {
            0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_scaled_val(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::div(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::mul(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_scaled_val(arg2), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_scaled_val(arg3.total_stakes_snapshot)), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_scaled_val(arg3.total_collateral_snapshot)))
        };
        arg3.total_stakes = 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::to_scaled_val(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::add(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::sub(0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_scaled_val(arg3.total_stakes), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_scaled_val(arg1)), 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::wf_decimal::from_scaled_val(v0)));
        0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::events_v1::emit_update_and_get_new_stake_event(arg0, arg3.total_stakes);
        (v0, arg3.lifetime_collateral, arg3.lifetime_debt)
    }

    public(friend) fun migrate_fix_lifetime_collateral_scale<T0>(arg0: &mut CollateralDebtRedistribution<T0>, arg1: u256) {
        arg0.lifetime_collateral = arg0.lifetime_collateral * arg1;
    }

    // decompiled from Move bytecode v6
}

