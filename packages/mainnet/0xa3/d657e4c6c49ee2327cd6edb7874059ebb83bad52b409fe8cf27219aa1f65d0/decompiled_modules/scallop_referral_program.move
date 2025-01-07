module 0xa5c82ada6976597076d2ef0c8a4fb18b84ea40b6b8d3c30f49b4c27f6e022c1e::scallop_referral_program {
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
    }

    public fun burn_ve_sca_referral_ticket<T0>(arg0: 0x87ddec2984645dbbe2403a509cc6edf393a43acdba9b77d45da2bcbefcf733c1::borrow_referral::BorrowReferral<T0, REFERRAL_WITNESS>, arg1: &mut 0xa5c82ada6976597076d2ef0c8a4fb18b84ea40b6b8d3c30f49b4c27f6e022c1e::referral_revenue_pool::ReferralRevenuePool, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x87ddec2984645dbbe2403a509cc6edf393a43acdba9b77d45da2bcbefcf733c1::borrow_referral::get_referral_cfg<T0, REFERRAL_WITNESS, VeScaReferralCfg>(&arg0).ve_sca_key_id;
        let v1 = REFERRAL_WITNESS{dummy_field: false};
        let v2 = 0x87ddec2984645dbbe2403a509cc6edf393a43acdba9b77d45da2bcbefcf733c1::borrow_referral::destroy_borrow_referral<T0, REFERRAL_WITNESS>(v1, arg0);
        let v3 = BorrowReferralEvent{
            coin_type              : 0x1::type_name::get<T0>(),
            borrower               : 0x2::tx_context::sender(arg2),
            referrer_ve_sca_key_id : v0,
            borrowed               : 0x87ddec2984645dbbe2403a509cc6edf393a43acdba9b77d45da2bcbefcf733c1::borrow_referral::borrowed<T0, REFERRAL_WITNESS>(&arg0),
            borrow_fee_discount    : 0x87ddec2984645dbbe2403a509cc6edf393a43acdba9b77d45da2bcbefcf733c1::borrow_referral::borrow_fee_discount<T0, REFERRAL_WITNESS>(&arg0),
            referral_share         : 0x87ddec2984645dbbe2403a509cc6edf393a43acdba9b77d45da2bcbefcf733c1::borrow_referral::referral_share<T0, REFERRAL_WITNESS>(&arg0),
            referral_fee           : 0x2::balance::value<T0>(&v2),
        };
        0x2::event::emit<BorrowReferralEvent>(v3);
        0xa5c82ada6976597076d2ef0c8a4fb18b84ea40b6b8d3c30f49b4c27f6e022c1e::referral_revenue_pool::add_revenue_to_ve_sca_referrer<T0>(arg1, v0, v2, arg2);
    }

    public fun calc_borrow_fee_discount_and_referral_share_based_on_ve_sca(arg0: 0x2::object::ID, arg1: &0xb15b6e0cdd85afb5028bea851dd249405e734d800a259147bbc24980629723a4::ve_sca::VeScaTable, arg2: &0x2::clock::Clock) : (u64, u64) {
        let v0 = 0xb15b6e0cdd85afb5028bea851dd249405e734d800a259147bbc24980629723a4::ve_sca::ve_sca_amount(arg0, arg1, arg2);
        if (v0 >= 1000000) {
            return (10, 50)
        };
        if (v0 >= 100000) {
            return (10, 40)
        };
        if (v0 >= 10000) {
            return (10, 30)
        };
        if (v0 >= 1000) {
            return (10, 20)
        };
        if (v0 >= 100) {
            return (10, 15)
        };
        (10, 10)
    }

    public fun claim_ve_sca_referral_ticket<T0>(arg0: &0xb15b6e0cdd85afb5028bea851dd249405e734d800a259147bbc24980629723a4::ve_sca::VeScaTable, arg1: &0xa5c82ada6976597076d2ef0c8a4fb18b84ea40b6b8d3c30f49b4c27f6e022c1e::referral_bindings::ReferralBindings, arg2: &0x87ddec2984645dbbe2403a509cc6edf393a43acdba9b77d45da2bcbefcf733c1::borrow_referral::AuthorizedWitnessList, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x87ddec2984645dbbe2403a509cc6edf393a43acdba9b77d45da2bcbefcf733c1::borrow_referral::BorrowReferral<T0, REFERRAL_WITNESS> {
        let v0 = 0xa5c82ada6976597076d2ef0c8a4fb18b84ea40b6b8d3c30f49b4c27f6e022c1e::referral_bindings::get_binding(arg1, 0x2::tx_context::sender(arg4));
        assert!(0x1::option::is_some<0x2::object::ID>(&v0), 503);
        let v1 = 0x1::option::destroy_some<0x2::object::ID>(v0);
        let (v2, v3) = calc_borrow_fee_discount_and_referral_share_based_on_ve_sca(v1, arg0, arg3);
        let v4 = REFERRAL_WITNESS{dummy_field: false};
        let v5 = 0x87ddec2984645dbbe2403a509cc6edf393a43acdba9b77d45da2bcbefcf733c1::borrow_referral::create_borrow_referral<T0, REFERRAL_WITNESS>(v4, arg2, v2, v3, arg4);
        let v6 = VeScaReferralCfg{ve_sca_key_id: v1};
        0x87ddec2984645dbbe2403a509cc6edf393a43acdba9b77d45da2bcbefcf733c1::borrow_referral::add_referral_cfg<T0, REFERRAL_WITNESS, VeScaReferralCfg>(&mut v5, v6);
        v5
    }

    // decompiled from Move bytecode v6
}

