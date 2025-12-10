module 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::payment_checker {
    public fun is_escrow_payment_valid(arg0: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::EscrowContract) : bool {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::escrow::is_pending(arg0) && 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::escrow::get_balance_value(arg0) >= 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_pay_per_pickup_amount()
    }

    public fun is_subscription_payment_valid(arg0: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::Subscription, arg1: &0x2::clock::Clock) : bool {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::subscription::is_valid(arg0, arg1)
    }

    public fun require_payment(arg0: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::WasteBinObject, arg1: 0x1::option::Option<0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::EscrowContract>, arg2: 0x1::option::Option<0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::Subscription>, arg3: &0x2::clock::Clock) : (0x1::option::Option<0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::EscrowContract>, 0x1::option::Option<0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::Subscription>) {
        let v0 = if (0x1::option::is_some<0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::EscrowContract>(&arg1)) {
            let v1 = 0x1::option::borrow<0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::EscrowContract>(&arg1);
            0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::escrow::is_pending(v1) && 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::escrow::get_balance_value(v1) >= 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_pay_per_pickup_amount()
        } else {
            false
        };
        let v2 = 0x1::option::is_some<0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::Subscription>(&arg2) && 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::subscription::is_valid(0x1::option::borrow<0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::Subscription>(&arg2), arg3);
        assert!(v0 || v2, 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_no_payment());
        (arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

