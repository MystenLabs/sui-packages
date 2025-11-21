module 0x854f78154ceeb56c5db0090b48e7279cca9671e3f78030cbb1d602632e56a6b9::access_control {
    public fun can_access_content(arg0: &0x854f78154ceeb56c5db0090b48e7279cca9671e3f78030cbb1d602632e56a6b9::subscription::SubscriptionToken, arg1: &0x854f78154ceeb56c5db0090b48e7279cca9671e3f78030cbb1d602632e56a6b9::content_registry::ContentHandle, arg2: u64) : bool {
        if (!0x854f78154ceeb56c5db0090b48e7279cca9671e3f78030cbb1d602632e56a6b9::subscription::is_subscription_active(arg0, arg2)) {
            return false
        };
        if (0x854f78154ceeb56c5db0090b48e7279cca9671e3f78030cbb1d602632e56a6b9::subscription::get_subscription_creator(arg0) != 0x854f78154ceeb56c5db0090b48e7279cca9671e3f78030cbb1d602632e56a6b9::content_registry::get_creator(arg1)) {
            return false
        };
        if (0x854f78154ceeb56c5db0090b48e7279cca9671e3f78030cbb1d602632e56a6b9::subscription::get_subscription_tier_id(arg0) != 0x854f78154ceeb56c5db0090b48e7279cca9671e3f78030cbb1d602632e56a6b9::content_registry::get_tier_id(arg1)) {
            return false
        };
        true
    }

    public fun content_requires_tier(arg0: &0x854f78154ceeb56c5db0090b48e7279cca9671e3f78030cbb1d602632e56a6b9::content_registry::ContentHandle, arg1: 0x2::object::ID) : bool {
        0x854f78154ceeb56c5db0090b48e7279cca9671e3f78030cbb1d602632e56a6b9::content_registry::get_tier_id(arg0) == arg1
    }

    public fun get_subscription_time_remaining(arg0: &0x854f78154ceeb56c5db0090b48e7279cca9671e3f78030cbb1d602632e56a6b9::subscription::SubscriptionToken, arg1: u64) : u64 {
        let v0 = 0x854f78154ceeb56c5db0090b48e7279cca9671e3f78030cbb1d602632e56a6b9::subscription::get_subscription_expiry(arg0);
        if (v0 > arg1) {
            v0 - arg1
        } else {
            0
        }
    }

    public fun has_active_subscription_to_creator(arg0: &0x854f78154ceeb56c5db0090b48e7279cca9671e3f78030cbb1d602632e56a6b9::subscription::SubscriptionToken, arg1: address, arg2: u64) : bool {
        if (!0x854f78154ceeb56c5db0090b48e7279cca9671e3f78030cbb1d602632e56a6b9::subscription::is_subscription_active(arg0, arg2)) {
            return false
        };
        0x854f78154ceeb56c5db0090b48e7279cca9671e3f78030cbb1d602632e56a6b9::subscription::get_subscription_creator(arg0) == arg1
    }

    public fun is_content_by_creator(arg0: &0x854f78154ceeb56c5db0090b48e7279cca9671e3f78030cbb1d602632e56a6b9::content_registry::ContentHandle, arg1: address) : bool {
        0x854f78154ceeb56c5db0090b48e7279cca9671e3f78030cbb1d602632e56a6b9::content_registry::get_creator(arg0) == arg1
    }

    public fun is_subscription_active(arg0: &0x854f78154ceeb56c5db0090b48e7279cca9671e3f78030cbb1d602632e56a6b9::subscription::SubscriptionToken, arg1: u64) : bool {
        0x854f78154ceeb56c5db0090b48e7279cca9671e3f78030cbb1d602632e56a6b9::subscription::is_subscription_active(arg0, arg1)
    }

    public fun validate_access(arg0: &0x854f78154ceeb56c5db0090b48e7279cca9671e3f78030cbb1d602632e56a6b9::subscription::SubscriptionToken, arg1: &0x854f78154ceeb56c5db0090b48e7279cca9671e3f78030cbb1d602632e56a6b9::content_registry::ContentHandle, arg2: u64) : (bool, u64) {
        if (!0x854f78154ceeb56c5db0090b48e7279cca9671e3f78030cbb1d602632e56a6b9::subscription::is_subscription_active(arg0, arg2)) {
            return (false, 4)
        };
        if (0x854f78154ceeb56c5db0090b48e7279cca9671e3f78030cbb1d602632e56a6b9::subscription::get_subscription_creator(arg0) != 0x854f78154ceeb56c5db0090b48e7279cca9671e3f78030cbb1d602632e56a6b9::content_registry::get_creator(arg1)) {
            return (false, 2)
        };
        if (0x854f78154ceeb56c5db0090b48e7279cca9671e3f78030cbb1d602632e56a6b9::subscription::get_subscription_tier_id(arg0) != 0x854f78154ceeb56c5db0090b48e7279cca9671e3f78030cbb1d602632e56a6b9::content_registry::get_tier_id(arg1)) {
            return (false, 3)
        };
        (true, 0)
    }

    // decompiled from Move bytecode v6
}

