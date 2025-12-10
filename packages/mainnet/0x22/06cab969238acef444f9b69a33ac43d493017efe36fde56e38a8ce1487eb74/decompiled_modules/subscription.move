module 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::subscription {
    public fun cancel_subscription(arg0: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::Subscription, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_subscription_status(arg0) == 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::subscription_status_active(), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_invalid_state());
        assert!(0x2::tx_context::epoch_timestamp_ms(arg2) - 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_subscription_created_at(arg0) <= 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_subscription_refund_grace_ms(), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_invalid_state());
        assert!(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_subscription_pickups_used(arg0) == 0, 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_invalid_state());
        let v0 = 0x2::balance::value<0x2::sui::SUI>(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_subscription_balance(arg0));
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_subscription_balance_mut(arg0), v0), arg2), arg1);
        };
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::set_subscription_status(arg0, 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::subscription_status_cancelled());
    }

    public fun create_subscription(arg0: address, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::Subscription {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 >= 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_monthly_subscription_amount(), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_invalid_amount());
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = v1 + 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_subscription_duration_ms();
        let v3 = 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::create_subscription(arg0, arg1, 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::subscription_status_active(), v1, v2, 0, 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_max_pickups_per_month(), 0x2::coin::into_balance<0x2::sui::SUI>(arg2), v1, arg4);
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::events::emit_subscription_created(0x2::object::id<0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::Subscription>(&v3), arg1, arg0, v1, v2, v0);
        v3
    }

    public fun deduct_pickup_cost(arg0: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::Subscription, arg1: address, arg2: address, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_subscription_status(arg0) == 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::subscription_status_active(), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_invalid_state());
        let v0 = 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_subscription_pickups_used(arg0);
        let v1 = 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_subscription_max_pickups(arg0);
        if (v0 >= v1) {
            0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::events::emit_subscription_max_pickups_reached(0x2::object::id<0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::Subscription>(arg0), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_subscription_bin_id(arg0), v0, v1, 0x2::clock::timestamp_ms(arg4));
        };
        assert!(v0 < v1, 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_max_pickups_exceeded());
        let v2 = 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_system_cost_per_pickup();
        let v3 = 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_collector_reward_per_pickup();
        let v4 = 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_validator_reward_per_pickup();
        let v5 = v2 + v3 + v4;
        let v6 = 0x2::balance::value<0x2::sui::SUI>(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_subscription_balance(arg0));
        let v7 = 0x2::clock::timestamp_ms(arg4);
        if (v6 < v5) {
            0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::events::emit_subscription_payment_insufficient(0x2::object::id<0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::Subscription>(arg0), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_subscription_bin_id(arg0), v6, v5, v7);
        };
        assert!(v6 >= v5, 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_error_subscription_insufficient_balance());
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_subscription_balance_mut(arg0), v3), arg5), arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_subscription_balance_mut(arg0), v4), arg5), arg2);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_subscription_balance_mut(arg0), v2), arg5), arg3);
        };
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::increment_subscription_pickups_used(arg0);
        let v8 = 0x2::balance::value<0x2::sui::SUI>(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_subscription_balance(arg0));
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::events::emit_pickup_cost_deducted(0x2::object::id<0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::Subscription>(arg0), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_subscription_bin_id(arg0), v5, v8, 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_subscription_pickups_used(arg0), v7);
        if (v8 < v5) {
            0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::events::emit_subscription_low_balance(0x2::object::id<0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::Subscription>(arg0), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_subscription_bin_id(arg0), v8, v5, v7);
        };
        let v9 = 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_subscription_pickups_used(arg0);
        let v10 = 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_subscription_max_pickups(arg0);
        if (v9 >= v10) {
            0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::events::emit_subscription_max_pickups_reached(0x2::object::id<0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::Subscription>(arg0), 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_subscription_bin_id(arg0), v9, v10, v7);
        };
    }

    public fun get_balance(arg0: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::Subscription) : u64 {
        0x2::balance::value<0x2::sui::SUI>(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_subscription_balance(arg0))
    }

    public fun get_bin_id(arg0: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::Subscription) : 0x2::object::ID {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_subscription_bin_id(arg0)
    }

    public fun get_max_pickups(arg0: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::Subscription) : u64 {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_subscription_max_pickups(arg0)
    }

    public fun get_owner(arg0: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::Subscription) : address {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_subscription_owner(arg0)
    }

    public fun get_pickups_used(arg0: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::Subscription) : u64 {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_subscription_pickups_used(arg0)
    }

    public fun get_status(arg0: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::Subscription) : 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::SubscriptionStatus {
        0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_subscription_status(arg0)
    }

    public fun is_expired(arg0: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::Subscription, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) > 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_subscription_expiry_timestamp(arg0)
    }

    public fun is_valid(arg0: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::Subscription, arg1: &0x2::clock::Clock) : bool {
        if (0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_subscription_status(arg0) != 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::subscription_status_active()) {
            return false
        };
        if (0x2::clock::timestamp_ms(arg1) > 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_subscription_expiry_timestamp(arg0)) {
            return false
        };
        if (0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_subscription_pickups_used(arg0) >= 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_subscription_max_pickups(arg0)) {
            return false
        };
        if (0x2::balance::value<0x2::sui::SUI>(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_subscription_balance(arg0)) < 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_system_cost_per_pickup() + 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_collector_reward_per_pickup() + 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::constants::get_validator_reward_per_pickup()) {
            return false
        };
        true
    }

    public fun mark_expired(arg0: &mut 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::Subscription, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_subscription_status(arg0) == 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::subscription_status_active() && is_expired(arg0, arg2)) {
            0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::set_subscription_status(arg0, 0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::subscription_status_expired());
            let v0 = 0x2::balance::value<0x2::sui::SUI>(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_subscription_balance(arg0));
            if (v0 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::get_subscription_balance_mut(arg0), v0), arg3), arg1);
            };
            0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::events::emit_subscription_expired(0x2::object::id<0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::Subscription>(arg0), get_bin_id(arg0), 0x2::clock::timestamp_ms(arg2));
        };
    }

    public fun needs_renewal(arg0: &0x2206cab969238acef444f9b69a33ac43d493017efe36fde56e38a8ce1487eb74::types::Subscription, arg1: &0x2::clock::Clock) : bool {
        is_expired(arg0, arg1)
    }

    // decompiled from Move bytecode v6
}

