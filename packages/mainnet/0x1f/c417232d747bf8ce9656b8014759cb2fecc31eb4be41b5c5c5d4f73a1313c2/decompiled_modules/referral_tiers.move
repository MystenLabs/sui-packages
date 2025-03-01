module 0x5658d4bf5ddcba27e4337b4262108b3ad1716643cac8c2054ac341538adc72ec::referral_tiers {
    struct TierData has copy, drop, store {
        referral_share: u64,
        borrow_fee_discount: u64,
    }

    struct ReferralTiers has key {
        id: 0x2::object::UID,
        tier_table: 0x2::table::Table<u64, TierData>,
        ve_sca_tiers: 0x5658d4bf5ddcba27e4337b4262108b3ad1716643cac8c2054ac341538adc72ec::asc_u64_sorted_list::AscU64SortedList,
    }

    public(friend) fun add_tier(arg0: &mut ReferralTiers, arg1: u64, arg2: u64, arg3: u64) {
        assert!(0x2::table::contains<u64, TierData>(&arg0.tier_table, arg1) == false, 601);
        let v0 = TierData{
            referral_share      : arg2,
            borrow_fee_discount : arg3,
        };
        0x2::table::add<u64, TierData>(&mut arg0.tier_table, arg1, v0);
        0x5658d4bf5ddcba27e4337b4262108b3ad1716643cac8c2054ac341538adc72ec::asc_u64_sorted_list::insert(&mut arg0.ve_sca_tiers, arg1);
    }

    public fun find_tier(arg0: &ReferralTiers, arg1: u64) : (u64, u64) {
        let v0 = 0x2::table::borrow<u64, TierData>(&arg0.tier_table, 0x5658d4bf5ddcba27e4337b4262108b3ad1716643cac8c2054ac341538adc72ec::asc_u64_sorted_list::find_nearest_smaller_or_equal_value(&arg0.ve_sca_tiers, arg1));
        (v0.referral_share, v0.borrow_fee_discount)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ReferralTiers{
            id           : 0x2::object::new(arg0),
            tier_table   : 0x2::table::new<u64, TierData>(arg0),
            ve_sca_tiers : 0x5658d4bf5ddcba27e4337b4262108b3ad1716643cac8c2054ac341538adc72ec::asc_u64_sorted_list::empty(),
        };
        0x2::transfer::share_object<ReferralTiers>(v0);
    }

    public(friend) fun remove_tier(arg0: &mut ReferralTiers, arg1: u64) : (u64, u64) {
        assert!(0x2::table::contains<u64, TierData>(&arg0.tier_table, arg1), 602);
        let v0 = 0x2::table::remove<u64, TierData>(&mut arg0.tier_table, arg1);
        0x5658d4bf5ddcba27e4337b4262108b3ad1716643cac8c2054ac341538adc72ec::asc_u64_sorted_list::remove(&mut arg0.ve_sca_tiers, arg1);
        (v0.referral_share, v0.borrow_fee_discount)
    }

    // decompiled from Move bytecode v6
}

