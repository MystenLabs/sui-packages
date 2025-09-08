module 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::attendance_verification {
    struct AttendanceRegistry has key {
        id: 0x2::object::UID,
        event_attendances: 0x2::table::Table<0x2::object::ID, EventAttendance>,
        user_attendances: 0x2::table::Table<address, vector<AttendanceRecord>>,
    }

    struct EventAttendance has store {
        records: 0x2::table::Table<address, AttendanceRecord>,
        check_in_count: u64,
        check_out_count: u64,
        unique_devices: 0x2::table::Table<vector<u8>, bool>,
        attendee_addresses: vector<address>,
    }

    struct AttendanceRecord has copy, drop, store {
        event_id: 0x2::object::ID,
        wallet: address,
        state: u8,
        check_in_time: u64,
        check_out_time: u64,
        device_fingerprint: vector<u8>,
        location_proof: vector<u8>,
    }

    struct MintPoACapability has store, key {
        id: 0x2::object::UID,
        event_id: 0x2::object::ID,
        wallet: address,
        check_in_time: u64,
    }

    struct MintCompletionCapability has store, key {
        id: 0x2::object::UID,
        event_id: 0x2::object::ID,
        wallet: address,
        check_in_time: u64,
        check_out_time: u64,
        attendance_duration: u64,
    }

    struct AttendeeCheckedIn has copy, drop {
        event_id: 0x2::object::ID,
        wallet: address,
        check_in_time: u64,
    }

    struct AttendeeCheckedOut has copy, drop {
        event_id: 0x2::object::ID,
        wallet: address,
        check_out_time: u64,
        attendance_duration: u64,
    }

    struct FraudAttemptDetected has copy, drop {
        event_id: 0x2::object::ID,
        wallet: address,
        reason: 0x1::string::String,
        timestamp: u64,
    }

    public fun check_in(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::Event, arg4: &mut AttendanceRegistry, arg5: &mut 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::identity_access::RegistrationRegistry, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : MintPoACapability {
        let v0 = 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::get_event_id(arg3);
        assert!(0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::is_event_active(arg3), 1);
        let (v1, v2) = 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::identity_access::validate_pass(arg0, v0, arg5, arg6);
        assert!(v1, 5);
        if (!0x2::table::contains<0x2::object::ID, EventAttendance>(&arg4.event_attendances, v0)) {
            let v3 = EventAttendance{
                records            : 0x2::table::new<address, AttendanceRecord>(arg7),
                check_in_count     : 0,
                check_out_count    : 0,
                unique_devices     : 0x2::table::new<vector<u8>, bool>(arg7),
                attendee_addresses : 0x1::vector::empty<address>(),
            };
            0x2::table::add<0x2::object::ID, EventAttendance>(&mut arg4.event_attendances, v0, v3);
        };
        let v4 = 0x2::table::borrow_mut<0x2::object::ID, EventAttendance>(&mut arg4.event_attendances, v0);
        if (0x2::table::contains<address, AttendanceRecord>(&v4.records, v2)) {
            assert!(0x2::table::borrow<address, AttendanceRecord>(&v4.records, v2).state != 1, 3);
        };
        if (0x1::vector::length<u8>(&arg1) > 0) {
            if (0x2::table::contains<vector<u8>, bool>(&v4.unique_devices, arg1)) {
                let v5 = FraudAttemptDetected{
                    event_id  : v0,
                    wallet    : v2,
                    reason    : 0x1::string::utf8(b"Duplicate device fingerprint"),
                    timestamp : 0x2::clock::timestamp_ms(arg6),
                };
                0x2::event::emit<FraudAttemptDetected>(v5);
            } else {
                0x2::table::add<vector<u8>, bool>(&mut v4.unique_devices, arg1, true);
            };
        };
        let v6 = 0x2::clock::timestamp_ms(arg6);
        let v7 = AttendanceRecord{
            event_id           : v0,
            wallet             : v2,
            state              : 1,
            check_in_time      : v6,
            check_out_time     : 0,
            device_fingerprint : arg1,
            location_proof     : arg2,
        };
        if (0x2::table::contains<address, AttendanceRecord>(&v4.records, v2)) {
            *0x2::table::borrow_mut<address, AttendanceRecord>(&mut v4.records, v2) = v7;
        } else {
            0x2::table::add<address, AttendanceRecord>(&mut v4.records, v2, v7);
        };
        v4.check_in_count = v4.check_in_count + 1;
        0x1::vector::push_back<address>(&mut v4.attendee_addresses, v2);
        if (!0x2::table::contains<address, vector<AttendanceRecord>>(&arg4.user_attendances, v2)) {
            0x2::table::add<address, vector<AttendanceRecord>>(&mut arg4.user_attendances, v2, 0x1::vector::empty<AttendanceRecord>());
        };
        0x1::vector::push_back<AttendanceRecord>(0x2::table::borrow_mut<address, vector<AttendanceRecord>>(&mut arg4.user_attendances, v2), v7);
        0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management::increment_attendees(arg3);
        0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::identity_access::mark_checked_in(v2, v0, arg5);
        let v8 = AttendeeCheckedIn{
            event_id      : v0,
            wallet        : v2,
            check_in_time : v6,
        };
        0x2::event::emit<AttendeeCheckedIn>(v8);
        MintPoACapability{
            id            : 0x2::object::new(arg7),
            event_id      : v0,
            wallet        : v2,
            check_in_time : v6,
        }
    }

    public fun check_out(arg0: address, arg1: 0x2::object::ID, arg2: &mut AttendanceRegistry, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : MintCompletionCapability {
        assert!(0x2::table::contains<0x2::object::ID, EventAttendance>(&arg2.event_attendances, arg1), 4);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, EventAttendance>(&mut arg2.event_attendances, arg1);
        assert!(0x2::table::contains<address, AttendanceRecord>(&v0.records, arg0), 4);
        let v1 = 0x2::table::borrow_mut<address, AttendanceRecord>(&mut v0.records, arg0);
        assert!(v1.state == 1, 7);
        let v2 = 0x2::clock::timestamp_ms(arg3);
        let v3 = v2 - v1.check_in_time;
        v1.state = 2;
        v1.check_out_time = v2;
        v0.check_out_count = v0.check_out_count + 1;
        let v4 = 0x2::table::borrow_mut<address, vector<AttendanceRecord>>(&mut arg2.user_attendances, arg0);
        let v5 = 0;
        while (v5 < 0x1::vector::length<AttendanceRecord>(v4)) {
            let v6 = 0x1::vector::borrow_mut<AttendanceRecord>(v4, v5);
            if (v6.event_id == arg1 && v6.state == 1) {
                v6.state = 2;
                v6.check_out_time = v2;
                break
            };
            v5 = v5 + 1;
        };
        let v7 = AttendeeCheckedOut{
            event_id            : arg1,
            wallet              : arg0,
            check_out_time      : v2,
            attendance_duration : v3,
        };
        0x2::event::emit<AttendeeCheckedOut>(v7);
        MintCompletionCapability{
            id                  : 0x2::object::new(arg4),
            event_id            : arg1,
            wallet              : arg0,
            check_in_time       : v1.check_in_time,
            check_out_time      : v2,
            attendance_duration : v3,
        }
    }

    public fun consume_completion_capability(arg0: MintCompletionCapability) : (0x2::object::ID, address, u64, u64, u64) {
        let MintCompletionCapability {
            id                  : v0,
            event_id            : v1,
            wallet              : v2,
            check_in_time       : v3,
            check_out_time      : v4,
            attendance_duration : v5,
        } = arg0;
        0x2::object::delete(v0);
        (v1, v2, v3, v4, v5)
    }

    public fun consume_poa_capability(arg0: MintPoACapability) : (0x2::object::ID, address, u64) {
        let MintPoACapability {
            id            : v0,
            event_id      : v1,
            wallet        : v2,
            check_in_time : v3,
        } = arg0;
        0x2::object::delete(v0);
        (v1, v2, v3)
    }

    public fun get_attendance_status(arg0: address, arg1: 0x2::object::ID, arg2: &AttendanceRegistry) : (bool, u8, u64, u64) {
        if (!0x2::table::contains<0x2::object::ID, EventAttendance>(&arg2.event_attendances, arg1)) {
            return (false, 0, 0, 0)
        };
        let v0 = 0x2::table::borrow<0x2::object::ID, EventAttendance>(&arg2.event_attendances, arg1);
        if (!0x2::table::contains<address, AttendanceRecord>(&v0.records, arg0)) {
            return (false, 0, 0, 0)
        };
        let v1 = 0x2::table::borrow<address, AttendanceRecord>(&v0.records, arg0);
        (true, v1.state, v1.check_in_time, v1.check_out_time)
    }

    public fun get_completion_capability_data(arg0: &MintCompletionCapability) : (0x2::object::ID, address, u64, u64, u64) {
        (arg0.event_id, arg0.wallet, arg0.check_in_time, arg0.check_out_time, arg0.attendance_duration)
    }

    public fun get_event_attendance_records(arg0: 0x2::object::ID, arg1: &AttendanceRegistry) : vector<AttendanceRecord> {
        if (!0x2::table::contains<0x2::object::ID, EventAttendance>(&arg1.event_attendances, arg0)) {
            return 0x1::vector::empty<AttendanceRecord>()
        };
        let v0 = 0x2::table::borrow<0x2::object::ID, EventAttendance>(&arg1.event_attendances, arg0);
        let v1 = 0x1::vector::empty<AttendanceRecord>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&v0.attendee_addresses)) {
            let v3 = *0x1::vector::borrow<address>(&v0.attendee_addresses, v2);
            if (0x2::table::contains<address, AttendanceRecord>(&v0.records, v3)) {
                0x1::vector::push_back<AttendanceRecord>(&mut v1, *0x2::table::borrow<address, AttendanceRecord>(&v0.records, v3));
            };
            v2 = v2 + 1;
        };
        v1
    }

    public fun get_event_attendee_addresses(arg0: 0x2::object::ID, arg1: &AttendanceRegistry) : vector<address> {
        if (!0x2::table::contains<0x2::object::ID, EventAttendance>(&arg1.event_attendances, arg0)) {
            return 0x1::vector::empty<address>()
        };
        0x2::table::borrow<0x2::object::ID, EventAttendance>(&arg1.event_attendances, arg0).attendee_addresses
    }

    public fun get_event_stats(arg0: 0x2::object::ID, arg1: &AttendanceRegistry) : (u64, u64, u64) {
        if (!0x2::table::contains<0x2::object::ID, EventAttendance>(&arg1.event_attendances, arg0)) {
            return (0, 0, 0)
        };
        let v0 = 0x2::table::borrow<0x2::object::ID, EventAttendance>(&arg1.event_attendances, arg0);
        let v1 = if (v0.check_in_count > 0) {
            v0.check_out_count * 10000 / v0.check_in_count
        } else {
            0
        };
        (v0.check_in_count, v0.check_out_count, v1)
    }

    public fun get_poa_capability_data(arg0: &MintPoACapability) : (0x2::object::ID, address, u64) {
        (arg0.event_id, arg0.wallet, arg0.check_in_time)
    }

    public fun get_user_attendance_history(arg0: address, arg1: &AttendanceRegistry) : vector<AttendanceRecord> {
        if (!0x2::table::contains<address, vector<AttendanceRecord>>(&arg1.user_attendances, arg0)) {
            return 0x1::vector::empty<AttendanceRecord>()
        };
        *0x2::table::borrow<address, vector<AttendanceRecord>>(&arg1.user_attendances, arg0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AttendanceRegistry{
            id                : 0x2::object::new(arg0),
            event_attendances : 0x2::table::new<0x2::object::ID, EventAttendance>(arg0),
            user_attendances  : 0x2::table::new<address, vector<AttendanceRecord>>(arg0),
        };
        0x2::transfer::share_object<AttendanceRegistry>(v0);
    }

    public fun verify_attendance_completion(arg0: address, arg1: 0x2::object::ID, arg2: &AttendanceRegistry) : bool {
        if (!0x2::table::contains<0x2::object::ID, EventAttendance>(&arg2.event_attendances, arg1)) {
            return false
        };
        let v0 = 0x2::table::borrow<0x2::object::ID, EventAttendance>(&arg2.event_attendances, arg1);
        if (!0x2::table::contains<address, AttendanceRecord>(&v0.records, arg0)) {
            return false
        };
        0x2::table::borrow<address, AttendanceRecord>(&v0.records, arg0).state == 2
    }

    // decompiled from Move bytecode v6
}

