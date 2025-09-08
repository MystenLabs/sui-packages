module 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::airdrop_distribution {
    struct AirdropRegistry has key {
        id: 0x2::object::UID,
        airdrops: 0x2::table::Table<0x2::object::ID, Airdrop>,
        event_airdrops: 0x2::table::Table<0x2::object::ID, vector<0x2::object::ID>>,
        user_claims: 0x2::table::Table<address, vector<ClaimRecord>>,
        total_distributed: u64,
    }

    struct Airdrop has store {
        id: 0x2::object::ID,
        event_id: 0x2::object::ID,
        organizer: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
        pool: 0x2::balance::Balance<0x2::sui::SUI>,
        distribution_type: u8,
        eligibility_criteria: EligibilityCriteria,
        per_user_amount: u64,
        total_recipients: u64,
        claimed_count: u64,
        claims: 0x2::table::Table<address, ClaimInfo>,
        created_at: u64,
        expires_at: u64,
        active: bool,
    }

    struct EligibilityCriteria has copy, drop, store {
        require_attendance: bool,
        require_completion: bool,
        min_duration: u64,
        require_rating_submitted: bool,
    }

    struct ClaimInfo has copy, drop, store {
        amount: u64,
        claimed_at: u64,
        transaction_id: 0x2::object::ID,
    }

    struct ClaimRecord has copy, drop, store {
        airdrop_id: 0x2::object::ID,
        event_id: 0x2::object::ID,
        amount: u64,
        claimed_at: u64,
    }

    struct AirdropCreated has copy, drop {
        airdrop_id: 0x2::object::ID,
        event_id: 0x2::object::ID,
        total_amount: u64,
        distribution_type: u8,
        expires_at: u64,
    }

    struct AirdropClaimed has copy, drop {
        airdrop_id: 0x2::object::ID,
        claimer: address,
        amount: u64,
        claimed_at: u64,
    }

    struct AirdropCompleted has copy, drop {
        airdrop_id: 0x2::object::ID,
        total_claimed: u64,
        recipients: u64,
    }

    public fun batch_distribute(arg0: 0x2::object::ID, arg1: &0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::Event, arg2: vector<address>, arg3: &mut AirdropRegistry, arg4: &0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::attendance_verification::AttendanceRegistry, arg5: &0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::nft_minting::NFTRegistry, arg6: &0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::rating_reputation::RatingRegistry, arg7: &0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::ProfileRegistry, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x2::object::ID, Airdrop>(&arg3.airdrops, arg0), 3);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, Airdrop>(&mut arg3.airdrops, arg0);
        let v1 = 0x2::tx_context::sender(arg9);
        let v2 = 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::get_event_organizer(arg1);
        let v3 = 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::get_event_assignee(arg1);
        let v4 = if (v3 == 0x1::string::utf8(b"self")) {
            v2
        } else {
            0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::get_address_from_x(arg7, v3)
        };
        assert!(v4 == v1 || v2 == v1, 1);
        assert!(v0.active, 8);
        let v5 = 0x2::clock::timestamp_ms(arg8);
        assert!(v5 <= v0.expires_at, 6);
        let v6 = 0;
        while (v6 < 0x1::vector::length<address>(&arg2) && 0x2::balance::value<0x2::sui::SUI>(&v0.pool) > 0) {
            let v7 = *0x1::vector::borrow<address>(&arg2, v6);
            if (!0x2::table::contains<address, ClaimInfo>(&v0.claims, v7)) {
                if (verify_eligibility(v7, v0.event_id, &v0.eligibility_criteria, arg4, arg5, arg6)) {
                    let v8 = calculate_claim_amount(v7, v0, arg4);
                    if (v8 > 0 && 0x2::balance::value<0x2::sui::SUI>(&v0.pool) >= v8) {
                        let v9 = 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v0.pool, v8), arg9);
                        let v10 = ClaimInfo{
                            amount         : v8,
                            claimed_at     : v5,
                            transaction_id : 0x2::object::id<0x2::coin::Coin<0x2::sui::SUI>>(&v9),
                        };
                        0x2::table::add<address, ClaimInfo>(&mut v0.claims, v7, v10);
                        v0.claimed_count = v0.claimed_count + 1;
                        arg3.total_distributed = arg3.total_distributed + v8;
                        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v9, v7);
                        let v11 = AirdropClaimed{
                            airdrop_id : arg0,
                            claimer    : v7,
                            amount     : v8,
                            claimed_at : v5,
                        };
                        0x2::event::emit<AirdropClaimed>(v11);
                    };
                };
            };
            v6 = v6 + 1;
        };
    }

    fun calculate_claim_amount(arg0: address, arg1: &Airdrop, arg2: &0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::attendance_verification::AttendanceRegistry) : u64 {
        if (arg1.distribution_type == 0) {
            return arg1.per_user_amount
        };
        if (arg1.distribution_type == 1) {
            let (_, _, v2, v3) = 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::attendance_verification::get_attendance_status(arg0, arg1.event_id, arg2);
            if (v3 > v2) {
                return 0x2::balance::value<0x2::sui::SUI>(&arg1.pool) / arg1.total_recipients * ((v3 - v2) / 3600000 + 1)
            };
            return arg1.per_user_amount
        };
        if (arg1.distribution_type == 2) {
            let (_, v5, _, _) = 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::attendance_verification::get_attendance_status(arg0, arg1.event_id, arg2);
            if (v5 == 2) {
                return arg1.per_user_amount * 2
            };
            return arg1.per_user_amount
        };
        arg1.per_user_amount
    }

    public fun claim_airdrop(arg0: 0x2::object::ID, arg1: &mut AirdropRegistry, arg2: &0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::attendance_verification::AttendanceRegistry, arg3: &0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::nft_minting::NFTRegistry, arg4: &0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::rating_reputation::RatingRegistry, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        assert!(0x2::table::contains<0x2::object::ID, Airdrop>(&arg1.airdrops, arg0), 3);
        let v2 = 0x2::table::borrow_mut<0x2::object::ID, Airdrop>(&mut arg1.airdrops, arg0);
        assert!(v2.active, 8);
        assert!(v1 <= v2.expires_at, 6);
        assert!(!0x2::table::contains<address, ClaimInfo>(&v2.claims, v0), 5);
        assert!(verify_eligibility(v0, v2.event_id, &v2.eligibility_criteria, arg2, arg3, arg4), 4);
        let v3 = calculate_claim_amount(v0, v2, arg2);
        assert!(v3 > 0 && 0x2::balance::value<0x2::sui::SUI>(&v2.pool) >= v3, 2);
        let v4 = 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v2.pool, v3), arg6);
        let v5 = ClaimInfo{
            amount         : v3,
            claimed_at     : v1,
            transaction_id : 0x2::object::id<0x2::coin::Coin<0x2::sui::SUI>>(&v4),
        };
        0x2::table::add<address, ClaimInfo>(&mut v2.claims, v0, v5);
        v2.claimed_count = v2.claimed_count + 1;
        if (!0x2::table::contains<address, vector<ClaimRecord>>(&arg1.user_claims, v0)) {
            0x2::table::add<address, vector<ClaimRecord>>(&mut arg1.user_claims, v0, 0x1::vector::empty<ClaimRecord>());
        };
        let v6 = ClaimRecord{
            airdrop_id : arg0,
            event_id   : v2.event_id,
            amount     : v3,
            claimed_at : v1,
        };
        0x1::vector::push_back<ClaimRecord>(0x2::table::borrow_mut<address, vector<ClaimRecord>>(&mut arg1.user_claims, v0), v6);
        arg1.total_distributed = arg1.total_distributed + v3;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, v0);
        let v7 = AirdropClaimed{
            airdrop_id : arg0,
            claimer    : v0,
            amount     : v3,
            claimed_at : v1,
        };
        0x2::event::emit<AirdropClaimed>(v7);
        if (v2.claimed_count >= v2.total_recipients || 0x2::balance::value<0x2::sui::SUI>(&v2.pool) < v2.per_user_amount) {
            v2.active = false;
            let v8 = AirdropCompleted{
                airdrop_id    : arg0,
                total_claimed : arg1.total_distributed,
                recipients    : v2.claimed_count,
            };
            0x2::event::emit<AirdropCompleted>(v8);
        };
    }

    public fun create_airdrop(arg0: &0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::Event, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u8, arg5: bool, arg6: bool, arg7: u64, arg8: bool, arg9: u64, arg10: &mut AirdropRegistry, arg11: &0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::attendance_verification::AttendanceRegistry, arg12: &0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::ProfileRegistry, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::tx_context::sender(arg14);
        let v1 = 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::get_event_id(arg0);
        let v2 = 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::get_event_organizer(arg0);
        let v3 = 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::get_event_assignee(arg0);
        let v4 = if (v3 == 0x1::string::utf8(b"self")) {
            v2
        } else {
            0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::get_address_from_x(arg12, v3)
        };
        assert!(v4 == v0 || v2 == v0, 1);
        let v5 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(v5 > 0, 2);
        let v6 = 0x2::clock::timestamp_ms(arg13);
        let v7 = v6 + arg9 * 86400000;
        let (_, v9, _) = 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::attendance_verification::get_event_stats(v1, arg11);
        let v11 = if (arg6) {
            v9
        } else {
            0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::get_current_attendees(arg0)
        };
        assert!(v11 > 0, 7);
        let v12 = if (arg4 == 0) {
            v5 / v11
        } else {
            0
        };
        let v13 = 0x2::object::new(arg14);
        let v14 = 0x2::object::uid_to_inner(&v13);
        0x2::object::delete(v13);
        let v15 = EligibilityCriteria{
            require_attendance       : arg5,
            require_completion       : arg6,
            min_duration             : arg7,
            require_rating_submitted : arg8,
        };
        let v16 = Airdrop{
            id                   : v14,
            event_id             : v1,
            organizer            : v0,
            name                 : arg1,
            description          : arg2,
            pool                 : 0x2::coin::into_balance<0x2::sui::SUI>(arg3),
            distribution_type    : arg4,
            eligibility_criteria : v15,
            per_user_amount      : v12,
            total_recipients     : v11,
            claimed_count        : 0,
            claims               : 0x2::table::new<address, ClaimInfo>(arg14),
            created_at           : v6,
            expires_at           : v7,
            active               : true,
        };
        0x2::table::add<0x2::object::ID, Airdrop>(&mut arg10.airdrops, v14, v16);
        if (!0x2::table::contains<0x2::object::ID, vector<0x2::object::ID>>(&arg10.event_airdrops, v1)) {
            0x2::table::add<0x2::object::ID, vector<0x2::object::ID>>(&mut arg10.event_airdrops, v1, 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<0x2::object::ID, vector<0x2::object::ID>>(&mut arg10.event_airdrops, v1), v14);
        let v17 = AirdropCreated{
            airdrop_id        : v14,
            event_id          : v1,
            total_amount      : v5,
            distribution_type : arg4,
            expires_at        : v7,
        };
        0x2::event::emit<AirdropCreated>(v17);
        v14
    }

    public fun get_airdrop_details(arg0: 0x2::object::ID, arg1: &AirdropRegistry) : (0x2::object::ID, 0x1::string::String, u64, u64, u64, bool) {
        assert!(0x2::table::contains<0x2::object::ID, Airdrop>(&arg1.airdrops, arg0), 3);
        let v0 = 0x2::table::borrow<0x2::object::ID, Airdrop>(&arg1.airdrops, arg0);
        (v0.event_id, v0.name, 0x2::balance::value<0x2::sui::SUI>(&v0.pool), v0.claimed_count, v0.expires_at, v0.active)
    }

    public fun get_claim_status(arg0: address, arg1: 0x2::object::ID, arg2: &AirdropRegistry) : (bool, u64) {
        assert!(0x2::table::contains<0x2::object::ID, Airdrop>(&arg2.airdrops, arg1), 3);
        let v0 = 0x2::table::borrow<0x2::object::ID, Airdrop>(&arg2.airdrops, arg1);
        if (0x2::table::contains<address, ClaimInfo>(&v0.claims, arg0)) {
            (true, 0x2::table::borrow<address, ClaimInfo>(&v0.claims, arg0).amount)
        } else {
            (false, 0)
        }
    }

    public fun get_event_airdrops(arg0: 0x2::object::ID, arg1: &AirdropRegistry) : vector<0x2::object::ID> {
        if (!0x2::table::contains<0x2::object::ID, vector<0x2::object::ID>>(&arg1.event_airdrops, arg0)) {
            return 0x1::vector::empty<0x2::object::ID>()
        };
        *0x2::table::borrow<0x2::object::ID, vector<0x2::object::ID>>(&arg1.event_airdrops, arg0)
    }

    public fun get_user_claims(arg0: address, arg1: &AirdropRegistry) : vector<ClaimRecord> {
        if (!0x2::table::contains<address, vector<ClaimRecord>>(&arg1.user_claims, arg0)) {
            return 0x1::vector::empty<ClaimRecord>()
        };
        *0x2::table::borrow<address, vector<ClaimRecord>>(&arg1.user_claims, arg0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AirdropRegistry{
            id                : 0x2::object::new(arg0),
            airdrops          : 0x2::table::new<0x2::object::ID, Airdrop>(arg0),
            event_airdrops    : 0x2::table::new<0x2::object::ID, vector<0x2::object::ID>>(arg0),
            user_claims       : 0x2::table::new<address, vector<ClaimRecord>>(arg0),
            total_distributed : 0,
        };
        0x2::transfer::share_object<AirdropRegistry>(v0);
    }

    public fun is_user_eligible(arg0: address, arg1: 0x2::object::ID, arg2: &AirdropRegistry, arg3: &0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::attendance_verification::AttendanceRegistry, arg4: &0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::nft_minting::NFTRegistry, arg5: &0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::rating_reputation::RatingRegistry) : bool {
        assert!(0x2::table::contains<0x2::object::ID, Airdrop>(&arg2.airdrops, arg1), 3);
        let v0 = 0x2::table::borrow<0x2::object::ID, Airdrop>(&arg2.airdrops, arg1);
        verify_eligibility(arg0, v0.event_id, &v0.eligibility_criteria, arg3, arg4, arg5)
    }

    fun verify_eligibility(arg0: address, arg1: 0x2::object::ID, arg2: &EligibilityCriteria, arg3: &0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::attendance_verification::AttendanceRegistry, arg4: &0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::nft_minting::NFTRegistry, arg5: &0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::rating_reputation::RatingRegistry) : bool {
        if (arg2.require_attendance) {
            let (v0, v1, v2, v3) = 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::attendance_verification::get_attendance_status(arg0, arg1, arg3);
            if (!v0) {
                return false
            };
            if (arg2.require_completion && v1 != 2) {
                return false
            };
            if (arg2.min_duration > 0 && v3 > v2) {
                if (v3 - v2 < arg2.min_duration) {
                    return false
                };
            };
        };
        if (arg2.require_completion) {
            if (!0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::nft_minting::has_completion_nft(arg0, arg1, arg4)) {
                return false
            };
        };
        if (arg2.require_rating_submitted) {
            if (!0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::rating_reputation::has_user_rated(arg0, arg1, arg5)) {
                return false
            };
        };
        true
    }

    public fun withdraw_unclaimed(arg0: 0x2::object::ID, arg1: &0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::Event, arg2: &mut AirdropRegistry, arg3: &0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::ProfileRegistry, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x2::object::ID, Airdrop>(&arg2.airdrops, arg0), 3);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, Airdrop>(&mut arg2.airdrops, arg0);
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::get_event_organizer(arg1);
        let v3 = 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::get_event_assignee(arg1);
        let v4 = if (v3 == 0x1::string::utf8(b"self")) {
            v2
        } else {
            0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::get_address_from_x(arg3, v3)
        };
        assert!(v4 == v1 || v2 == v1, 1);
        assert!(0x2::clock::timestamp_ms(arg4) > v0.expires_at, 8);
        if (0x2::balance::value<0x2::sui::SUI>(&v0.pool) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut v0.pool), arg5), v0.organizer);
        };
        v0.active = false;
    }

    // decompiled from Move bytecode v6
}

