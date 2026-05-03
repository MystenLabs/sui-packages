module 0x1c00074e80bcb82298b8cb4f743af3f9423b057bfdfaea40e085f62960021f4e::proposal_sponsorship {
    struct Witness has drop {
        dummy_field: bool,
    }

    struct ProposalSponsored has copy, drop {
        proposal_id: 0x2::object::ID,
        dao_id: 0x2::object::ID,
        sponsor: address,
        sponsorship_types: vector<u8>,
        timestamp: u64,
    }

    fun calculate_twap_start_time<T0, T1>(arg0: &0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::Proposal<T0, T1>) : u64 {
        0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::get_trading_started_at<T0, T1>(arg0) + 0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::get_twap_start_delay<T0, T1>(arg0)
    }

    public fun can_sponsor_proposal<T0, T1>(arg0: &0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::Proposal<T0, T1>, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg2: address, arg3: &0x2::clock::Clock) : (bool, 0x1::string::String) {
        if (0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::get_dao_id<T0, T1>(arg0) != 0x2::object::id<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account>(arg1)) {
            return (false, 0x1::string::utf8(b"DAO mismatch"))
        };
        let v0 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::config<0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::FutarchyConfig>(arg1);
        let v1 = 0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::sponsorship_config(0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::dao_config(v0));
        if (0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::is_terminated(0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::dao_state(v0))) {
            return (false, 0x1::string::utf8(b"DAO is terminated"))
        };
        if (!0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::sponsorship_enabled(v1)) {
            return (false, 0x1::string::utf8(b"Sponsorship not enabled"))
        };
        if (0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::is_sponsored<T0, T1>(arg0)) {
            return (false, 0x1::string::utf8(b"Proposal already sponsored"))
        };
        if (0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::is_sponsor_quota_used<T0, T1>(arg0)) {
            return (false, 0x1::string::utf8(b"Sponsor quota already used for this proposal"))
        };
        let v2 = 0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::get_state<T0, T1>(arg0);
        if (v2 == 4) {
            return (false, 0x1::string::utf8(b"Proposal already finalized"))
        };
        if (v2 == 3) {
            return (false, 0x1::string::utf8(b"Proposal is awaiting execution"))
        };
        if (v2 == 2) {
            if (0x2::clock::timestamp_ms(arg3) >= calculate_twap_start_time<T0, T1>(arg0)) {
                return (false, 0x1::string::utf8(b"TWAP delay has passed"))
            };
        };
        let (v3, _) = 0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::check_sponsor_quota_available(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::config<0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::FutarchyConfig>(arg1), arg2, arg3);
        if (!v3) {
            return (false, 0x1::string::utf8(b"No sponsor quota available"))
        };
        (true, 0x1::string::utf8(b""))
    }

    public entry fun sponsor_proposal<T0, T1>(arg0: &mut 0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::Proposal<T0, T1>, arg1: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg2: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg3: &0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::sponsorship_auth::SponsorshipRegistry, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::get_dao_id<T0, T1>(arg0);
        let v2 = 0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::get_id<T0, T1>(arg0);
        assert!(v1 == 0x2::object::id<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account>(arg1), 6);
        0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::assert_not_terminated(0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::dao_state(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::config<0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::FutarchyConfig>(arg1)));
        assert!(!0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::is_sponsored<T0, T1>(arg0), 2);
        assert!(0x1::vector::length<u8>(&arg4) == 0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::get_num_outcomes<T0, T1>(arg0), 9);
        assert!(*0x1::vector::borrow<u8>(&arg4, 0) == 0, 8);
        let v3 = 0;
        let v4 = false;
        while (v3 < 0x1::vector::length<u8>(&arg4)) {
            let v5 = *0x1::vector::borrow<u8>(&arg4, v3);
            assert!(v5 <= 2, 8);
            if (v5 != 0) {
                v4 = true;
            };
            v3 = v3 + 1;
        };
        assert!(v4, 8);
        assert!(0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::sponsorship_enabled(0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::dao_config::sponsorship_config(0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::dao_config(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::config<0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::FutarchyConfig>(arg1)))), 1);
        assert!(0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::get_state<T0, T1>(arg0) != 4, 4);
        validate_sponsorship_timing<T0, T1>(arg0, arg5);
        if (!0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::is_sponsor_quota_used<T0, T1>(arg0)) {
            let v6 = Witness{dummy_field: false};
            let (v7, _) = 0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::futarchy_config::check_and_consume_sponsor_quota_from_account<Witness>(arg1, arg2, v1, v0, v2, arg5, arg6, v6);
            assert!(v7, 3);
            let v9 = Witness{dummy_field: false};
            0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::mark_sponsor_quota_used<T0, T1>(arg0, v0, 0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::sponsorship_auth::create<Witness>(arg3, v9, v2));
        };
        let v10 = Witness{dummy_field: false};
        0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::set_outcome_sponsorships<T0, T1>(arg0, arg4, 0xd515e9008496dd209ffb71caf0e5783073385cde00083c8a1437a32093aab95c::sponsorship_auth::create<Witness>(arg3, v10, v2));
        let v11 = ProposalSponsored{
            proposal_id       : v2,
            dao_id            : v1,
            sponsor           : v0,
            sponsorship_types : 0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::get_outcome_sponsorship_types<T0, T1>(arg0),
            timestamp         : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<ProposalSponsored>(v11);
    }

    fun validate_sponsorship_timing<T0, T1>(arg0: &0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::Proposal<T0, T1>, arg1: &0x2::clock::Clock) {
        let v0 = 0xa30cef6d80aca88816c94f508c36f9da780ef6b7c1f5f8abd212e40b95f48585::proposal::get_state<T0, T1>(arg0);
        if (v0 == 0 || v0 == 1) {
            return
        };
        assert!(v0 == 2, 4);
        assert!(0x2::clock::timestamp_ms(arg1) < calculate_twap_start_time<T0, T1>(arg0), 7);
    }

    // decompiled from Move bytecode v6
}

