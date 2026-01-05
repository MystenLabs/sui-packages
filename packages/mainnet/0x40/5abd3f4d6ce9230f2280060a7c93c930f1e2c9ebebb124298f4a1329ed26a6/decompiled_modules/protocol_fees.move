module 0x405abd3f4d6ce9230f2280060a7c93c930f1e2c9ebebb124298f4a1329ed26a6::protocol_fees {
    struct ProtocolFees has store {
        referrals: 0x2::table::Table<0x2::object::ID, ReferralTracker>,
        total_shares: u64,
        fees_per_share: u64,
        maintainer_fees: u64,
        protocol_fees: u64,
        extra_fields: 0x2::vec_map::VecMap<0x1::string::String, u64>,
    }

    struct ReferralTracker has store {
        current_shares: u64,
        last_fees_per_share: u64,
        unclaimed_fees: u64,
    }

    struct SupplyReferral has key {
        id: 0x2::object::UID,
        owner: address,
    }

    struct ProtocolFeesIncreasedEvent has copy, drop {
        margin_pool_id: 0x2::object::ID,
        total_shares: u64,
        referral_fees: u64,
        maintainer_fees: u64,
        protocol_fees: u64,
    }

    struct ReferralFeesClaimedEvent has copy, drop {
        referral_id: 0x2::object::ID,
        owner: address,
        fees: u64,
    }

    public fun protocol_fees(arg0: &ProtocolFees) : u64 {
        arg0.protocol_fees
    }

    public(friend) fun calculate_and_claim(arg0: &mut ProtocolFees, arg1: &SupplyReferral, arg2: &0x2::tx_context::TxContext) : u64 {
        assert!(0x2::tx_context::sender(arg2) == arg1.owner, 1);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, ReferralTracker>(&mut arg0.referrals, 0x2::object::uid_to_inner(&arg1.id));
        update_unclaimed_fees(v0, arg0.fees_per_share);
        let v1 = v0.unclaimed_fees;
        v0.unclaimed_fees = 0;
        let v2 = ReferralFeesClaimedEvent{
            referral_id : 0x2::object::uid_to_inner(&arg1.id),
            owner       : arg1.owner,
            fees        : v1,
        };
        0x2::event::emit<ReferralFeesClaimedEvent>(v2);
        v1
    }

    public(friend) fun claim_default_referral_fees(arg0: &mut ProtocolFees) : u64 {
        let v0 = 0x405abd3f4d6ce9230f2280060a7c93c930f1e2c9ebebb124298f4a1329ed26a6::margin_constants::default_referral();
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, ReferralTracker>(&mut arg0.referrals, v0);
        update_unclaimed_fees(v1, arg0.fees_per_share);
        let v2 = v1.unclaimed_fees;
        v1.unclaimed_fees = 0;
        let v3 = ReferralFeesClaimedEvent{
            referral_id : v0,
            owner       : 0x2::object::id_to_address(&v0),
            fees        : v2,
        };
        0x2::event::emit<ReferralFeesClaimedEvent>(v3);
        v2
    }

    public(friend) fun claim_maintainer_fees(arg0: &mut ProtocolFees) : u64 {
        arg0.maintainer_fees = 0;
        arg0.maintainer_fees
    }

    public(friend) fun claim_protocol_fees(arg0: &mut ProtocolFees) : u64 {
        arg0.protocol_fees = 0;
        arg0.protocol_fees
    }

    public(friend) fun decrease_shares(arg0: &mut ProtocolFees, arg1: 0x1::option::Option<0x2::object::ID>, arg2: u64) {
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, ReferralTracker>(&mut arg0.referrals, 0x1::option::destroy_with_default<0x2::object::ID>(arg1, 0x405abd3f4d6ce9230f2280060a7c93c930f1e2c9ebebb124298f4a1329ed26a6::margin_constants::default_referral()));
        update_unclaimed_fees(v0, arg0.fees_per_share);
        v0.current_shares = v0.current_shares - arg2;
        arg0.total_shares = arg0.total_shares - arg2;
    }

    public(friend) fun default_protocol_fees(arg0: &mut 0x2::tx_context::TxContext) : ProtocolFees {
        let v0 = ProtocolFees{
            referrals       : 0x2::table::new<0x2::object::ID, ReferralTracker>(arg0),
            total_shares    : 0,
            fees_per_share  : 0,
            maintainer_fees : 0,
            protocol_fees   : 0,
            extra_fields    : 0x2::vec_map::empty<0x1::string::String, u64>(),
        };
        let v1 = ReferralTracker{
            current_shares      : 0,
            last_fees_per_share : 0,
            unclaimed_fees      : 0,
        };
        0x2::table::add<0x2::object::ID, ReferralTracker>(&mut v0.referrals, 0x405abd3f4d6ce9230f2280060a7c93c930f1e2c9ebebb124298f4a1329ed26a6::margin_constants::default_referral(), v1);
        v0
    }

    public fun fees_per_share(arg0: &ProtocolFees) : u64 {
        arg0.fees_per_share
    }

    public(friend) fun increase_fees_accrued(arg0: &mut ProtocolFees, arg1: 0x2::object::ID, arg2: u64) {
        if (arg2 == 0) {
            return
        };
        let v0 = arg2 / 4;
        let v1 = arg2 / 4;
        let v2 = arg2 - v0 - v1;
        if (arg0.total_shares > 0) {
            arg0.fees_per_share = arg0.fees_per_share + 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::div(v2, arg0.total_shares);
            arg0.maintainer_fees = arg0.maintainer_fees + v1;
            arg0.protocol_fees = arg0.protocol_fees + v0;
        } else {
            arg0.maintainer_fees = arg0.maintainer_fees + v1 + v2 / 2;
            arg0.protocol_fees = arg0.protocol_fees + v0 + v2 - v2 / 2;
        };
        let v3 = ProtocolFeesIncreasedEvent{
            margin_pool_id  : arg1,
            total_shares    : arg0.total_shares,
            referral_fees   : v2,
            maintainer_fees : v1,
            protocol_fees   : v0,
        };
        0x2::event::emit<ProtocolFeesIncreasedEvent>(v3);
    }

    public(friend) fun increase_shares(arg0: &mut ProtocolFees, arg1: 0x1::option::Option<0x2::object::ID>, arg2: u64) {
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, ReferralTracker>(&mut arg0.referrals, 0x1::option::destroy_with_default<0x2::object::ID>(arg1, 0x405abd3f4d6ce9230f2280060a7c93c930f1e2c9ebebb124298f4a1329ed26a6::margin_constants::default_referral()));
        update_unclaimed_fees(v0, arg0.fees_per_share);
        v0.current_shares = v0.current_shares + arg2;
        arg0.total_shares = arg0.total_shares + arg2;
    }

    public fun maintainer_fees(arg0: &ProtocolFees) : u64 {
        arg0.maintainer_fees
    }

    public(friend) fun mint_supply_referral(arg0: &mut ProtocolFees, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::new(arg1);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = ReferralTracker{
            current_shares      : 0,
            last_fees_per_share : arg0.fees_per_share,
            unclaimed_fees      : 0,
        };
        0x2::table::add<0x2::object::ID, ReferralTracker>(&mut arg0.referrals, v1, v2);
        let v3 = SupplyReferral{
            id    : v0,
            owner : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::share_object<SupplyReferral>(v3);
        v1
    }

    public fun referral_tracker(arg0: &ProtocolFees, arg1: 0x2::object::ID) : (u64, u64) {
        let v0 = 0x2::table::borrow<0x2::object::ID, ReferralTracker>(&arg0.referrals, arg1);
        (v0.current_shares, v0.unclaimed_fees + 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::mul(v0.current_shares, arg0.fees_per_share - v0.last_fees_per_share))
    }

    public fun total_shares(arg0: &ProtocolFees) : u64 {
        arg0.total_shares
    }

    fun update_unclaimed_fees(arg0: &mut ReferralTracker, arg1: u64) {
        arg0.unclaimed_fees = arg0.unclaimed_fees + 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::mul(arg0.current_shares, arg1 - arg0.last_fees_per_share);
        arg0.last_fees_per_share = arg1;
    }

    // decompiled from Move bytecode v6
}

