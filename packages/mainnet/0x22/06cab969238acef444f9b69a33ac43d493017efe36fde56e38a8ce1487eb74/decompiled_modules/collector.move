module 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::collector {
    public fun get_status(arg0: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::Collector) : 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::CollectorStatus {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_collector_status(arg0)
    }

    public fun accept_job_with_escrow(arg0: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::Collector, arg1: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::WasteBinObject, arg2: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::EscrowContract, arg3: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::CollectorAllowlist, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(v0 == 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_collector_address(arg0), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_not_authorized());
        assert!(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::admin::is_collector_allowlisted(arg3, v0), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_not_allowlisted());
        assert!(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_collector_status(arg0) == 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::collector_status_available(), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_already_assigned());
        assert!(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::bin::is_full(arg1), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_invalid_state());
        assert!(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::bin::get_status(arg1) != 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::bin_status_error(), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_invalid_state());
        let v1 = 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::bin::get_assigned_collector(arg1);
        assert!(0x1::option::is_none<address>(&v1), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_already_assigned());
        assert!(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::payment_checker::is_escrow_payment_valid(arg2), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_no_payment());
        let v2 = 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::bin::get_linked_escrow(arg1);
        assert!(0x1::option::is_some<0x2::object::ID>(&v2), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_no_payment());
        assert!(*0x1::option::borrow<0x2::object::ID>(&v2) == 0x2::object::id<0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::EscrowContract>(arg2), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_invalid_state());
        let v3 = 0x2::object::id<0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::WasteBinObject>(arg1);
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::set_collector_status(arg0, 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::collector_status_assigned());
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::set_active_bin_id(arg0, 0x1::option::some<0x2::object::ID>(v3));
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::bin::assign_collector(arg1, v0);
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::set_escrow_collector_address(arg2, 0x1::option::some<address>(v0));
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::events::emit_job_accepted(0x2::object::id<0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::Collector>(arg0), v3, 0x2::clock::timestamp_ms(arg4), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::bin::get_location(arg1));
    }

    public fun accept_job_with_subscription(arg0: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::Collector, arg1: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::WasteBinObject, arg2: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::Subscription, arg3: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::CollectorAllowlist, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(v0 == 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_collector_address(arg0), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_not_authorized());
        assert!(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::admin::is_collector_allowlisted(arg3, v0), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_not_allowlisted());
        assert!(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_collector_status(arg0) == 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::collector_status_available(), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_already_assigned());
        assert!(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::bin::is_full(arg1), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_invalid_state());
        assert!(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::bin::get_status(arg1) != 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::bin_status_error(), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_invalid_state());
        let v1 = 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::bin::get_assigned_collector(arg1);
        assert!(0x1::option::is_none<address>(&v1), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_already_assigned());
        assert!(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::payment_checker::is_subscription_payment_valid(arg2, arg4), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_no_payment());
        let v2 = 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::bin::get_linked_subscription(arg1);
        assert!(0x1::option::is_some<0x2::object::ID>(&v2), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_no_payment());
        assert!(*0x1::option::borrow<0x2::object::ID>(&v2) == 0x2::object::id<0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::Subscription>(arg2), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_invalid_state());
        let v3 = 0x2::object::id<0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::WasteBinObject>(arg1);
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::set_collector_status(arg0, 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::collector_status_assigned());
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::set_active_bin_id(arg0, 0x1::option::some<0x2::object::ID>(v3));
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::bin::assign_collector(arg1, v0);
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::events::emit_job_accepted(0x2::object::id<0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::Collector>(arg0), v3, 0x2::clock::timestamp_ms(arg4), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::bin::get_location(arg1));
    }

    public fun complete_job(arg0: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::Collector) {
        assert!(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_collector_status(arg0) == 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::collector_status_in_transit(), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_invalid_state());
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::set_collector_status(arg0, 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::collector_status_available());
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::set_active_bin_id(arg0, 0x1::option::none<0x2::object::ID>());
    }

    public fun confirm_pickup(arg0: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::Collector, arg1: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::WasteBinObject, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_collector_address(arg0), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_not_authorized());
        assert!(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_collector_status(arg0) == 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::collector_status_assigned(), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_invalid_state());
        assert!(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::bin::get_status(arg1) == 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::bin_status_full(), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_invalid_state());
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::set_collector_status(arg0, 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::collector_status_in_transit());
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::increment_total_pickups(arg0);
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::bin::mark_collected(arg1, arg3);
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::events::emit_pickup_confirmed(0x2::object::id<0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::Collector>(arg0), 0x2::object::id<0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::WasteBinObject>(arg1), 0x2::clock::timestamp_ms(arg2), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::bin::get_location(arg1));
    }

    public fun get_active_bin_id(arg0: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::Collector) : 0x1::option::Option<0x2::object::ID> {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_active_bin_id(arg0)
    }

    public fun get_collector_address(arg0: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::Collector) : address {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_collector_address(arg0)
    }

    public fun get_total_pickups(arg0: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::Collector) : u64 {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_total_pickups(arg0)
    }

    public fun is_available(arg0: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::Collector) : bool {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_collector_status(arg0) == 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::collector_status_available()
    }

    public fun register_collector(arg0: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::CollectorAllowlist, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) : 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::Collector {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::admin::is_collector_allowlisted(arg0, v0), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_not_allowlisted());
        let v1 = 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::create_collector(v0, arg1, 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::collector_status_available(), 0x1::option::none<0x2::object::ID>(), 0, 0x2::tx_context::epoch_timestamp_ms(arg2), arg2);
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::events::emit_collector_registered(0x2::object::id<0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::Collector>(&v1), v0, arg1);
        v1
    }

    // decompiled from Move bytecode v6
}

