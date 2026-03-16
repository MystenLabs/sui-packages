module 0xe8e29380d8c10fe72b8f0de410cf4255a0372ce5a8f1c4908e565464f40ded4a::proposal_sponsorship {
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

    fun calculate_twap_start_time<T0, T1>(arg0: &0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::Proposal<T0, T1>) : u64 {
        0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::get_market_initialized_at<T0, T1>(arg0) + 0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::get_review_period_ms<T0, T1>(arg0) + 0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::get_twap_start_delay<T0, T1>(arg0)
    }

    public fun can_sponsor_proposal<T0, T1>(arg0: &0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::Proposal<T0, T1>, arg1: &0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::Account, arg2: address, arg3: &0x2::clock::Clock) : (bool, 0x1::string::String) {
        if (0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::get_dao_id<T0, T1>(arg0) != 0x2::object::id<0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::Account>(arg1)) {
            return (false, 0x1::string::utf8(b"DAO mismatch"))
        };
        let v0 = 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::config<0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::futarchy_config::FutarchyConfig>(arg1);
        let v1 = 0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::dao_config::sponsorship_config(0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::futarchy_config::dao_config(v0));
        if (0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::futarchy_config::is_terminated(0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::futarchy_config::dao_state(v0))) {
            return (false, 0x1::string::utf8(b"DAO is terminated"))
        };
        if (!0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::dao_config::sponsorship_enabled(v1)) {
            return (false, 0x1::string::utf8(b"Sponsorship not enabled"))
        };
        if (0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::is_sponsored<T0, T1>(arg0)) {
            return (false, 0x1::string::utf8(b"Proposal already sponsored"))
        };
        if (0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::is_sponsor_quota_used<T0, T1>(arg0)) {
            return (false, 0x1::string::utf8(b"Sponsor quota already used for this proposal"))
        };
        let v2 = 0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::get_state<T0, T1>(arg0);
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
        let (v3, _) = 0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::futarchy_config::check_sponsor_quota_available(0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::config<0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::futarchy_config::FutarchyConfig>(arg1), arg2, arg3);
        if (!v3) {
            return (false, 0x1::string::utf8(b"No sponsor quota available"))
        };
        (true, 0x1::string::utf8(b""))
    }

    public entry fun sponsor_proposal<T0, T1>(arg0: &mut 0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::Proposal<T0, T1>, arg1: &mut 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::Account, arg2: &0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::package_registry::PackageRegistry, arg3: &0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::sponsorship_auth::SponsorshipRegistry, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::get_dao_id<T0, T1>(arg0);
        let v2 = 0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::get_id<T0, T1>(arg0);
        assert!(v1 == 0x2::object::id<0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::Account>(arg1), 6);
        0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::futarchy_config::assert_not_terminated(0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::futarchy_config::dao_state(0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::config<0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::futarchy_config::FutarchyConfig>(arg1)));
        assert!(!0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::is_sponsored<T0, T1>(arg0), 2);
        assert!(0x1::vector::length<u8>(&arg4) == 0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::get_num_outcomes<T0, T1>(arg0), 9);
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
        assert!(0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::dao_config::sponsorship_enabled(0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::dao_config::sponsorship_config(0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::futarchy_config::dao_config(0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::config<0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::futarchy_config::FutarchyConfig>(arg1)))), 1);
        assert!(0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::get_state<T0, T1>(arg0) != 4, 4);
        validate_sponsorship_timing<T0, T1>(arg0, arg5);
        let v6 = 0x7a6ec95f874af0292f624c7d8ad8a5fb95935f5e756a1d1c31530f779358eaa7::account::config_mut_authorized<0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::futarchy_config::FutarchyConfig>(arg1, arg2, 0xe8e29380d8c10fe72b8f0de410cf4255a0372ce5a8f1c4908e565464f40ded4a::futarchy_governance_version::current());
        if (!0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::is_sponsor_quota_used<T0, T1>(arg0)) {
            let (v7, _) = 0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::futarchy_config::check_sponsor_quota_available(v6, v0, arg5);
            assert!(v7, 3);
            0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::futarchy_config::consume_sponsor_quota(v6, v1, v0, v2, arg5, arg6);
            let v9 = Witness{dummy_field: false};
            0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::mark_sponsor_quota_used<T0, T1>(arg0, v0, 0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::sponsorship_auth::create<Witness>(arg3, v9, v2));
        };
        let v10 = Witness{dummy_field: false};
        0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::set_outcome_sponsorships<T0, T1>(arg0, arg4, 0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::sponsorship_auth::create<Witness>(arg3, v10, v2));
        let v11 = ProposalSponsored{
            proposal_id       : v2,
            dao_id            : v1,
            sponsor           : v0,
            sponsorship_types : 0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::get_outcome_sponsorship_types<T0, T1>(arg0),
            timestamp         : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<ProposalSponsored>(v11);
    }

    fun validate_sponsorship_timing<T0, T1>(arg0: &0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::Proposal<T0, T1>, arg1: &0x2::clock::Clock) {
        let v0 = 0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::proposal::get_state<T0, T1>(arg0);
        if (v0 == 0 || v0 == 1) {
            return
        };
        assert!(v0 == 2, 4);
        assert!(0x2::clock::timestamp_ms(arg1) < calculate_twap_start_time<T0, T1>(arg0), 7);
    }

    // decompiled from Move bytecode v6
}

