module 0xdcce259374ee87d79da1ce4f43a6eb96804a57f8a510c4d653ec4f523c7c6db4::attendance {
    struct UsedTicketsRegistry has key {
        id: 0x2::object::UID,
        used_tickets: 0x2::table::Table<address, bool>,
    }

    struct Attendance has store, key {
        id: 0x2::object::UID,
        event_id: address,
        user: address,
        ticket_id: 0x1::option::Option<address>,
        check_in_time: u64,
        verification_method: u8,
        verification_code: 0x1::string::String,
        checked_in_by: address,
        is_soulbound: bool,
    }

    struct AttendanceRecorded has copy, drop {
        attendance_id: address,
        event_id: address,
        user: address,
        ticket_id: 0x1::option::Option<address>,
        verification_method: u8,
        verification_code: 0x1::string::String,
        checked_in_by: address,
    }

    struct AttendanceNFTMinted has copy, drop {
        attendance_id: address,
        user: address,
        is_soulbound: bool,
    }

    public fun get_check_in_time(arg0: &Attendance) : u64 {
        arg0.check_in_time
    }

    public fun get_checked_in_by(arg0: &Attendance) : address {
        arg0.checked_in_by
    }

    public fun get_event_id(arg0: &Attendance) : address {
        arg0.event_id
    }

    public fun get_user(arg0: &Attendance) : address {
        arg0.user
    }

    public fun get_verification_code(arg0: &Attendance) : 0x1::string::String {
        arg0.verification_code
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = UsedTicketsRegistry{
            id           : 0x2::object::new(arg0),
            used_tickets : 0x2::table::new<address, bool>(arg0),
        };
        0x2::transfer::share_object<UsedTicketsRegistry>(v0);
    }

    public fun is_soulbound(arg0: &Attendance) : bool {
        arg0.is_soulbound
    }

    public entry fun make_soulbound(arg0: &mut Attendance, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.user == 0x2::tx_context::sender(arg1), 3000);
        arg0.is_soulbound = true;
        let v0 = AttendanceNFTMinted{
            attendance_id : 0x2::object::uid_to_address(&arg0.id),
            user          : arg0.user,
            is_soulbound  : true,
        };
        0x2::event::emit<AttendanceNFTMinted>(v0);
    }

    public entry fun record_attendance(arg0: &mut UsedTicketsRegistry, arg1: &0xdcce259374ee87d79da1ce4f43a6eb96804a57f8a510c4d653ec4f523c7c6db4::event_registry::EventInfo, arg2: address, arg3: &0xdcce259374ee87d79da1ce4f43a6eb96804a57f8a510c4d653ec4f523c7c6db4::ticket_nft::Ticket, arg4: u8, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(0xdcce259374ee87d79da1ce4f43a6eb96804a57f8a510c4d653ec4f523c7c6db4::event_registry::is_organizer(arg1, v0), 3004);
        assert!(0xdcce259374ee87d79da1ce4f43a6eb96804a57f8a510c4d653ec4f523c7c6db4::ticket_nft::is_valid(arg3), 3002);
        assert!(0xdcce259374ee87d79da1ce4f43a6eb96804a57f8a510c4d653ec4f523c7c6db4::ticket_nft::get_owner(arg3) == arg2, 3002);
        let v1 = 0x2::object::id<0xdcce259374ee87d79da1ce4f43a6eb96804a57f8a510c4d653ec4f523c7c6db4::event_registry::EventInfo>(arg1);
        let v2 = 0x2::object::id_to_address(&v1);
        assert!(0xdcce259374ee87d79da1ce4f43a6eb96804a57f8a510c4d653ec4f523c7c6db4::ticket_nft::get_event_id(arg3) == v2, 3002);
        let v3 = 0x2::object::id<0xdcce259374ee87d79da1ce4f43a6eb96804a57f8a510c4d653ec4f523c7c6db4::ticket_nft::Ticket>(arg3);
        let v4 = 0x2::object::id_to_address(&v3);
        assert!(!0x2::table::contains<address, bool>(&arg0.used_tickets, v4), 3005);
        0x2::table::add<address, bool>(&mut arg0.used_tickets, v4, true);
        let v5 = Attendance{
            id                  : 0x2::object::new(arg6),
            event_id            : v2,
            user                : arg2,
            ticket_id           : 0x1::option::some<address>(v4),
            check_in_time       : 0x2::clock::timestamp_ms(arg5),
            verification_method : arg4,
            verification_code   : 0x1::string::utf8(b""),
            checked_in_by       : v0,
            is_soulbound        : false,
        };
        let v6 = AttendanceRecorded{
            attendance_id       : 0x2::object::uid_to_address(&v5.id),
            event_id            : v2,
            user                : arg2,
            ticket_id           : v5.ticket_id,
            verification_method : arg4,
            verification_code   : v5.verification_code,
            checked_in_by       : v0,
        };
        0x2::event::emit<AttendanceRecorded>(v6);
        0x2::transfer::public_transfer<Attendance>(v5, arg2);
    }

    public entry fun record_attendance_with_verification(arg0: &mut UsedTicketsRegistry, arg1: &0xdcce259374ee87d79da1ce4f43a6eb96804a57f8a510c4d653ec4f523c7c6db4::event_registry::EventInfo, arg2: address, arg3: &0xdcce259374ee87d79da1ce4f43a6eb96804a57f8a510c4d653ec4f523c7c6db4::ticket_nft::Ticket, arg4: vector<u8>, arg5: u8, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(0xdcce259374ee87d79da1ce4f43a6eb96804a57f8a510c4d653ec4f523c7c6db4::event_registry::is_organizer(arg1, v0), 3004);
        assert!(0xdcce259374ee87d79da1ce4f43a6eb96804a57f8a510c4d653ec4f523c7c6db4::ticket_nft::is_valid(arg3), 3002);
        assert!(0xdcce259374ee87d79da1ce4f43a6eb96804a57f8a510c4d653ec4f523c7c6db4::ticket_nft::get_owner(arg3) == arg2, 3002);
        let v1 = 0x2::object::id<0xdcce259374ee87d79da1ce4f43a6eb96804a57f8a510c4d653ec4f523c7c6db4::event_registry::EventInfo>(arg1);
        let v2 = 0x2::object::id_to_address(&v1);
        assert!(0xdcce259374ee87d79da1ce4f43a6eb96804a57f8a510c4d653ec4f523c7c6db4::ticket_nft::get_event_id(arg3) == v2, 3002);
        let v3 = 0x2::object::id<0xdcce259374ee87d79da1ce4f43a6eb96804a57f8a510c4d653ec4f523c7c6db4::ticket_nft::Ticket>(arg3);
        let v4 = 0x2::object::id_to_address(&v3);
        assert!(!0x2::table::contains<address, bool>(&arg0.used_tickets, v4), 3005);
        0x2::table::add<address, bool>(&mut arg0.used_tickets, v4, true);
        let v5 = 0x1::string::utf8(arg4);
        let v6 = Attendance{
            id                  : 0x2::object::new(arg7),
            event_id            : v2,
            user                : arg2,
            ticket_id           : 0x1::option::some<address>(v4),
            check_in_time       : 0x2::clock::timestamp_ms(arg6),
            verification_method : arg5,
            verification_code   : v5,
            checked_in_by       : v0,
            is_soulbound        : false,
        };
        let v7 = AttendanceRecorded{
            attendance_id       : 0x2::object::uid_to_address(&v6.id),
            event_id            : v2,
            user                : arg2,
            ticket_id           : v6.ticket_id,
            verification_method : arg5,
            verification_code   : v5,
            checked_in_by       : v0,
        };
        0x2::event::emit<AttendanceRecorded>(v7);
        0x2::transfer::public_transfer<Attendance>(v6, arg2);
    }

    public entry fun record_attendance_without_ticket(arg0: &0xdcce259374ee87d79da1ce4f43a6eb96804a57f8a510c4d653ec4f523c7c6db4::event_registry::EventInfo, arg1: address, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0xdcce259374ee87d79da1ce4f43a6eb96804a57f8a510c4d653ec4f523c7c6db4::event_registry::is_organizer(arg0, v0), 3004);
        let v1 = 0x2::object::id<0xdcce259374ee87d79da1ce4f43a6eb96804a57f8a510c4d653ec4f523c7c6db4::event_registry::EventInfo>(arg0);
        let v2 = 0x2::object::id_to_address(&v1);
        let v3 = Attendance{
            id                  : 0x2::object::new(arg4),
            event_id            : v2,
            user                : arg1,
            ticket_id           : 0x1::option::none<address>(),
            check_in_time       : 0x2::clock::timestamp_ms(arg3),
            verification_method : arg2,
            verification_code   : 0x1::string::utf8(b""),
            checked_in_by       : v0,
            is_soulbound        : false,
        };
        let v4 = AttendanceRecorded{
            attendance_id       : 0x2::object::uid_to_address(&v3.id),
            event_id            : v2,
            user                : arg1,
            ticket_id           : 0x1::option::none<address>(),
            verification_method : arg2,
            verification_code   : 0x1::string::utf8(b""),
            checked_in_by       : v0,
        };
        0x2::event::emit<AttendanceRecorded>(v4);
        0x2::transfer::public_transfer<Attendance>(v3, arg1);
    }

    // decompiled from Move bytecode v6
}

