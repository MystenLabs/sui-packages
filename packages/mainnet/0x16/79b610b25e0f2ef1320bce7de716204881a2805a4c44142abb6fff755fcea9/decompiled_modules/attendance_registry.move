module 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::attendance_registry {
    struct AttendanceRegistry has key {
        id: 0x2::object::UID,
        club_id: 0x2::object::ID,
        current_term: u64,
        date: 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::Date,
        session: 0x1::string::String,
        registered_members: vector<address>,
        attendees: vector<0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::members::MemberInfo>,
        late: vector<0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::members::MemberInfo>,
        absent: vector<0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::members::MemberInfo>,
        excused: vector<0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::members::MemberInfo>,
        is_open: bool,
    }

    struct AttendanceRegistryCreated has copy, drop, store {
        registry_id: 0x2::object::ID,
        current_term: u64,
        club_id: 0x2::object::ID,
    }

    struct AttendanceRegistryDeleted has copy, drop, store {
        registry_id: 0x2::object::ID,
        current_term: u64,
        club_id: 0x2::object::ID,
    }

    public fun close_attendance_registry(arg0: 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::PresidentWitness, arg1: &mut 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::BlockBlockClub, arg2: &mut AttendanceRegistry) {
        assert!(arg2.current_term == 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::term(arg1), 2);
        arg2.is_open = false;
    }

    public fun convert_attendance_registry_to_attendance_sheet(arg0: 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::PresidentWitness, arg1: &0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::BlockBlockRegistry, arg2: AttendanceRegistry, arg3: &mut 0x2::tx_context::TxContext) : 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::AttendanceSheet {
        assert!(!arg2.is_open, 9);
        let AttendanceRegistry {
            id                 : v0,
            club_id            : _,
            current_term       : v2,
            date               : v3,
            session            : v4,
            registered_members : _,
            attendees          : _,
            late               : _,
            absent             : _,
            excused            : _,
            is_open            : _,
        } = arg2;
        let v11 = v0;
        let v12 = AttendanceRegistryDeleted{
            registry_id  : 0x2::object::uid_to_inner(&v11),
            current_term : v2,
            club_id      : 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::current_club(arg1),
        };
        0x2::event::emit<AttendanceRegistryDeleted>(v12);
        0x2::object::delete(v11);
        let v13 = 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::create_attendance_sheet(v3, v4, member_infos_to_addresses(&arg2.attendees), member_infos_to_addresses(&arg2.late), member_infos_to_addresses(&arg2.absent), member_infos_to_addresses(&arg2.excused));
        0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::activity_badge::mint_activity_badges(&v13, 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::current_club(arg1), v2, arg3);
        v13
    }

    public fun create_and_share_attendance_registry(arg0: 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::PresidentWitness, arg1: &0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::BlockBlockRegistry, arg2: u64, arg3: u64, arg4: u64, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = AttendanceRegistry{
            id                 : 0x2::object::new(arg6),
            club_id            : 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::current_club(arg1),
            current_term       : 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::current_term(arg1),
            date               : 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::create_date(arg2, arg3, arg4),
            session            : arg5,
            registered_members : 0x1::vector::empty<address>(),
            attendees          : 0x1::vector::empty<0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::members::MemberInfo>(),
            late               : 0x1::vector::empty<0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::members::MemberInfo>(),
            absent             : 0x1::vector::empty<0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::members::MemberInfo>(),
            excused            : 0x1::vector::empty<0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::members::MemberInfo>(),
            is_open            : true,
        };
        let v1 = AttendanceRegistryCreated{
            registry_id  : 0x2::object::id<AttendanceRegistry>(&v0),
            current_term : 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::current_term(arg1),
            club_id      : 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::current_club(arg1),
        };
        0x2::event::emit<AttendanceRegistryCreated>(v1);
        0x2::transfer::share_object<AttendanceRegistry>(v0);
    }

    fun member_infos_to_addresses(arg0: &vector<0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::members::MemberInfo>) : vector<address> {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::members::MemberInfo>(arg0)) {
            0x1::vector::push_back<address>(&mut v0, 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::members::member_address(0x1::vector::borrow<0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::members::MemberInfo>(arg0, v1)));
            v1 = v1 + 1;
        };
        v0
    }

    public fun register_member_info_to_absence(arg0: &0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::BlockBlockRegistry, arg1: &0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::BlockBlockClub, arg2: &mut AttendanceRegistry, arg3: 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::members::MemberInfo, arg4: &0x2::tx_context::TxContext) {
        0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::assert_current_club(arg0, arg1);
        assert!(arg2.current_term == 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::term(arg1), 2);
        let v0 = 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::members::member_address(&arg3);
        let v1 = if (0x1::vector::contains<address>(0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::borrow_junior_members(arg1), &v0)) {
            true
        } else {
            let v2 = 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::members::member_address(&arg3);
            0x1::vector::contains<address>(0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::borrow_senior_members(arg1), &v2)
        };
        assert!(v1, 13906834758458933247);
        assert!(!arg2.is_open, 9);
        assert!(0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::president(arg1) == 0x2::tx_context::sender(arg4) || 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::vice_president(arg1) == 0x2::tx_context::sender(arg4), 13906834775638802431);
        let v3 = 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::members::member_address(&arg3);
        assert!(!0x1::vector::contains<address>(&arg2.registered_members, &v3), 7);
        0x1::vector::push_back<address>(&mut arg2.registered_members, 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::members::member_address(&arg3));
        0x1::vector::push_back<0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::members::MemberInfo>(&mut arg2.absent, arg3);
    }

    public fun register_member_info_to_attendance_registry(arg0: 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::MemberWitness, arg1: &0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::BlockBlockClub, arg2: &mut AttendanceRegistry, arg3: 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::members::MemberInfo) {
        assert!(arg2.is_open, 6);
        assert!(0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::members::member_address(&arg3) == 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::member_address(&arg0), 2);
        let v0 = 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::members::member_address(&arg3);
        let v1 = if (0x1::vector::contains<address>(0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::borrow_junior_members(arg1), &v0)) {
            true
        } else {
            let v2 = 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::members::member_address(&arg3);
            0x1::vector::contains<address>(0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::borrow_senior_members(arg1), &v2)
        };
        assert!(v1, 13906834565185404927);
        let v3 = 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::members::member_address(&arg3);
        assert!(!0x1::vector::contains<address>(&arg2.registered_members, &v3), 7);
        0x1::vector::push_back<address>(&mut arg2.registered_members, 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::members::member_address(&arg3));
        0x1::vector::push_back<0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::members::MemberInfo>(&mut arg2.attendees, arg3);
    }

    public fun register_member_info_to_excused(arg0: &0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::BlockBlockRegistry, arg1: &0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::BlockBlockClub, arg2: &mut AttendanceRegistry, arg3: 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::members::MemberInfo, arg4: &0x2::tx_context::TxContext) {
        0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::assert_current_club(arg0, arg1);
        assert!(arg2.current_term == 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::term(arg1), 2);
        let v0 = 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::members::member_address(&arg3);
        let v1 = if (0x1::vector::contains<address>(0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::borrow_junior_members(arg1), &v0)) {
            true
        } else {
            let v2 = 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::members::member_address(&arg3);
            0x1::vector::contains<address>(0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::borrow_senior_members(arg1), &v2)
        };
        assert!(v1, 13906834840063311871);
        assert!(!arg2.is_open, 9);
        assert!(0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::president(arg1) == 0x2::tx_context::sender(arg4) || 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::vice_president(arg1) == 0x2::tx_context::sender(arg4), 13906834857243181055);
        let v3 = 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::members::member_address(&arg3);
        assert!(!0x1::vector::contains<address>(&arg2.registered_members, &v3), 7);
        0x1::vector::push_back<address>(&mut arg2.registered_members, 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::members::member_address(&arg3));
        0x1::vector::push_back<0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::members::MemberInfo>(&mut arg2.excused, arg3);
    }

    public fun register_member_info_to_late(arg0: &0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::BlockBlockRegistry, arg1: &0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::BlockBlockClub, arg2: &mut AttendanceRegistry, arg3: 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::members::MemberInfo, arg4: &0x2::tx_context::TxContext) {
        0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::assert_current_club(arg0, arg1);
        assert!(arg2.current_term == 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::term(arg1), 2);
        let v0 = 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::members::member_address(&arg3);
        let v1 = if (0x1::vector::contains<address>(0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::borrow_junior_members(arg1), &v0)) {
            true
        } else {
            let v2 = 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::members::member_address(&arg3);
            0x1::vector::contains<address>(0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::borrow_senior_members(arg1), &v2)
        };
        assert!(v1, 13906834676854554623);
        assert!(!arg2.is_open, 9);
        assert!(0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::president(arg1) == 0x2::tx_context::sender(arg4) || 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::blockblock::vice_president(arg1) == 0x2::tx_context::sender(arg4), 13906834694034423807);
        let v3 = 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::members::member_address(&arg3);
        assert!(!0x1::vector::contains<address>(&arg2.registered_members, &v3), 7);
        0x1::vector::push_back<address>(&mut arg2.registered_members, 0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::members::member_address(&arg3));
        0x1::vector::push_back<0x1679b610b25e0f2ef1320bce7de716204881a2805a4c44142abb6fff755fcea9::members::MemberInfo>(&mut arg2.late, arg3);
    }

    // decompiled from Move bytecode v6
}

