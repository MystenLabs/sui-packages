module 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::escrow {
    public fun cancel_escrow(arg0: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::EscrowContract, arg1: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::WasteBinObject, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::is_escrow_pending(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_escrow_status(arg0)), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_invalid_state());
        let v0 = 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_waste_bin_status(arg1);
        assert!(v0 != 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::bin_status_collected() && v0 != 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::bin_status_validated(), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_invalid_state());
        assert!(0x2::clock::timestamp_ms(arg3) - 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_escrow_created_at(arg0) <= 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_escrow_refund_grace_ms(), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_invalid_state());
        let v1 = 0x2::balance::value<0x2::sui::SUI>(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_escrow_balance(arg0));
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_escrow_balance_mut(arg0), v1), arg4), arg2);
        };
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::set_escrow_status(arg0, 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::escrow_status_cancelled());
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::events::emit_error(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_invalid_state(), b"Escrow cancelled", b"escrow_cancel_escrow", 0x2::tx_context::epoch_timestamp_ms(arg4));
    }

    public fun create_escrow(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::EscrowContract {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(v0 >= arg4 + arg5, 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_invalid_amount());
        assert!(arg4 > 0, 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_invalid_amount());
        assert!(arg5 > 0, 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_invalid_amount());
        let v1 = 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::create_escrow_contract(arg0, 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::escrow_status_pending(), v0, 0x1::option::some<address>(arg1), 0x1::option::some<address>(arg2), arg4, arg5, 0x2::coin::into_balance<0x2::sui::SUI>(arg3), 0x2::tx_context::epoch_timestamp_ms(arg6), 0x1::option::none<u64>(), arg6);
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::events::emit_escrow_created(0x2::object::id<0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::EscrowContract>(&v1), arg0, v0, 0x1::option::some<address>(arg1), 0x1::option::some<address>(arg2));
        v1
    }

    public fun create_escrow_for_pickup(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) : 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::EscrowContract {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_pay_per_pickup_amount(), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_invalid_amount());
        create_escrow(arg0, arg1, arg2, arg3, 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_pay_per_pickup_collector_share(), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_pay_per_pickup_validator_share(), arg4)
    }

    public fun create_open_escrow_for_pickup(arg0: 0x2::object::ID, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) : 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::EscrowContract {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 >= 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_pay_per_pickup_amount(), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_invalid_amount());
        let v1 = 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::create_escrow_contract(arg0, 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::escrow_status_pending(), v0, 0x1::option::none<address>(), 0x1::option::none<address>(), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_pay_per_pickup_collector_share(), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_pay_per_pickup_validator_share(), 0x2::coin::into_balance<0x2::sui::SUI>(arg1), 0x2::tx_context::epoch_timestamp_ms(arg2), 0x1::option::none<u64>(), arg2);
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::events::emit_escrow_created(0x2::object::id<0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::EscrowContract>(&v1), arg0, v0, 0x1::option::none<address>(), 0x1::option::none<address>());
        v1
    }

    public fun deposit(arg0: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::EscrowContract, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::is_escrow_pending(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_escrow_status(arg0)), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_invalid_state());
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::set_escrow_total_amount(arg0, 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_escrow_total_amount(arg0) + 0x2::coin::value<0x2::sui::SUI>(&arg1));
        0x2::balance::join<0x2::sui::SUI>(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_escrow_balance_mut(arg0), 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun get_balance_value(arg0: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::EscrowContract) : u64 {
        0x2::balance::value<0x2::sui::SUI>(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_escrow_balance(arg0))
    }

    public fun get_bin_id(arg0: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::EscrowContract) : 0x2::object::ID {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_escrow_bin_id(arg0)
    }

    public fun get_collector_address(arg0: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::EscrowContract) : 0x1::option::Option<address> {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_escrow_collector_address(arg0)
    }

    public fun get_collector_share(arg0: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::EscrowContract) : u64 {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_escrow_collector_share(arg0)
    }

    public fun get_status(arg0: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::EscrowContract) : 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::EscrowStatus {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_escrow_status(arg0)
    }

    public fun get_total_amount(arg0: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::EscrowContract) : u64 {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_escrow_total_amount(arg0)
    }

    public fun get_validator_address(arg0: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::EscrowContract) : 0x1::option::Option<address> {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_escrow_validator_address(arg0)
    }

    public fun get_validator_share(arg0: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::EscrowContract) : u64 {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_escrow_validator_share(arg0)
    }

    public fun is_pending(arg0: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::EscrowContract) : bool {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::is_escrow_pending(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_escrow_status(arg0))
    }

    public fun is_released(arg0: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::EscrowContract) : bool {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::is_escrow_released(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_escrow_status(arg0))
    }

    public fun release_payment(arg0: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::EscrowContract, arg1: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::WasteBinObject, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::is_escrow_pending(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_escrow_status(arg0)), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_already_released());
        assert!(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_escrow_bin_id(arg0) == 0x2::object::id<0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::WasteBinObject>(arg1), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_invalid_state());
        let v0 = 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_escrow_collector_address(arg0);
        let v1 = 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_escrow_validator_address(arg0);
        assert!(0x1::option::is_some<address>(&v0), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_not_authorized());
        assert!(0x1::option::is_some<address>(&v1), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_not_authorized());
        let v2 = 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_escrow_collector_share(arg0);
        let v3 = 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_escrow_validator_share(arg0);
        assert!(0x2::balance::value<0x2::sui::SUI>(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_escrow_balance(arg0)) >= v2 + v3, 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_insufficient_funds());
        let v4 = 0x2::clock::timestamp_ms(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_escrow_balance_mut(arg0), v2), arg4), *0x1::option::borrow<address>(&v0));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_escrow_balance_mut(arg0), v3), arg4), *0x1::option::borrow<address>(&v1));
        let v5 = 0x2::balance::value<0x2::sui::SUI>(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_escrow_balance(arg0));
        if (v5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_escrow_balance_mut(arg0), v5), arg4), arg2);
        };
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::set_escrow_status(arg0, 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::escrow_status_released());
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::set_escrow_released_at(arg0, 0x1::option::some<u64>(v4));
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::events::emit_payment_released(0x2::object::id<0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::EscrowContract>(arg0), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_escrow_bin_id(arg0), v2, v3, v4);
    }

    // decompiled from Move bytecode v6
}

