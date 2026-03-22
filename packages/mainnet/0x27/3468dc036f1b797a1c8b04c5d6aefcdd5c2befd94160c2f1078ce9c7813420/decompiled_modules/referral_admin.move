module 0x273468dc036f1b797a1c8b04c5d6aefcdd5c2befd94160c2f1078ce9c7813420::referral_admin {
    struct ReferralUpdatedEvent has copy, drop {
        app: 0x2::object::ID,
        referrer_discount_bps: u64,
        referee_discount_bps: u64,
        referrer_deposit_usd_threshold: u64,
        sender: address,
        timestamp_ms: u64,
    }

    struct ReferralClaimPauseUpdatedEvent has copy, drop {
        app: 0x2::object::ID,
        is_pause: bool,
        sender: address,
        timestamp_ms: u64,
    }

    public fun update_referral_params(arg0: &0x273468dc036f1b797a1c8b04c5d6aefcdd5c2befd94160c2f1078ce9c7813420::app::AdminCap, arg1: &mut 0x273468dc036f1b797a1c8b04c5d6aefcdd5c2befd94160c2f1078ce9c7813420::app::ProtocolApp, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0x273468dc036f1b797a1c8b04c5d6aefcdd5c2befd94160c2f1078ce9c7813420::app::ensure_version_matches(arg1);
        0x273468dc036f1b797a1c8b04c5d6aefcdd5c2befd94160c2f1078ce9c7813420::referral::update_referral_params(0x273468dc036f1b797a1c8b04c5d6aefcdd5c2befd94160c2f1078ce9c7813420::app::referral_mut(arg1), arg2, arg3, arg4);
        let v0 = ReferralUpdatedEvent{
            app                            : 0x2::object::id<0x273468dc036f1b797a1c8b04c5d6aefcdd5c2befd94160c2f1078ce9c7813420::app::ProtocolApp>(arg1),
            referrer_discount_bps          : arg2,
            referee_discount_bps           : arg3,
            referrer_deposit_usd_threshold : arg4,
            sender                         : 0x2::tx_context::sender(arg6),
            timestamp_ms                   : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<ReferralUpdatedEvent>(v0);
    }

    public fun update_referral_claim_pause(arg0: &0x273468dc036f1b797a1c8b04c5d6aefcdd5c2befd94160c2f1078ce9c7813420::app::AdminCap, arg1: &mut 0x273468dc036f1b797a1c8b04c5d6aefcdd5c2befd94160c2f1078ce9c7813420::app::ProtocolApp, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x273468dc036f1b797a1c8b04c5d6aefcdd5c2befd94160c2f1078ce9c7813420::app::ensure_version_matches(arg1);
        0x273468dc036f1b797a1c8b04c5d6aefcdd5c2befd94160c2f1078ce9c7813420::referral::update_claim_pause(0x273468dc036f1b797a1c8b04c5d6aefcdd5c2befd94160c2f1078ce9c7813420::app::referral_mut(arg1), arg2);
        let v0 = ReferralClaimPauseUpdatedEvent{
            app          : 0x2::object::id<0x273468dc036f1b797a1c8b04c5d6aefcdd5c2befd94160c2f1078ce9c7813420::app::ProtocolApp>(arg1),
            is_pause     : arg2,
            sender       : 0x2::tx_context::sender(arg4),
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<ReferralClaimPauseUpdatedEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

