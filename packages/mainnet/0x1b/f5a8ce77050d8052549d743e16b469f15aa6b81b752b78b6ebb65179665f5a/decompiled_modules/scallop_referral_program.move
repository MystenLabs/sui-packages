module 0x1bf5a8ce77050d8052549d743e16b469f15aa6b81b752b78b6ebb65179665f5a::scallop_referral_program {
    struct REFERRAL_WITNESS has drop {
        dummy_field: bool,
    }

    struct VeScaReferralCfg has drop, store {
        ve_sca_key_id: 0x2::object::ID,
    }

    struct BorrowReferralEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        borrower: address,
        referrer_ve_sca_key_id: 0x2::object::ID,
        borrowed: u64,
        borrow_fee_discount: u64,
        referral_share: u64,
        referral_fee: u64,
        timestamp: u64,
    }

    public fun burn_ve_sca_referral_ticket<T0>(arg0: &0x1bf5a8ce77050d8052549d743e16b469f15aa6b81b752b78b6ebb65179665f5a::version::Version, arg1: 0x87ddec2984645dbbe2403a509cc6edf393a43acdba9b77d45da2bcbefcf733c1::borrow_referral::BorrowReferral<T0, REFERRAL_WITNESS>, arg2: &mut 0x1bf5a8ce77050d8052549d743e16b469f15aa6b81b752b78b6ebb65179665f5a::referral_revenue_pool::ReferralRevenuePool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x1bf5a8ce77050d8052549d743e16b469f15aa6b81b752b78b6ebb65179665f5a::version::assert_version(arg0);
        let v0 = 0x87ddec2984645dbbe2403a509cc6edf393a43acdba9b77d45da2bcbefcf733c1::borrow_referral::get_referral_cfg<T0, REFERRAL_WITNESS, VeScaReferralCfg>(&arg1).ve_sca_key_id;
        let v1 = REFERRAL_WITNESS{dummy_field: false};
        let v2 = 0x87ddec2984645dbbe2403a509cc6edf393a43acdba9b77d45da2bcbefcf733c1::borrow_referral::destroy_borrow_referral<T0, REFERRAL_WITNESS>(v1, arg1);
        let v3 = BorrowReferralEvent{
            coin_type              : 0x1::type_name::get<T0>(),
            borrower               : 0x2::tx_context::sender(arg4),
            referrer_ve_sca_key_id : v0,
            borrowed               : 0x87ddec2984645dbbe2403a509cc6edf393a43acdba9b77d45da2bcbefcf733c1::borrow_referral::borrowed<T0, REFERRAL_WITNESS>(&arg1),
            borrow_fee_discount    : 0x87ddec2984645dbbe2403a509cc6edf393a43acdba9b77d45da2bcbefcf733c1::borrow_referral::borrow_fee_discount<T0, REFERRAL_WITNESS>(&arg1),
            referral_share         : 0x87ddec2984645dbbe2403a509cc6edf393a43acdba9b77d45da2bcbefcf733c1::borrow_referral::referral_share<T0, REFERRAL_WITNESS>(&arg1),
            referral_fee           : 0x2::balance::value<T0>(&v2),
            timestamp              : 0x2::clock::timestamp_ms(arg3) / 1000,
        };
        0x2::event::emit<BorrowReferralEvent>(v3);
        0x1bf5a8ce77050d8052549d743e16b469f15aa6b81b752b78b6ebb65179665f5a::referral_revenue_pool::add_revenue_to_ve_sca_referrer<T0>(arg2, v0, v2, arg4);
    }

    public fun calc_borrow_fee_discount_and_referral_share_based_on_ve_sca(arg0: 0x2::object::ID, arg1: &0xb15b6e0cdd85afb5028bea851dd249405e734d800a259147bbc24980629723a4::ve_sca::VeScaTable, arg2: &0x1bf5a8ce77050d8052549d743e16b469f15aa6b81b752b78b6ebb65179665f5a::referral_tiers::ReferralTiers, arg3: &0x2::clock::Clock) : (u64, u64) {
        let (v0, v1) = 0x1bf5a8ce77050d8052549d743e16b469f15aa6b81b752b78b6ebb65179665f5a::referral_tiers::find_tier(arg2, 0xb15b6e0cdd85afb5028bea851dd249405e734d800a259147bbc24980629723a4::ve_sca::ve_sca_amount(arg0, arg1, arg3));
        (v1, v0)
    }

    public fun claim_ve_sca_referral_ticket<T0>(arg0: &0x1bf5a8ce77050d8052549d743e16b469f15aa6b81b752b78b6ebb65179665f5a::version::Version, arg1: &0xb15b6e0cdd85afb5028bea851dd249405e734d800a259147bbc24980629723a4::ve_sca::VeScaTable, arg2: &0x1bf5a8ce77050d8052549d743e16b469f15aa6b81b752b78b6ebb65179665f5a::referral_bindings::ReferralBindings, arg3: &0x87ddec2984645dbbe2403a509cc6edf393a43acdba9b77d45da2bcbefcf733c1::borrow_referral::AuthorizedWitnessList, arg4: &0x1bf5a8ce77050d8052549d743e16b469f15aa6b81b752b78b6ebb65179665f5a::referral_tiers::ReferralTiers, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x87ddec2984645dbbe2403a509cc6edf393a43acdba9b77d45da2bcbefcf733c1::borrow_referral::BorrowReferral<T0, REFERRAL_WITNESS> {
        0x1bf5a8ce77050d8052549d743e16b469f15aa6b81b752b78b6ebb65179665f5a::version::assert_version(arg0);
        let v0 = 0x1bf5a8ce77050d8052549d743e16b469f15aa6b81b752b78b6ebb65179665f5a::referral_bindings::get_binding(arg2, 0x2::tx_context::sender(arg6));
        assert!(0x1::option::is_some<0x2::object::ID>(&v0), 503);
        let v1 = 0x1::option::destroy_some<0x2::object::ID>(v0);
        let (v2, v3) = calc_borrow_fee_discount_and_referral_share_based_on_ve_sca(v1, arg1, arg4, arg5);
        let v4 = REFERRAL_WITNESS{dummy_field: false};
        let v5 = 0x87ddec2984645dbbe2403a509cc6edf393a43acdba9b77d45da2bcbefcf733c1::borrow_referral::create_borrow_referral<T0, REFERRAL_WITNESS>(v4, arg3, v2, v3, arg6);
        let v6 = VeScaReferralCfg{ve_sca_key_id: v1};
        0x87ddec2984645dbbe2403a509cc6edf393a43acdba9b77d45da2bcbefcf733c1::borrow_referral::add_referral_cfg<T0, REFERRAL_WITNESS, VeScaReferralCfg>(&mut v5, v6);
        v5
    }

    // decompiled from Move bytecode v6
}

