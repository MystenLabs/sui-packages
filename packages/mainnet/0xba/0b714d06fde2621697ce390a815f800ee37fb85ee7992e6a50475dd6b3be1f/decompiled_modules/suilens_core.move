module 0xba0b714d06fde2621697ce390a815f800ee37fb85ee7992e6a50475dd6b3be1f::suilens_core {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct GlobalRegistry has key {
        id: 0x2::object::UID,
        events: 0x2::table::Table<0x2::object::ID, Event>,
        user_profiles: 0x2::table::Table<address, UserProfile>,
        event_counter: u64,
        total_users: u64,
        platform_fee_rate: u64,
        platform_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        attendance_records: 0x2::table::Table<0x2::object::ID, 0x2::vec_set::VecSet<address>>,
        event_waitlists: 0x2::table::Table<0x2::object::ID, 0x2::vec_set::VecSet<address>>,
        registrations: 0x2::table::Table<0x2::object::ID, EventRegistration>,
        user_registrations: 0x2::table::Table<address, 0x2::vec_set::VecSet<0x2::object::ID>>,
    }

    struct UserProfile has store, key {
        id: 0x2::object::UID,
        wallet_address: address,
        username: 0x1::string::String,
        bio: 0x1::string::String,
        avatar_url: 0x1::string::String,
        social_links: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        events_created: 0x2::vec_set::VecSet<0x2::object::ID>,
        events_attended: 0x2::vec_set::VecSet<0x2::object::ID>,
        communities_joined: 0x2::vec_set::VecSet<0x2::object::ID>,
        reputation_score: u64,
        created_at: u64,
        updated_at: u64,
    }

    struct Event has store, key {
        id: 0x2::object::UID,
        creator: address,
        title: 0x1::string::String,
        description: 0x1::string::String,
        banner_url: 0x1::string::String,
        nft_image_url: 0x1::string::String,
        poap_image_url: 0x1::string::String,
        start_date: u64,
        end_date: u64,
        location: 0x1::string::String,
        category: 0x1::string::String,
        capacity: 0x1::option::Option<u64>,
        ticket_price: u64,
        is_free: bool,
        requires_approval: bool,
        is_private: bool,
        is_active: bool,
        attendees: 0x2::vec_set::VecSet<address>,
        approved_attendees: 0x2::vec_set::VecSet<address>,
        pending_approvals: 0x2::vec_set::VecSet<address>,
        event_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        metadata: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        created_at: u64,
        updated_at: u64,
    }

    struct EventRegistration has store, key {
        id: 0x2::object::UID,
        event_id: 0x2::object::ID,
        attendee: address,
        payment_amount: u64,
        registration_date: u64,
        status: u8,
        approval_required: bool,
        ticket_code: 0x1::string::String,
    }

    struct EventNFT has store, key {
        id: 0x2::object::UID,
        event_id: 0x2::object::ID,
        event_name: 0x1::string::String,
        event_image: 0x1::string::String,
        event_date: u64,
        event_location: 0x1::string::String,
        minted_by: address,
        minted_at: u64,
        edition_number: u64,
    }

    struct EventCreated has copy, drop {
        event_id: 0x2::object::ID,
        creator: address,
        title: 0x1::string::String,
        start_date: u64,
        is_free: bool,
    }

    struct UserRegistered has copy, drop {
        event_id: 0x2::object::ID,
        attendee: address,
        payment_amount: u64,
        requires_approval: bool,
    }

    struct RegistrationApproved has copy, drop {
        event_id: 0x2::object::ID,
        attendee: address,
        approved_by: address,
    }

    struct ProfileCreated has copy, drop {
        user_address: address,
        username: 0x1::string::String,
    }

    struct EventCancelled has copy, drop {
        event_id: 0x2::object::ID,
        creator: address,
        refund_amount: u64,
    }

    struct EventFundsWithdrawn has copy, drop {
        event_id: 0x2::object::ID,
        creator: address,
        amount: u64,
        platform_fee: u64,
    }

    struct AttendanceMarked has copy, drop {
        event_id: 0x2::object::ID,
        attendee: address,
        checked_in_by: address,
        check_in_time: u64,
    }

    struct BatchAttendanceMarked has copy, drop {
        event_id: 0x2::object::ID,
        count: u64,
        checked_in_by: address,
    }

    struct JoinedWaitlist has copy, drop {
        event_id: 0x2::object::ID,
        user: address,
        position: u64,
    }

    struct WaitlistProcessed has copy, drop {
        event_id: 0x2::object::ID,
        user: address,
    }

    struct BatchRegistrationsApproved has copy, drop {
        event_id: 0x2::object::ID,
        approver: address,
        count: u64,
    }

    struct EventNFTMinted has copy, drop {
        nft_id: 0x2::object::ID,
        event_id: 0x2::object::ID,
        minter: address,
        edition: u64,
    }

    struct SUILENS_CORE has drop {
        dummy_field: bool,
    }

    public fun add_social_link(arg0: &mut GlobalRegistry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, UserProfile>(&arg0.user_profiles, v0), 7);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut 0x2::table::borrow_mut<address, UserProfile>(&mut arg0.user_profiles, v0).social_links, arg1, arg2);
    }

    public(friend) fun add_user_community(arg0: &mut GlobalRegistry, arg1: address, arg2: 0x2::object::ID) {
        0x2::vec_set::insert<0x2::object::ID>(&mut 0x2::table::borrow_mut<address, UserProfile>(&mut arg0.user_profiles, arg1).communities_joined, arg2);
    }

    public fun approve_registration(arg0: &mut GlobalRegistry, arg1: 0x2::object::ID, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<0x2::object::ID, Event>(&arg0.events, arg1), 1);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, Event>(&mut arg0.events, arg1);
        assert!(v1.creator == v0, 0);
        assert!(0x2::vec_set::contains<address>(&v1.pending_approvals, &arg2), 8);
        0x2::vec_set::remove<address>(&mut v1.pending_approvals, &arg2);
        0x2::vec_set::insert<address>(&mut v1.attendees, arg2);
        0x2::vec_set::insert<address>(&mut v1.approved_attendees, arg2);
        0x2::vec_set::insert<0x2::object::ID>(&mut 0x2::table::borrow_mut<address, UserProfile>(&mut arg0.user_profiles, arg2).events_attended, arg1);
        let v2 = RegistrationApproved{
            event_id    : arg1,
            attendee    : arg2,
            approved_by : v0,
        };
        0x2::event::emit<RegistrationApproved>(v2);
    }

    public fun batch_approve_registrations(arg0: &mut GlobalRegistry, arg1: 0x2::object::ID, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<0x2::object::ID, Event>(&arg0.events, arg1), 1);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, Event>(&mut arg0.events, arg1);
        assert!(v1.creator == v0, 0);
        let v2 = 0;
        let v3 = 0;
        while (v2 < 0x1::vector::length<address>(&arg2)) {
            let v4 = *0x1::vector::borrow<address>(&arg2, v2);
            if (0x2::vec_set::contains<address>(&v1.pending_approvals, &v4)) {
                0x2::vec_set::remove<address>(&mut v1.pending_approvals, &v4);
                0x2::vec_set::insert<address>(&mut v1.attendees, v4);
                0x2::vec_set::insert<address>(&mut v1.approved_attendees, v4);
                0x2::vec_set::insert<0x2::object::ID>(&mut 0x2::table::borrow_mut<address, UserProfile>(&mut arg0.user_profiles, v4).events_attended, arg1);
                v3 = v3 + 1;
            };
            v2 = v2 + 1;
        };
        let v5 = BatchRegistrationsApproved{
            event_id : arg1,
            approver : v0,
            count    : v3,
        };
        0x2::event::emit<BatchRegistrationsApproved>(v5);
    }

    public fun batch_mark_attendance(arg0: &mut GlobalRegistry, arg1: 0x2::object::ID, arg2: vector<address>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(0x2::table::contains<0x2::object::ID, Event>(&arg0.events, arg1), 1);
        let v2 = 0x2::table::borrow<0x2::object::ID, Event>(&arg0.events, arg1);
        assert!(v2.creator == v0, 0);
        assert!(v1 >= v2.start_date && v1 <= v2.end_date, 6);
        if (!0x2::table::contains<0x2::object::ID, 0x2::vec_set::VecSet<address>>(&arg0.attendance_records, arg1)) {
            0x2::table::add<0x2::object::ID, 0x2::vec_set::VecSet<address>>(&mut arg0.attendance_records, arg1, 0x2::vec_set::empty<address>());
        };
        let v3 = 0x2::table::borrow_mut<0x2::object::ID, 0x2::vec_set::VecSet<address>>(&mut arg0.attendance_records, arg1);
        let v4 = 0;
        let v5 = 0x1::vector::length<address>(&arg2);
        while (v4 < v5) {
            let v6 = *0x1::vector::borrow<address>(&arg2, v4);
            if (0x2::vec_set::contains<address>(&v2.approved_attendees, &v6) && !0x2::vec_set::contains<address>(v3, &v6)) {
                0x2::vec_set::insert<address>(v3, v6);
            };
            v4 = v4 + 1;
        };
        let v7 = BatchAttendanceMarked{
            event_id      : arg1,
            count         : v5,
            checked_in_by : v0,
        };
        0x2::event::emit<BatchAttendanceMarked>(v7);
    }

    public fun cancel_event(arg0: &mut GlobalRegistry, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<0x2::object::ID, Event>(&arg0.events, arg1), 1);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, Event>(&mut arg0.events, arg1);
        assert!(v1.creator == v0, 0);
        v1.is_active = false;
        let v2 = EventCancelled{
            event_id      : arg1,
            creator       : v0,
            refund_amount : 0x2::balance::value<0x2::sui::SUI>(&v1.event_balance),
        };
        0x2::event::emit<EventCancelled>(v2);
    }

    public fun cancel_registration(arg0: &mut GlobalRegistry, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<0x2::object::ID, Event>(&arg0.events, arg1), 1);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, Event>(&mut arg0.events, arg1);
        let v2 = 0x2::vec_set::contains<address>(&v1.attendees, &v0);
        let v3 = 0x2::vec_set::contains<address>(&v1.pending_approvals, &v0);
        assert!(v2 || v3, 9);
        if (v2) {
            0x2::vec_set::remove<address>(&mut v1.attendees, &v0);
            0x2::vec_set::remove<address>(&mut v1.approved_attendees, &v0);
        };
        if (v3) {
            0x2::vec_set::remove<address>(&mut v1.pending_approvals, &v0);
        };
        let v4 = v1.ticket_price;
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v1.event_balance, v4), arg2), v0);
        };
        0x2::vec_set::remove<0x2::object::ID>(&mut 0x2::table::borrow_mut<address, UserProfile>(&mut arg0.user_profiles, v0).events_attended, &arg1);
    }

    public fun create_event(arg0: &mut GlobalRegistry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: u64, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::option::Option<u64>, arg11: u64, arg12: bool, arg13: bool, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg15);
        let v1 = 0x2::clock::timestamp_ms(arg14);
        validate_event_inputs(&arg1, arg6, arg7, v1);
        assert!(0x2::table::contains<address, UserProfile>(&arg0.user_profiles, v0), 7);
        let v2 = 0x2::object::new(arg15);
        let v3 = 0x2::object::uid_to_inner(&v2);
        let v4 = Event{
            id                 : v2,
            creator            : v0,
            title              : arg1,
            description        : arg2,
            banner_url         : arg3,
            nft_image_url      : arg4,
            poap_image_url     : arg5,
            start_date         : arg6,
            end_date           : arg7,
            location           : arg8,
            category           : arg9,
            capacity           : arg10,
            ticket_price       : arg11,
            is_free            : arg11 == 0,
            requires_approval  : arg12,
            is_private         : arg13,
            is_active          : true,
            attendees          : 0x2::vec_set::empty<address>(),
            approved_attendees : 0x2::vec_set::empty<address>(),
            pending_approvals  : 0x2::vec_set::empty<address>(),
            event_balance      : 0x2::balance::zero<0x2::sui::SUI>(),
            metadata           : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
            created_at         : v1,
            updated_at         : v1,
        };
        let v5 = EventCreated{
            event_id   : v3,
            creator    : v0,
            title      : v4.title,
            start_date : arg6,
            is_free    : v4.is_free,
        };
        0x2::event::emit<EventCreated>(v5);
        0x2::vec_set::insert<0x2::object::ID>(&mut 0x2::table::borrow_mut<address, UserProfile>(&mut arg0.user_profiles, v0).events_created, v3);
        0x2::table::add<0x2::object::ID, Event>(&mut arg0.events, v3, v4);
        arg0.event_counter = arg0.event_counter + 1;
    }

    public fun create_profile(arg0: &mut GlobalRegistry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        validate_profile_inputs(&arg1, &arg2);
        assert!(!0x2::table::contains<address, UserProfile>(&arg0.user_profiles, v0), 2);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        let v2 = UserProfile{
            id                 : 0x2::object::new(arg5),
            wallet_address     : v0,
            username           : arg1,
            bio                : arg2,
            avatar_url         : arg3,
            social_links       : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
            events_created     : 0x2::vec_set::empty<0x2::object::ID>(),
            events_attended    : 0x2::vec_set::empty<0x2::object::ID>(),
            communities_joined : 0x2::vec_set::empty<0x2::object::ID>(),
            reputation_score   : 0,
            created_at         : v1,
            updated_at         : v1,
        };
        let v3 = ProfileCreated{
            user_address : v0,
            username     : v2.username,
        };
        0x2::event::emit<ProfileCreated>(v3);
        0x2::table::add<address, UserProfile>(&mut arg0.user_profiles, v0, v2);
        arg0.total_users = arg0.total_users + 1;
    }

    fun generate_ticket_code(arg0: 0x2::object::ID, arg1: address, arg2: u64) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"TKT-");
        let v1 = 0x1::string::utf8(0x2::hex::encode(0x2::object::id_to_bytes(&arg0)));
        if (0x1::string::length(&v1) >= 8) {
            0x1::string::append(&mut v0, 0x1::string::substring(&v1, 0, 8));
        } else {
            0x1::string::append(&mut v0, v1);
        };
        0x1::string::append_utf8(&mut v0, b"-");
        let v2 = 0x1::string::utf8(0x2::hex::encode(0x2::bcs::to_bytes<address>(&arg1)));
        if (0x1::string::length(&v2) >= 8) {
            0x1::string::append(&mut v0, 0x1::string::substring(&v2, 0, 8));
        } else {
            0x1::string::append(&mut v0, v2);
        };
        0x1::string::append_utf8(&mut v0, b"-");
        0x1::string::append(&mut v0, u64_to_string(arg2 % 1000000));
        v0
    }

    public fun get_attendee_count(arg0: &GlobalRegistry, arg1: 0x2::object::ID) : u64 {
        0x2::vec_set::size<address>(&0x2::table::borrow<0x2::object::ID, Event>(&arg0.events, arg1).attendees)
    }

    public fun get_event(arg0: &GlobalRegistry, arg1: 0x2::object::ID) : &Event {
        0x2::table::borrow<0x2::object::ID, Event>(&arg0.events, arg1)
    }

    public fun get_event_banner_url(arg0: &GlobalRegistry, arg1: 0x2::object::ID) : 0x1::string::String {
        0x2::table::borrow<0x2::object::ID, Event>(&arg0.events, arg1).banner_url
    }

    public fun get_event_creator(arg0: &GlobalRegistry, arg1: 0x2::object::ID) : address {
        0x2::table::borrow<0x2::object::ID, Event>(&arg0.events, arg1).creator
    }

    public fun get_event_end_date(arg0: &GlobalRegistry, arg1: 0x2::object::ID) : u64 {
        0x2::table::borrow<0x2::object::ID, Event>(&arg0.events, arg1).end_date
    }

    public fun get_event_location(arg0: &GlobalRegistry, arg1: 0x2::object::ID) : 0x1::string::String {
        0x2::table::borrow<0x2::object::ID, Event>(&arg0.events, arg1).location
    }

    public fun get_event_nft_image_url(arg0: &GlobalRegistry, arg1: 0x2::object::ID) : 0x1::string::String {
        0x2::table::borrow<0x2::object::ID, Event>(&arg0.events, arg1).nft_image_url
    }

    public fun get_event_poap_image_url(arg0: &GlobalRegistry, arg1: 0x2::object::ID) : 0x1::string::String {
        0x2::table::borrow<0x2::object::ID, Event>(&arg0.events, arg1).poap_image_url
    }

    public fun get_event_start_date(arg0: &GlobalRegistry, arg1: 0x2::object::ID) : u64 {
        0x2::table::borrow<0x2::object::ID, Event>(&arg0.events, arg1).start_date
    }

    public fun get_event_stats(arg0: &GlobalRegistry, arg1: 0x2::object::ID) : (u64, u64, u64, u64, u64, bool) {
        assert!(0x2::table::contains<0x2::object::ID, Event>(&arg0.events, arg1), 1);
        let v0 = 0x2::table::borrow<0x2::object::ID, Event>(&arg0.events, arg1);
        let v1 = if (0x2::table::contains<0x2::object::ID, 0x2::vec_set::VecSet<address>>(&arg0.attendance_records, arg1)) {
            0x2::vec_set::size<address>(0x2::table::borrow<0x2::object::ID, 0x2::vec_set::VecSet<address>>(&arg0.attendance_records, arg1))
        } else {
            0
        };
        let v2 = if (0x2::table::contains<0x2::object::ID, 0x2::vec_set::VecSet<address>>(&arg0.event_waitlists, arg1)) {
            0x2::vec_set::size<address>(0x2::table::borrow<0x2::object::ID, 0x2::vec_set::VecSet<address>>(&arg0.event_waitlists, arg1))
        } else {
            0
        };
        (0x2::vec_set::size<address>(&v0.attendees), 0x2::vec_set::size<address>(&v0.pending_approvals), v1, v2, 0x2::balance::value<0x2::sui::SUI>(&v0.event_balance), v0.is_active)
    }

    public fun get_event_title(arg0: &GlobalRegistry, arg1: 0x2::object::ID) : 0x1::string::String {
        0x2::table::borrow<0x2::object::ID, Event>(&arg0.events, arg1).title
    }

    fun get_next_nft_edition(arg0: &mut GlobalRegistry, arg1: 0x2::object::ID) : u64 {
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, Event>(&mut arg0.events, arg1);
        let v1 = 0x1::string::utf8(b"nft_edition_count");
        let v2 = if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&v0.metadata, &v1)) {
            let v3 = *0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&v0.metadata, &v1);
            let v4 = 0;
            let v5 = 0x1::string::as_bytes(&v3);
            let v6 = 0;
            while (v6 < 0x1::vector::length<u8>(v5)) {
                let v7 = *0x1::vector::borrow<u8>(v5, v6);
                if (v7 >= 48 && v7 <= 57) {
                    let v8 = v4 * 10;
                    v4 = v8 + ((v7 - 48) as u64);
                };
                v6 = v6 + 1;
            };
            v4
        } else {
            0
        };
        let v9 = v2 + 1;
        if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&v0.metadata, &v1)) {
            let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut v0.metadata, &v1);
        };
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0.metadata, v1, u64_to_string(v9));
        v9
    }

    public fun get_platform_stats(arg0: &GlobalRegistry) : (u64, u64, u64) {
        (arg0.event_counter, arg0.total_users, 0x2::balance::value<0x2::sui::SUI>(&arg0.platform_balance))
    }

    public fun get_user_profile(arg0: &GlobalRegistry, arg1: address) : &UserProfile {
        0x2::table::borrow<address, UserProfile>(&arg0.user_profiles, arg1)
    }

    public(friend) fun get_user_profile_mut(arg0: &mut GlobalRegistry, arg1: address) : &mut UserProfile {
        0x2::table::borrow_mut<address, UserProfile>(&mut arg0.user_profiles, arg1)
    }

    public fun get_user_registration(arg0: &GlobalRegistry, arg1: address, arg2: 0x2::object::ID) : 0x1::option::Option<0x2::object::ID> {
        if (!0x2::table::contains<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.user_registrations, arg1)) {
            return 0x1::option::none<0x2::object::ID>()
        };
        let v0 = 0x2::vec_set::into_keys<0x2::object::ID>(*0x2::table::borrow<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.user_registrations, arg1));
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x2::object::ID>(&v0)) {
            let v2 = *0x1::vector::borrow<0x2::object::ID>(&v0, v1);
            if (0x2::table::borrow<0x2::object::ID, EventRegistration>(&arg0.registrations, v2).event_id == arg2) {
                return 0x1::option::some<0x2::object::ID>(v2)
            };
            v1 = v1 + 1;
        };
        0x1::option::none<0x2::object::ID>()
    }

    public fun get_user_wallet_address(arg0: &GlobalRegistry, arg1: address) : address {
        0x2::table::borrow<address, UserProfile>(&arg0.user_profiles, arg1).wallet_address
    }

    public fun has_attended_event(arg0: &GlobalRegistry, arg1: 0x2::object::ID, arg2: address) : bool {
        if (!0x2::table::contains<0x2::object::ID, 0x2::vec_set::VecSet<address>>(&arg0.attendance_records, arg1)) {
            return false
        };
        0x2::vec_set::contains<address>(0x2::table::borrow<0x2::object::ID, 0x2::vec_set::VecSet<address>>(&arg0.attendance_records, arg1), &arg2)
    }

    public fun has_user_profile(arg0: &GlobalRegistry, arg1: address) : bool {
        0x2::table::contains<address, UserProfile>(&arg0.user_profiles, arg1)
    }

    fun init(arg0: SUILENS_CORE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<SUILENS_CORE>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"event_date"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"event_location"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"edition"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{event_name} - Event NFT #{edition_number}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Commemorative NFT for attending {event_name}. This NFT proves your participation in this event on the SuiLens platform."));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{event_image}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://suilens.xyz/event/{event_id}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"SuiLens"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{event_date}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{event_location}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"#{edition_number}"));
        let v5 = 0x2::display::new_with_fields<EventNFT>(&v0, v1, v3, arg1);
        0x2::display::update_version<EventNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<EventNFT>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = AdminCap{id: 0x2::object::new(arg1)};
        let v7 = GlobalRegistry{
            id                 : 0x2::object::new(arg1),
            events             : 0x2::table::new<0x2::object::ID, Event>(arg1),
            user_profiles      : 0x2::table::new<address, UserProfile>(arg1),
            event_counter      : 0,
            total_users        : 0,
            platform_fee_rate  : 250,
            platform_balance   : 0x2::balance::zero<0x2::sui::SUI>(),
            attendance_records : 0x2::table::new<0x2::object::ID, 0x2::vec_set::VecSet<address>>(arg1),
            event_waitlists    : 0x2::table::new<0x2::object::ID, 0x2::vec_set::VecSet<address>>(arg1),
            registrations      : 0x2::table::new<0x2::object::ID, EventRegistration>(arg1),
            user_registrations : 0x2::table::new<address, 0x2::vec_set::VecSet<0x2::object::ID>>(arg1),
        };
        0x2::transfer::transfer<AdminCap>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<GlobalRegistry>(v7);
    }

    public fun is_approved_attendee(arg0: &GlobalRegistry, arg1: 0x2::object::ID, arg2: address) : bool {
        if (!0x2::table::contains<0x2::object::ID, Event>(&arg0.events, arg1)) {
            return false
        };
        0x2::vec_set::contains<address>(&0x2::table::borrow<0x2::object::ID, Event>(&arg0.events, arg1).approved_attendees, &arg2)
    }

    public fun is_registered(arg0: &GlobalRegistry, arg1: 0x2::object::ID, arg2: address) : bool {
        if (!0x2::table::contains<0x2::object::ID, Event>(&arg0.events, arg1)) {
            return false
        };
        0x2::vec_set::contains<address>(&0x2::table::borrow<0x2::object::ID, Event>(&arg0.events, arg1).attendees, &arg2)
    }

    public fun join_waitlist(arg0: &mut GlobalRegistry, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        0x2::clock::timestamp_ms(arg2);
        assert!(0x2::table::contains<0x2::object::ID, Event>(&arg0.events, arg1), 1);
        assert!(0x2::table::contains<address, UserProfile>(&arg0.user_profiles, v0), 7);
        let v1 = 0x2::table::borrow<0x2::object::ID, Event>(&arg0.events, arg1);
        assert!(0x1::option::is_some<u64>(&v1.capacity), 20);
        assert!(0x2::vec_set::size<address>(&v1.attendees) >= *0x1::option::borrow<u64>(&v1.capacity), 21);
        assert!(!0x2::vec_set::contains<address>(&v1.attendees, &v0), 2);
        assert!(!0x2::vec_set::contains<address>(&v1.pending_approvals, &v0), 2);
        if (!0x2::table::contains<0x2::object::ID, 0x2::vec_set::VecSet<address>>(&arg0.event_waitlists, arg1)) {
            0x2::table::add<0x2::object::ID, 0x2::vec_set::VecSet<address>>(&mut arg0.event_waitlists, arg1, 0x2::vec_set::empty<address>());
        };
        let v2 = 0x2::table::borrow_mut<0x2::object::ID, 0x2::vec_set::VecSet<address>>(&mut arg0.event_waitlists, arg1);
        assert!(!0x2::vec_set::contains<address>(v2, &v0), 22);
        0x2::vec_set::insert<address>(v2, v0);
        let v3 = JoinedWaitlist{
            event_id : arg1,
            user     : v0,
            position : 0x2::vec_set::size<address>(v2),
        };
        0x2::event::emit<JoinedWaitlist>(v3);
    }

    public fun mark_attendance(arg0: &mut GlobalRegistry, arg1: 0x2::object::ID, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(0x2::table::contains<0x2::object::ID, Event>(&arg0.events, arg1), 1);
        let v2 = 0x2::table::borrow<0x2::object::ID, Event>(&arg0.events, arg1);
        assert!(v2.creator == v0, 0);
        assert!(v1 >= v2.start_date, 14);
        assert!(v1 <= v2.end_date, 15);
        assert!(0x2::vec_set::contains<address>(&v2.approved_attendees, &arg2), 9);
        if (!0x2::table::contains<0x2::object::ID, 0x2::vec_set::VecSet<address>>(&arg0.attendance_records, arg1)) {
            0x2::table::add<0x2::object::ID, 0x2::vec_set::VecSet<address>>(&mut arg0.attendance_records, arg1, 0x2::vec_set::empty<address>());
        };
        let v3 = 0x2::table::borrow_mut<0x2::object::ID, 0x2::vec_set::VecSet<address>>(&mut arg0.attendance_records, arg1);
        assert!(!0x2::vec_set::contains<address>(v3, &arg2), 16);
        0x2::vec_set::insert<address>(v3, arg2);
        let v4 = AttendanceMarked{
            event_id      : arg1,
            attendee      : arg2,
            checked_in_by : v0,
            check_in_time : v1,
        };
        0x2::event::emit<AttendanceMarked>(v4);
    }

    public fun mint_event_nft(arg0: &mut GlobalRegistry, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(is_approved_attendee(arg0, arg1, v0), 9);
        let v1 = get_next_nft_edition(arg0, arg1);
        let v2 = 0x2::table::borrow<0x2::object::ID, Event>(&arg0.events, arg1);
        let v3 = 0x2::object::new(arg3);
        let v4 = EventNFT{
            id             : v3,
            event_id       : arg1,
            event_name     : v2.title,
            event_image    : v2.nft_image_url,
            event_date     : v2.start_date,
            event_location : v2.location,
            minted_by      : v0,
            minted_at      : 0x2::clock::timestamp_ms(arg2),
            edition_number : v1,
        };
        let v5 = EventNFTMinted{
            nft_id   : 0x2::object::uid_to_inner(&v3),
            event_id : arg1,
            minter   : v0,
            edition  : v1,
        };
        0x2::event::emit<EventNFTMinted>(v5);
        0x2::transfer::public_transfer<EventNFT>(v4, v0);
    }

    public fun register_for_event(arg0: &mut GlobalRegistry, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(0x2::table::contains<0x2::object::ID, Event>(&arg0.events, arg1), 1);
        assert!(0x2::table::contains<address, UserProfile>(&arg0.user_profiles, v0), 7);
        let v2 = 0x2::table::borrow_mut<0x2::object::ID, Event>(&mut arg0.events, arg1);
        validate_registration_eligibility(v2, v0, v1);
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v3 >= v2.ticket_price, 4);
        let v4 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.platform_balance, 0x2::balance::split<0x2::sui::SUI>(&mut v4, v3 * arg0.platform_fee_rate / 10000));
        0x2::balance::join<0x2::sui::SUI>(&mut v2.event_balance, v4);
        let v5 = if (v2.requires_approval) {
            0x2::vec_set::insert<address>(&mut v2.pending_approvals, v0);
            0
        } else {
            0x2::vec_set::insert<address>(&mut v2.attendees, v0);
            0x2::vec_set::insert<address>(&mut v2.approved_attendees, v0);
            0x2::vec_set::insert<0x2::object::ID>(&mut 0x2::table::borrow_mut<address, UserProfile>(&mut arg0.user_profiles, v0).events_attended, arg1);
            1
        };
        let v6 = 0x2::object::new(arg4);
        let v7 = 0x2::object::uid_to_inner(&v6);
        let v8 = EventRegistration{
            id                : v6,
            event_id          : arg1,
            attendee          : v0,
            payment_amount    : v3,
            registration_date : v1,
            status            : v5,
            approval_required : v2.requires_approval,
            ticket_code       : generate_ticket_code(arg1, v0, v1),
        };
        0x2::table::add<0x2::object::ID, EventRegistration>(&mut arg0.registrations, v7, v8);
        if (!0x2::table::contains<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.user_registrations, v0)) {
            0x2::table::add<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.user_registrations, v0, 0x2::vec_set::empty<0x2::object::ID>());
        };
        0x2::vec_set::insert<0x2::object::ID>(0x2::table::borrow_mut<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.user_registrations, v0), v7);
        let v9 = UserRegistered{
            event_id          : arg1,
            attendee          : v0,
            payment_amount    : v3,
            requires_approval : v2.requires_approval,
        };
        0x2::event::emit<UserRegistered>(v9);
    }

    public(friend) fun remove_user_community(arg0: &mut GlobalRegistry, arg1: address, arg2: 0x2::object::ID) {
        0x2::vec_set::remove<0x2::object::ID>(&mut 0x2::table::borrow_mut<address, UserProfile>(&mut arg0.user_profiles, arg1).communities_joined, &arg2);
    }

    public fun self_checkin(arg0: &mut GlobalRegistry, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(0x1::string::length(&arg2) > 0, 17);
        assert!(0x2::table::contains<0x2::object::ID, Event>(&arg0.events, arg1), 1);
        let v2 = 0x2::table::borrow<0x2::object::ID, Event>(&arg0.events, arg1);
        assert!(v1 >= v2.start_date, 14);
        assert!(v1 <= v2.end_date, 15);
        assert!(0x2::vec_set::contains<address>(&v2.attendees, &v0) || 0x2::vec_set::contains<address>(&v2.approved_attendees, &v0), 9);
        if (!0x2::table::contains<0x2::object::ID, 0x2::vec_set::VecSet<address>>(&arg0.attendance_records, arg1)) {
            0x2::table::add<0x2::object::ID, 0x2::vec_set::VecSet<address>>(&mut arg0.attendance_records, arg1, 0x2::vec_set::empty<address>());
        };
        let v3 = 0x2::table::borrow_mut<0x2::object::ID, 0x2::vec_set::VecSet<address>>(&mut arg0.attendance_records, arg1);
        assert!(!0x2::vec_set::contains<address>(v3, &v0), 16);
        0x2::vec_set::insert<address>(v3, v0);
        let v4 = AttendanceMarked{
            event_id      : arg1,
            attendee      : v0,
            checked_in_by : v0,
            check_in_time : v1,
        };
        0x2::event::emit<AttendanceMarked>(v4);
    }

    fun u64_to_string(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 != 0) {
            0x1::vector::push_back<u8>(&mut v0, ((48 + arg0 % 10) as u8));
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    public fun update_event(arg0: &mut GlobalRegistry, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x2::object::ID, Event>(&arg0.events, arg1), 1);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, Event>(&mut arg0.events, arg1);
        assert!(v0.creator == 0x2::tx_context::sender(arg10), 0);
        v0.title = arg2;
        v0.description = arg3;
        v0.banner_url = arg4;
        v0.nft_image_url = arg5;
        v0.poap_image_url = arg6;
        v0.location = arg7;
        v0.category = arg8;
        v0.updated_at = 0x2::clock::timestamp_ms(arg9);
    }

    public fun update_event_critical(arg0: &mut GlobalRegistry, arg1: 0x2::object::ID, arg2: 0x1::option::Option<u64>, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<0x1::option::Option<u64>>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg6);
        assert!(0x2::table::contains<0x2::object::ID, Event>(&arg0.events, arg1), 1);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, Event>(&mut arg0.events, arg1);
        assert!(v1.creator == 0x2::tx_context::sender(arg7), 0);
        assert!(v0 < v1.start_date, 18);
        if (0x1::option::is_some<u64>(&arg2)) {
            let v2 = *0x1::option::borrow<u64>(&arg2);
            assert!(v2 > v0, 6);
            v1.start_date = v2;
        };
        if (0x1::option::is_some<u64>(&arg3)) {
            let v3 = *0x1::option::borrow<u64>(&arg3);
            assert!(v3 > v1.start_date, 6);
            v1.end_date = v3;
        };
        if (0x1::option::is_some<u64>(&arg4)) {
            assert!(0x2::vec_set::is_empty<address>(&v1.attendees), 19);
            let v4 = *0x1::option::borrow<u64>(&arg4);
            v1.ticket_price = v4;
            v1.is_free = v4 == 0;
        };
        if (0x1::option::is_some<0x1::option::Option<u64>>(&arg5)) {
            v1.capacity = *0x1::option::borrow<0x1::option::Option<u64>>(&arg5);
        };
        v1.updated_at = v0;
    }

    public fun update_platform_fee_rate(arg0: &AdminCap, arg1: &mut GlobalRegistry, arg2: u64) {
        assert!(arg2 <= 1000, 10);
        arg1.platform_fee_rate = arg2;
    }

    public fun update_profile(arg0: &mut GlobalRegistry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x2::table::contains<address, UserProfile>(&arg0.user_profiles, v0), 7);
        let v1 = 0x2::table::borrow_mut<address, UserProfile>(&mut arg0.user_profiles, v0);
        v1.username = arg1;
        v1.bio = arg2;
        v1.avatar_url = arg3;
        v1.updated_at = 0x2::clock::timestamp_ms(arg4);
    }

    fun validate_event_inputs(arg0: &0x1::string::String, arg1: u64, arg2: u64, arg3: u64) {
        assert!(!0x1::string::is_empty(arg0), 10);
        assert!(arg1 > arg3, 6);
        assert!(arg2 > arg1, 6);
    }

    fun validate_profile_inputs(arg0: &0x1::string::String, arg1: &0x1::string::String) {
        assert!(!0x1::string::is_empty(arg0), 10);
    }

    fun validate_registration_eligibility(arg0: &Event, arg1: address, arg2: u64) {
        assert!(arg2 < arg0.start_date, 5);
        assert!(arg0.is_active, 5);
        assert!(!0x2::vec_set::contains<address>(&arg0.attendees, &arg1), 2);
        assert!(!0x2::vec_set::contains<address>(&arg0.pending_approvals, &arg1), 2);
        if (0x1::option::is_some<u64>(&arg0.capacity)) {
            assert!(0x2::vec_set::size<address>(&arg0.attendees) < *0x1::option::borrow<u64>(&arg0.capacity), 3);
        };
    }

    public fun verify_and_checkin(arg0: &mut GlobalRegistry, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::string::length(&arg2) > 0, 17);
        mark_attendance(arg0, arg1, arg3, arg4, arg5);
    }

    public fun withdraw_event_funds(arg0: &mut GlobalRegistry, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<0x2::object::ID, Event>(&arg0.events, arg1), 1);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, Event>(&mut arg0.events, arg1);
        assert!(v1.creator == v0, 0);
        assert!(0x2::clock::timestamp_ms(arg2) > v1.end_date, 11);
        assert!(v1.is_active, 13);
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&v1.event_balance);
        assert!(v2 > 0, 12);
        let v3 = v2 * arg0.platform_fee_rate / 10000;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.platform_balance, 0x2::balance::split<0x2::sui::SUI>(&mut v1.event_balance, v3));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut v1.event_balance), arg3), v0);
        let v4 = EventFundsWithdrawn{
            event_id     : arg1,
            creator      : v0,
            amount       : v2 - v3,
            platform_fee : v3,
        };
        0x2::event::emit<EventFundsWithdrawn>(v4);
    }

    public fun withdraw_platform_fees(arg0: &AdminCap, arg1: &mut GlobalRegistry, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 0x2::balance::value<0x2::sui::SUI>(&arg1.platform_balance), 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.platform_balance, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

