module 0xdcce259374ee87d79da1ce4f43a6eb96804a57f8a510c4d653ec4f523c7c6db4::event_registry {
    struct EventInfo has store, key {
        id: 0x2::object::UID,
        organizer: address,
        walrus_blob_id: 0x1::string::String,
        capacity: u64,
        num_tickets_sold: u64,
        status: u8,
        created_at: u64,
        updated_at: u64,
        attendees: 0x2::table::Table<address, bool>,
        policy_id: 0x2::object::ID,
        policy_cap_id: 0x2::object::ID,
    }

    struct EventCreated has copy, drop {
        event_id: address,
        organizer: address,
        walrus_blob_id: 0x1::string::String,
        capacity: u64,
    }

    struct EventUpdated has copy, drop {
        event_id: address,
        updated_by: address,
    }

    struct EventStatusChanged has copy, drop {
        event_id: address,
        old_status: u8,
        new_status: u8,
        changed_by: address,
    }

    public entry fun create_event(arg0: vector<u8>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = 0x2::object::new(arg3);
        let v3 = 0x2::object::uid_to_address(&v2);
        let v4 = 0xdcce259374ee87d79da1ce4f43a6eb96804a57f8a510c4d653ec4f523c7c6db4::ticket_seal::create_policy(v3, arg3);
        let v5 = EventInfo{
            id               : v2,
            organizer        : v0,
            walrus_blob_id   : 0x1::string::utf8(arg0),
            capacity         : arg1,
            num_tickets_sold : 0,
            status           : 0,
            created_at       : v1,
            updated_at       : v1,
            attendees        : 0x2::table::new<address, bool>(arg3),
            policy_id        : 0xdcce259374ee87d79da1ce4f43a6eb96804a57f8a510c4d653ec4f523c7c6db4::ticket_seal::get_policy_id(&v4),
            policy_cap_id    : 0x2::object::id<0xdcce259374ee87d79da1ce4f43a6eb96804a57f8a510c4d653ec4f523c7c6db4::ticket_seal::PolicyCap>(&v4),
        };
        let v6 = EventCreated{
            event_id       : v3,
            organizer      : v0,
            walrus_blob_id : v5.walrus_blob_id,
            capacity       : arg1,
        };
        0x2::event::emit<EventCreated>(v6);
        0x2::transfer::public_transfer<0xdcce259374ee87d79da1ce4f43a6eb96804a57f8a510c4d653ec4f523c7c6db4::ticket_seal::PolicyCap>(v4, v0);
        0x2::transfer::share_object<EventInfo>(v5);
    }

    public fun get_capacity(arg0: &EventInfo) : u64 {
        arg0.capacity
    }

    public fun get_organizer(arg0: &EventInfo) : address {
        arg0.organizer
    }

    public fun get_policy_cap_id(arg0: &EventInfo) : 0x2::object::ID {
        arg0.policy_cap_id
    }

    public fun get_policy_id(arg0: &EventInfo) : 0x2::object::ID {
        arg0.policy_id
    }

    public fun get_status(arg0: &EventInfo) : u8 {
        arg0.status
    }

    public fun get_tickets_sold(arg0: &EventInfo) : u64 {
        arg0.num_tickets_sold
    }

    public(friend) fun has_registered(arg0: &EventInfo, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.attendees, arg1)
    }

    public(friend) fun increment_tickets_sold(arg0: &mut EventInfo) {
        assert!(arg0.num_tickets_sold < arg0.capacity, 1003);
        arg0.num_tickets_sold = arg0.num_tickets_sold + 1;
    }

    public fun is_active(arg0: &EventInfo) : bool {
        arg0.status == 0
    }

    public fun is_organizer(arg0: &EventInfo, arg1: address) : bool {
        arg0.organizer == arg1
    }

    public(friend) fun mark_registered(arg0: &mut EventInfo, arg1: address) {
        0x2::table::add<address, bool>(&mut arg0.attendees, arg1, true);
    }

    public entry fun set_status(arg0: &mut EventInfo, arg1: u8, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.organizer, 1000);
        assert!(arg1 <= 3, 1002);
        arg0.status = arg1;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg2);
        let v1 = EventStatusChanged{
            event_id   : 0x2::object::uid_to_address(&arg0.id),
            old_status : arg0.status,
            new_status : arg1,
            changed_by : v0,
        };
        0x2::event::emit<EventStatusChanged>(v1);
    }

    public entry fun update_event(arg0: &mut EventInfo, arg1: vector<u8>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == arg0.organizer, 1000);
        assert!(arg0.status != 2 && arg0.status != 3, 1001);
        arg0.walrus_blob_id = 0x1::string::utf8(arg1);
        arg0.capacity = arg2;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg3);
        let v1 = EventUpdated{
            event_id   : 0x2::object::uid_to_address(&arg0.id),
            updated_by : v0,
        };
        0x2::event::emit<EventUpdated>(v1);
    }

    // decompiled from Move bytecode v6
}

