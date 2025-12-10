module 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::validator {
    public fun get_status(arg0: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::ValidatorCompany) : 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::ValidatorStatus {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_validator_company_status(arg0)
    }

    public fun get_total_validations(arg0: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::ValidatorCompany) : u64 {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_validator_company_total_validations(arg0)
    }

    public fun get_validator_address(arg0: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::ValidatorCompany) : address {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_validator_company_address(arg0)
    }

    public fun is_active(arg0: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::ValidatorCompany) : bool {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_validator_company_status(arg0) == 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::validator_status_active()
    }

    public fun pause_validator(arg0: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::ValidatorCompany, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_validator_company_address(arg0), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_not_authorized());
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::set_validator_company_status(arg0, 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::validator_status_paused());
    }

    public fun register_validator(arg0: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::ValidatorAllowlist, arg1: &mut 0x2::tx_context::TxContext) : 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::ValidatorCompany {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::admin::is_validator_allowlisted(arg0, v0), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_not_allowlisted());
        let v1 = 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::create_validator_company(v0, 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::validator_status_active(), 0, 0x2::tx_context::epoch_timestamp_ms(arg1), arg1);
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::events::emit_validator_registered(0x2::object::id<0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::ValidatorCompany>(&v1), v0);
        v1
    }

    public fun require_active(arg0: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::ValidatorCompany) {
        assert!(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_validator_company_status(arg0) == 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::validator_status_active(), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_invalid_state());
    }

    public fun resume_validator(arg0: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::ValidatorCompany, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_validator_company_address(arg0), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_not_authorized());
        assert!(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_validator_company_status(arg0) == 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::validator_status_paused(), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_invalid_state());
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::set_validator_company_status(arg0, 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::validator_status_active());
    }

    public fun validate_dropoff_with_escrow(arg0: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::ValidatorCompany, arg1: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::WasteBinObject, arg2: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::EscrowContract, arg3: address, arg4: bool, arg5: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::ValidatorAllowlist, arg6: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::SystemConfig, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        assert!(v0 == 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_validator_company_address(arg0), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_not_authorized());
        assert!(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::admin::is_validator_allowlisted(arg5, v0), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_not_allowlisted());
        assert!(!0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::admin::is_system_paused(arg6), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_system_paused());
        assert!(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_validator_company_status(arg0) == 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::validator_status_active(), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_invalid_state());
        assert!(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::bin::get_status(arg1) == 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::bin_status_collected(), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_invalid_state());
        assert!(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::bin::get_status(arg1) != 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::bin_status_error(), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_invalid_state());
        let v1 = 0x2::clock::timestamp_ms(arg7);
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::increment_validator_company_total_validations(arg0);
        if (arg4) {
            0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::bin::mark_validated(arg1, arg8);
            0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::set_escrow_validator_address(arg2, 0x1::option::some<address>(v0));
            0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::escrow::release_payment(arg2, arg1, arg3, arg7, arg8);
            0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::events::emit_dropoff_validated(0x2::object::id<0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::ValidatorCompany>(arg0), 0x2::object::id<0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::WasteBinObject>(arg1), true, v1, 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::bin::get_location(arg1));
        } else {
            0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::events::emit_error(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_invalid_state(), b"Invalid drop-off validation", b"validator_validate_dropoff", v1);
            0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::events::emit_dropoff_validated(0x2::object::id<0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::ValidatorCompany>(arg0), 0x2::object::id<0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::WasteBinObject>(arg1), false, v1, 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::bin::get_location(arg1));
        };
    }

    public fun validate_dropoff_with_subscription(arg0: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::ValidatorCompany, arg1: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::WasteBinObject, arg2: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::Subscription, arg3: bool, arg4: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::ValidatorAllowlist, arg5: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::SystemConfig, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(v0 == 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_validator_company_address(arg0), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_not_authorized());
        assert!(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::admin::is_validator_allowlisted(arg4, v0), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_not_allowlisted());
        assert!(!0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::admin::is_system_paused(arg5), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_system_paused());
        assert!(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_validator_company_status(arg0) == 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::validator_status_active(), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_invalid_state());
        assert!(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::bin::get_status(arg1) == 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::bin_status_collected(), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_invalid_state());
        assert!(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::bin::get_status(arg1) != 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::bin_status_error(), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_invalid_state());
        let v1 = 0x2::clock::timestamp_ms(arg6);
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::increment_validator_company_total_validations(arg0);
        if (arg3) {
            0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::bin::mark_validated(arg1, arg7);
            let v2 = 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::bin::get_assigned_collector(arg1);
            0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::subscription::deduct_pickup_cost(arg2, *0x1::option::borrow<address>(&v2), v0, 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_system_treasury_address(), arg6, arg7);
            0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::events::emit_dropoff_validated(0x2::object::id<0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::ValidatorCompany>(arg0), 0x2::object::id<0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::WasteBinObject>(arg1), true, v1, 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::bin::get_location(arg1));
        } else {
            0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::events::emit_error(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_invalid_state(), b"Invalid drop-off validation", b"validator_validate_dropoff", v1);
            0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::events::emit_dropoff_validated(0x2::object::id<0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::ValidatorCompany>(arg0), 0x2::object::id<0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::WasteBinObject>(arg1), false, v1, 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::bin::get_location(arg1));
        };
    }

    // decompiled from Move bytecode v6
}

