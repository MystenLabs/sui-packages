module 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::protocol_fees {
    struct ProtocolFees has store {
        referrals: 0x2::table::Table<address, ReferralTracker>,
        total_shares: u64,
        fees_per_share: u64,
    }

    struct ReferralTracker has store {
        shares: u64,
        share_ms: u64,
        last_update_timestamp: u64,
    }

    struct Referral has key {
        id: 0x2::object::UID,
        owner: address,
        last_claim_timestamp: u64,
        last_claim_share_ms: u64,
        last_fees_per_share: u64,
    }

    public(friend) fun calculate_and_claim(arg0: &mut ProtocolFees, arg1: &mut Referral, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::table::borrow_mut<address, ReferralTracker>(&mut arg0.referrals, 0x2::object::uid_to_address(&arg1.id));
        update_share_ms(v0, arg2);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = v1 - arg1.last_claim_timestamp;
        if (v2 == 0) {
            return 0
        };
        arg1.last_claim_timestamp = v1;
        arg1.last_claim_share_ms = v0.share_ms;
        arg1.last_fees_per_share = arg0.fees_per_share;
        0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::math::mul(0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::math::div(v0.share_ms - arg1.last_claim_share_ms, v2), arg0.fees_per_share - arg1.last_fees_per_share)
    }

    public(friend) fun decrease_shares(arg0: &mut ProtocolFees, arg1: 0x1::option::Option<address>, arg2: u64, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::table::borrow_mut<address, ReferralTracker>(&mut arg0.referrals, 0x1::option::destroy_with_default<address>(arg1, 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_constants::default_referral()));
        update_share_ms(v0, arg3);
        v0.shares = v0.shares - arg2;
    }

    public(friend) fun default_protocol_fees(arg0: &mut 0x2::tx_context::TxContext, arg1: &0x2::clock::Clock) : ProtocolFees {
        let v0 = ProtocolFees{
            referrals      : 0x2::table::new<address, ReferralTracker>(arg0),
            total_shares   : 0,
            fees_per_share : 0,
        };
        let v1 = ReferralTracker{
            shares                : 0,
            share_ms              : 0,
            last_update_timestamp : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::table::add<address, ReferralTracker>(&mut v0.referrals, 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_constants::default_referral(), v1);
        v0
    }

    public(friend) fun increase_fees_per_share(arg0: &mut ProtocolFees, arg1: u64, arg2: u64) {
        let v0 = arg0.total_shares == 0 && arg2 > 0;
        assert!(!v0, 1);
        if (arg0.total_shares > 0) {
            arg0.fees_per_share = arg0.fees_per_share + 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::math::div(arg2, arg0.total_shares);
        };
        arg0.total_shares = arg1;
    }

    public(friend) fun increase_shares(arg0: &mut ProtocolFees, arg1: 0x1::option::Option<address>, arg2: u64, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::table::borrow_mut<address, ReferralTracker>(&mut arg0.referrals, 0x1::option::destroy_with_default<address>(arg1, 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_constants::default_referral()));
        update_share_ms(v0, arg3);
        v0.shares = v0.shares + arg2;
    }

    public(friend) fun mint_referral(arg0: &mut ProtocolFees, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::new(arg2);
        let v1 = ReferralTracker{
            shares                : 0,
            share_ms              : 0,
            last_update_timestamp : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::table::add<address, ReferralTracker>(&mut arg0.referrals, 0x2::object::uid_to_address(&v0), v1);
        let v2 = Referral{
            id                   : v0,
            owner                : 0x2::tx_context::sender(arg2),
            last_claim_timestamp : 0x2::clock::timestamp_ms(arg1),
            last_claim_share_ms  : 0,
            last_fees_per_share  : arg0.fees_per_share,
        };
        0x2::transfer::share_object<Referral>(v2);
        0x2::object::uid_to_inner(&v0)
    }

    fun update_share_ms(arg0: &mut ReferralTracker, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        arg0.share_ms = arg0.share_ms + 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::math::mul(arg0.shares, v0 - arg0.last_update_timestamp);
        arg0.last_update_timestamp = v0;
    }

    // decompiled from Move bytecode v6
}

