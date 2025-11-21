module 0xbbe1ee70291c47534bf50c1345446713cbc33c36ed7e6b873cc9cf33d33d5307::access_control {
    public fun can_access_content(arg0: &0xbbe1ee70291c47534bf50c1345446713cbc33c36ed7e6b873cc9cf33d33d5307::subscription::SubscriptionToken, arg1: &0xbbe1ee70291c47534bf50c1345446713cbc33c36ed7e6b873cc9cf33d33d5307::content_registry::ContentHandle, arg2: u64) : bool {
        if (!0xbbe1ee70291c47534bf50c1345446713cbc33c36ed7e6b873cc9cf33d33d5307::subscription::is_subscription_active(arg0, arg2)) {
            return false
        };
        if (0xbbe1ee70291c47534bf50c1345446713cbc33c36ed7e6b873cc9cf33d33d5307::subscription::get_subscription_creator(arg0) != 0xbbe1ee70291c47534bf50c1345446713cbc33c36ed7e6b873cc9cf33d33d5307::content_registry::get_creator(arg1)) {
            return false
        };
        if (0xbbe1ee70291c47534bf50c1345446713cbc33c36ed7e6b873cc9cf33d33d5307::subscription::get_subscription_tier_id(arg0) != 0xbbe1ee70291c47534bf50c1345446713cbc33c36ed7e6b873cc9cf33d33d5307::content_registry::get_tier_id(arg1)) {
            return false
        };
        true
    }

    public fun content_requires_tier(arg0: &0xbbe1ee70291c47534bf50c1345446713cbc33c36ed7e6b873cc9cf33d33d5307::content_registry::ContentHandle, arg1: 0x2::object::ID) : bool {
        0xbbe1ee70291c47534bf50c1345446713cbc33c36ed7e6b873cc9cf33d33d5307::content_registry::get_tier_id(arg0) == arg1
    }

    public fun get_subscription_time_remaining(arg0: &0xbbe1ee70291c47534bf50c1345446713cbc33c36ed7e6b873cc9cf33d33d5307::subscription::SubscriptionToken, arg1: u64) : u64 {
        let v0 = 0xbbe1ee70291c47534bf50c1345446713cbc33c36ed7e6b873cc9cf33d33d5307::subscription::get_subscription_expiry(arg0);
        if (v0 > arg1) {
            v0 - arg1
        } else {
            0
        }
    }

    public fun has_active_subscription_to_creator(arg0: &0xbbe1ee70291c47534bf50c1345446713cbc33c36ed7e6b873cc9cf33d33d5307::subscription::SubscriptionToken, arg1: address, arg2: u64) : bool {
        if (!0xbbe1ee70291c47534bf50c1345446713cbc33c36ed7e6b873cc9cf33d33d5307::subscription::is_subscription_active(arg0, arg2)) {
            return false
        };
        0xbbe1ee70291c47534bf50c1345446713cbc33c36ed7e6b873cc9cf33d33d5307::subscription::get_subscription_creator(arg0) == arg1
    }

    public fun is_content_by_creator(arg0: &0xbbe1ee70291c47534bf50c1345446713cbc33c36ed7e6b873cc9cf33d33d5307::content_registry::ContentHandle, arg1: address) : bool {
        0xbbe1ee70291c47534bf50c1345446713cbc33c36ed7e6b873cc9cf33d33d5307::content_registry::get_creator(arg0) == arg1
    }

    public fun is_subscription_active(arg0: &0xbbe1ee70291c47534bf50c1345446713cbc33c36ed7e6b873cc9cf33d33d5307::subscription::SubscriptionToken, arg1: u64) : bool {
        0xbbe1ee70291c47534bf50c1345446713cbc33c36ed7e6b873cc9cf33d33d5307::subscription::is_subscription_active(arg0, arg1)
    }

    public fun validate_access(arg0: &0xbbe1ee70291c47534bf50c1345446713cbc33c36ed7e6b873cc9cf33d33d5307::subscription::SubscriptionToken, arg1: &0xbbe1ee70291c47534bf50c1345446713cbc33c36ed7e6b873cc9cf33d33d5307::content_registry::ContentHandle, arg2: u64) : (bool, u64) {
        if (!0xbbe1ee70291c47534bf50c1345446713cbc33c36ed7e6b873cc9cf33d33d5307::subscription::is_subscription_active(arg0, arg2)) {
            return (false, 4)
        };
        if (0xbbe1ee70291c47534bf50c1345446713cbc33c36ed7e6b873cc9cf33d33d5307::subscription::get_subscription_creator(arg0) != 0xbbe1ee70291c47534bf50c1345446713cbc33c36ed7e6b873cc9cf33d33d5307::content_registry::get_creator(arg1)) {
            return (false, 2)
        };
        if (0xbbe1ee70291c47534bf50c1345446713cbc33c36ed7e6b873cc9cf33d33d5307::subscription::get_subscription_tier_id(arg0) != 0xbbe1ee70291c47534bf50c1345446713cbc33c36ed7e6b873cc9cf33d33d5307::content_registry::get_tier_id(arg1)) {
            return (false, 3)
        };
        (true, 0)
    }

    // decompiled from Move bytecode v6
}

