module 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::community_access {
    struct CommunityRegistry has key {
        id: 0x2::object::UID,
        communities: 0x2::table::Table<0x2::object::ID, Community>,
        event_communities: 0x2::table::Table<0x2::object::ID, 0x2::object::ID>,
        user_memberships: 0x2::table::Table<address, vector<Membership>>,
    }

    struct Community has store {
        id: 0x2::object::ID,
        event_id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        organizer: address,
        access_config: AccessConfiguration,
        members: 0x2::table::Table<address, MemberInfo>,
        member_count: u64,
        created_at: u64,
        active: bool,
        metadata_uri: 0x1::string::String,
        features: CommunityFeatures,
    }

    struct AccessConfiguration has copy, drop, store {
        access_type: u8,
        require_nft_held: bool,
        min_event_rating: u64,
        custom_requirements: vector<CustomRequirement>,
        expiry_duration: u64,
    }

    struct CustomRequirement has copy, drop, store {
        requirement_type: 0x1::string::String,
        value: u64,
    }

    struct CommunityFeatures has copy, drop, store {
        forum_enabled: bool,
        resource_sharing: bool,
        event_calendar: bool,
        member_directory: bool,
        governance_enabled: bool,
    }

    struct MemberInfo has copy, drop, store {
        joined_at: u64,
        access_expires_at: u64,
        access_type_used: u8,
        contribution_score: u64,
        last_active: u64,
    }

    struct Membership has copy, drop, store {
        community_id: 0x2::object::ID,
        event_id: 0x2::object::ID,
        joined_at: u64,
        expires_at: u64,
        active: bool,
    }

    struct CommunityAccessPass has store, key {
        id: 0x2::object::UID,
        community_id: 0x2::object::ID,
        member: address,
        issued_at: u64,
        expires_at: u64,
    }

    struct CommunityCreated has copy, drop {
        community_id: 0x2::object::ID,
        event_id: 0x2::object::ID,
        name: 0x1::string::String,
        access_type: u8,
    }

    struct MemberJoined has copy, drop {
        community_id: 0x2::object::ID,
        member: address,
        joined_at: u64,
        access_type_used: u8,
    }

    struct AccessGranted has copy, drop {
        community_id: 0x2::object::ID,
        member: address,
        pass_id: 0x2::object::ID,
        expires_at: u64,
    }

    struct MemberRemoved has copy, drop {
        community_id: 0x2::object::ID,
        member: address,
        reason: 0x1::string::String,
    }

    public fun add_custom_requirement(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: u64, arg3: &mut CommunityRegistry, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x2::object::ID, Community>(&arg3.communities, arg0), 2);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, Community>(&mut arg3.communities, arg0);
        assert!(v0.organizer == 0x2::tx_context::sender(arg4), 1);
        let v1 = CustomRequirement{
            requirement_type : arg1,
            value            : arg2,
        };
        0x1::vector::push_back<CustomRequirement>(&mut v0.access_config.custom_requirements, v1);
    }

    public fun create_community(arg0: &0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::Event, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u8, arg4: bool, arg5: u64, arg6: u64, arg7: 0x1::string::String, arg8: bool, arg9: bool, arg10: bool, arg11: bool, arg12: bool, arg13: &mut CommunityRegistry, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::tx_context::sender(arg15);
        let v1 = 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::get_event_id(arg0);
        assert!(0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::get_event_organizer(arg0) == v0, 1);
        assert!(!0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg13.event_communities, v1), 7);
        let v2 = 0x2::object::new(arg15);
        let v3 = 0x2::object::uid_to_inner(&v2);
        let v4 = AccessConfiguration{
            access_type         : arg3,
            require_nft_held    : arg4,
            min_event_rating    : arg5,
            custom_requirements : 0x1::vector::empty<CustomRequirement>(),
            expiry_duration     : arg6,
        };
        let v5 = CommunityFeatures{
            forum_enabled      : arg8,
            resource_sharing   : arg9,
            event_calendar     : arg10,
            member_directory   : arg11,
            governance_enabled : arg12,
        };
        let v6 = Community{
            id            : v3,
            event_id      : v1,
            name          : arg1,
            description   : arg2,
            organizer     : v0,
            access_config : v4,
            members       : 0x2::table::new<address, MemberInfo>(arg15),
            member_count  : 0,
            created_at    : 0x2::clock::timestamp_ms(arg14),
            active        : true,
            metadata_uri  : arg7,
            features      : v5,
        };
        0x2::table::add<0x2::object::ID, Community>(&mut arg13.communities, v3, v6);
        0x2::table::add<0x2::object::ID, 0x2::object::ID>(&mut arg13.event_communities, v1, v3);
        let v7 = CommunityCreated{
            community_id : v3,
            event_id     : v1,
            name         : arg1,
            access_type  : arg3,
        };
        0x2::event::emit<CommunityCreated>(v7);
        0x2::object::delete(v2);
        v3
    }

    public fun get_access_configuration(arg0: 0x2::object::ID, arg1: &CommunityRegistry) : (u8, bool, u64, u64) {
        assert!(0x2::table::contains<0x2::object::ID, Community>(&arg1.communities, arg0), 2);
        let v0 = &0x2::table::borrow<0x2::object::ID, Community>(&arg1.communities, arg0).access_config;
        (v0.access_type, v0.require_nft_held, v0.min_event_rating, v0.expiry_duration)
    }

    public fun get_community_details(arg0: 0x2::object::ID, arg1: &CommunityRegistry) : (0x1::string::String, 0x1::string::String, u64, bool, u8) {
        assert!(0x2::table::contains<0x2::object::ID, Community>(&arg1.communities, arg0), 2);
        let v0 = 0x2::table::borrow<0x2::object::ID, Community>(&arg1.communities, arg0);
        (v0.name, v0.description, v0.member_count, v0.active, v0.access_config.access_type)
    }

    public fun get_community_event_id(arg0: 0x2::object::ID, arg1: &CommunityRegistry) : 0x2::object::ID {
        assert!(0x2::table::contains<0x2::object::ID, Community>(&arg1.communities, arg0), 2);
        0x2::table::borrow<0x2::object::ID, Community>(&arg1.communities, arg0).event_id
    }

    public fun get_community_features(arg0: 0x2::object::ID, arg1: &CommunityRegistry) : CommunityFeatures {
        assert!(0x2::table::contains<0x2::object::ID, Community>(&arg1.communities, arg0), 2);
        0x2::table::borrow<0x2::object::ID, Community>(&arg1.communities, arg0).features
    }

    public fun get_community_organizer(arg0: 0x2::object::ID, arg1: &CommunityRegistry) : address {
        assert!(0x2::table::contains<0x2::object::ID, Community>(&arg1.communities, arg0), 2);
        0x2::table::borrow<0x2::object::ID, Community>(&arg1.communities, arg0).organizer
    }

    public fun get_event_calendar_enabled(arg0: &CommunityFeatures) : bool {
        arg0.event_calendar
    }

    public fun get_forum_enabled(arg0: &CommunityFeatures) : bool {
        arg0.forum_enabled
    }

    public fun get_governance_enabled(arg0: &CommunityFeatures) : bool {
        arg0.governance_enabled
    }

    public fun get_member_directory_enabled(arg0: &CommunityFeatures) : bool {
        arg0.member_directory
    }

    public fun get_member_info(arg0: 0x2::object::ID, arg1: address, arg2: &CommunityRegistry) : (u64, u64, u64, u64) {
        assert!(0x2::table::contains<0x2::object::ID, Community>(&arg2.communities, arg0), 2);
        let v0 = 0x2::table::borrow<0x2::object::ID, Community>(&arg2.communities, arg0);
        assert!(0x2::table::contains<address, MemberInfo>(&v0.members, arg1), 5);
        let v1 = 0x2::table::borrow<address, MemberInfo>(&v0.members, arg1);
        (v1.joined_at, v1.access_expires_at, v1.contribution_score, v1.last_active)
    }

    public fun get_resource_sharing_enabled(arg0: &CommunityFeatures) : bool {
        arg0.resource_sharing
    }

    public fun get_user_memberships(arg0: address, arg1: &CommunityRegistry) : vector<Membership> {
        if (!0x2::table::contains<address, vector<Membership>>(&arg1.user_memberships, arg0)) {
            return 0x1::vector::empty<Membership>()
        };
        *0x2::table::borrow<address, vector<Membership>>(&arg1.user_memberships, arg0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CommunityRegistry{
            id                : 0x2::object::new(arg0),
            communities       : 0x2::table::new<0x2::object::ID, Community>(arg0),
            event_communities : 0x2::table::new<0x2::object::ID, 0x2::object::ID>(arg0),
            user_memberships  : 0x2::table::new<address, vector<Membership>>(arg0),
        };
        0x2::transfer::share_object<CommunityRegistry>(v0);
    }

    public fun is_member(arg0: 0x2::object::ID, arg1: address, arg2: &CommunityRegistry) : bool {
        if (!0x2::table::contains<0x2::object::ID, Community>(&arg2.communities, arg0)) {
            return false
        };
        0x2::table::contains<address, MemberInfo>(&0x2::table::borrow<0x2::object::ID, Community>(&arg2.communities, arg0).members, arg1)
    }

    public fun remove_member(arg0: 0x2::object::ID, arg1: address, arg2: 0x1::string::String, arg3: &mut CommunityRegistry, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x2::object::ID, Community>(&arg3.communities, arg0), 2);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, Community>(&mut arg3.communities, arg0);
        assert!(v0.organizer == 0x2::tx_context::sender(arg4), 1);
        assert!(0x2::table::contains<address, MemberInfo>(&v0.members, arg1), 5);
        0x2::table::remove<address, MemberInfo>(&mut v0.members, arg1);
        v0.member_count = v0.member_count - 1;
        if (0x2::table::contains<address, vector<Membership>>(&arg3.user_memberships, arg1)) {
            let v1 = 0x2::table::borrow_mut<address, vector<Membership>>(&mut arg3.user_memberships, arg1);
            let v2 = 0;
            while (v2 < 0x1::vector::length<Membership>(v1)) {
                let v3 = 0x1::vector::borrow_mut<Membership>(v1, v2);
                if (v3.community_id == arg0) {
                    v3.active = false;
                    break
                };
                v2 = v2 + 1;
            };
        };
        let v4 = MemberRemoved{
            community_id : arg0,
            member       : arg1,
            reason       : arg2,
        };
        0x2::event::emit<MemberRemoved>(v4);
    }

    public fun request_access(arg0: 0x2::object::ID, arg1: &mut CommunityRegistry, arg2: &0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::nft_minting::NFTRegistry, arg3: &0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::rating_reputation::RatingRegistry, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : CommunityAccessPass {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x2::table::contains<0x2::object::ID, Community>(&arg1.communities, arg0), 2);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, Community>(&mut arg1.communities, arg0);
        assert!(v1.active, 6);
        assert!(!0x2::table::contains<address, MemberInfo>(&v1.members, v0), 3);
        assert!(verify_nft_eligibility(v0, v1.event_id, &v1.access_config, arg2, arg3), 4);
        let v2 = 0x2::clock::timestamp_ms(arg4);
        let v3 = if (v1.access_config.expiry_duration > 0) {
            v2 + v1.access_config.expiry_duration
        } else {
            0
        };
        let v4 = MemberInfo{
            joined_at          : v2,
            access_expires_at  : v3,
            access_type_used   : v1.access_config.access_type,
            contribution_score : 0,
            last_active        : v2,
        };
        0x2::table::add<address, MemberInfo>(&mut v1.members, v0, v4);
        v1.member_count = v1.member_count + 1;
        if (!0x2::table::contains<address, vector<Membership>>(&arg1.user_memberships, v0)) {
            0x2::table::add<address, vector<Membership>>(&mut arg1.user_memberships, v0, 0x1::vector::empty<Membership>());
        };
        let v5 = Membership{
            community_id : arg0,
            event_id     : v1.event_id,
            joined_at    : v2,
            expires_at   : v3,
            active       : true,
        };
        0x1::vector::push_back<Membership>(0x2::table::borrow_mut<address, vector<Membership>>(&mut arg1.user_memberships, v0), v5);
        let v6 = CommunityAccessPass{
            id           : 0x2::object::new(arg5),
            community_id : arg0,
            member       : v0,
            issued_at    : v2,
            expires_at   : v3,
        };
        let v7 = MemberJoined{
            community_id     : arg0,
            member           : v0,
            joined_at        : v2,
            access_type_used : v1.access_config.access_type,
        };
        0x2::event::emit<MemberJoined>(v7);
        let v8 = AccessGranted{
            community_id : arg0,
            member       : v0,
            pass_id      : 0x2::object::id<CommunityAccessPass>(&v6),
            expires_at   : v3,
        };
        0x2::event::emit<AccessGranted>(v8);
        v6
    }

    public fun update_contribution_score(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: &mut CommunityRegistry) {
        assert!(0x2::table::contains<0x2::object::ID, Community>(&arg3.communities, arg0), 2);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, Community>(&mut arg3.communities, arg0);
        assert!(0x2::table::contains<address, MemberInfo>(&v0.members, arg1), 5);
        let v1 = 0x2::table::borrow_mut<address, MemberInfo>(&mut v0.members, arg1);
        v1.contribution_score = v1.contribution_score + arg2;
    }

    public fun update_member_activity(arg0: 0x2::object::ID, arg1: &mut CommunityRegistry, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<0x2::object::ID, Community>(&arg1.communities, arg0), 2);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, Community>(&mut arg1.communities, arg0);
        assert!(0x2::table::contains<address, MemberInfo>(&v1.members, v0), 5);
        0x2::table::borrow_mut<address, MemberInfo>(&mut v1.members, v0).last_active = 0x2::clock::timestamp_ms(arg2);
    }

    public fun verify_access(arg0: &CommunityAccessPass, arg1: &CommunityRegistry, arg2: &0x2::clock::Clock) : bool {
        let v0 = arg0.community_id;
        let v1 = arg0.member;
        if (!0x2::table::contains<0x2::object::ID, Community>(&arg1.communities, v0)) {
            return false
        };
        let v2 = 0x2::table::borrow<0x2::object::ID, Community>(&arg1.communities, v0);
        if (!v2.active || !0x2::table::contains<address, MemberInfo>(&v2.members, v1)) {
            return false
        };
        let v3 = 0x2::table::borrow<address, MemberInfo>(&v2.members, v1);
        if (v3.access_expires_at > 0 && 0x2::clock::timestamp_ms(arg2) > v3.access_expires_at) {
            return false
        };
        true
    }

    fun verify_nft_eligibility(arg0: address, arg1: 0x2::object::ID, arg2: &AccessConfiguration, arg3: &0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::nft_minting::NFTRegistry, arg4: &0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::rating_reputation::RatingRegistry) : bool {
        if (arg2.min_event_rating > 0) {
            if (!0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::rating_reputation::has_user_rated(arg0, arg1, arg4)) {
                return false
            };
            let (v0, _, _) = 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::rating_reputation::get_user_rating(arg0, arg1, arg4);
            if (v0 < arg2.min_event_rating) {
                return false
            };
        };
        arg2.require_nft_held && (arg2.access_type == 0 && 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::nft_minting::has_proof_of_attendance(arg0, arg1, arg3) || arg2.access_type == 1 && 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::nft_minting::has_completion_nft(arg0, arg1, arg3) || arg2.access_type == 2 && (0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::nft_minting::has_proof_of_attendance(arg0, arg1, arg3) || 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::nft_minting::has_completion_nft(arg0, arg1, arg3))) || true
    }

    // decompiled from Move bytecode v6
}

