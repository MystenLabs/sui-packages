module 0x2ebdd57d92437b696ce6b0e490c7d37010d3d7c5d347251cc91a4b84f7053d71::seaya_v2 {
    struct EventCreated has copy, drop {
        id: 0x2::object::ID,
        name: 0x1::string::String,
        host: address,
        ticket_price: u64,
    }

    struct EventEdited has copy, drop {
        id: 0x2::object::ID,
        name: 0x1::string::String,
        ticket_price: u64,
    }

    struct AttendeeRegistered has copy, drop {
        event_id: 0x2::object::ID,
        attendee: address,
    }

    struct EventTicket has store, key {
        id: 0x2::object::UID,
        event_id: 0x2::object::ID,
        attendee: address,
    }

    struct Event has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        location: 0x1::string::String,
        date: 0x1::string::String,
        host: address,
        ticket_price: u64,
        max_attendees: u64,
        attendees: vector<address>,
        status: u8,
        attendee_details: vector<Attendee>,
        funds: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct EventStatusChanged has copy, drop {
        id: 0x2::object::ID,
        new_status: u8,
    }

    struct RefundProcessed has copy, drop {
        event_id: 0x2::object::ID,
        attendee: address,
        amount: u64,
    }

    struct FundsWithdrawn has copy, drop {
        event_id: 0x2::object::ID,
        amount: u64,
    }

    struct Attendee has drop, store {
        addr: address,
        amount: u64,
        refunded: bool,
    }

    public fun cancel_event(arg0: &mut Event, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.host, 1);
        assert!(arg0.status == 0, 5);
        arg0.status = 2;
        let v0 = EventStatusChanged{
            id         : 0x2::object::uid_to_inner(&arg0.id),
            new_status : 2,
        };
        0x2::event::emit<EventStatusChanged>(v0);
    }

    public fun create_event(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = Event{
            id               : 0x2::object::new(arg6),
            name             : arg0,
            description      : arg1,
            location         : arg2,
            date             : arg3,
            host             : v0,
            ticket_price     : arg4,
            max_attendees    : arg5,
            attendees        : 0x1::vector::empty<address>(),
            status           : 0,
            attendee_details : 0x1::vector::empty<Attendee>(),
            funds            : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        let v2 = EventCreated{
            id           : 0x2::object::uid_to_inner(&v1.id),
            name         : arg0,
            host         : v0,
            ticket_price : arg4,
        };
        0x2::event::emit<EventCreated>(v2);
        0x2::transfer::share_object<Event>(v1);
    }

    public fun distribute_organizer_reward(arg0: &Event, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x883ec267a6986d4cefb71f712287f3d3649bac54a291251e3af7265647b86733, 10);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.host);
    }

    public fun edit_event(arg0: &mut Event, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg7) == arg0.host, 1);
        arg0.name = arg1;
        arg0.description = arg2;
        arg0.location = arg3;
        arg0.date = arg4;
        arg0.ticket_price = arg5;
        arg0.max_attendees = arg6;
        let v0 = EventEdited{
            id           : 0x2::object::uid_to_inner(&arg0.id),
            name         : arg1,
            ticket_price : arg5,
        };
        0x2::event::emit<EventEdited>(v0);
    }

    public fun end_event_and_withdraw(arg0: &mut Event, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.host, 1);
        assert!(arg0.status == 0, 5);
        arg0.status = 1;
        let v1 = EventStatusChanged{
            id         : 0x2::object::uid_to_inner(&arg0.id),
            new_status : 1,
        };
        0x2::event::emit<EventStatusChanged>(v1);
        let v2 = FundsWithdrawn{
            event_id : 0x2::object::uid_to_inner(&arg0.id),
            amount   : 0x2::balance::value<0x2::sui::SUI>(&arg0.funds),
        };
        0x2::event::emit<FundsWithdrawn>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.funds), arg1), v0);
    }

    fun find_attendee_index(arg0: &Event, arg1: address) : u64 {
        let v0 = 0;
        let v1 = 0x1::vector::length<Attendee>(&arg0.attendee_details);
        while (v0 < v1) {
            if (0x1::vector::borrow<Attendee>(&arg0.attendee_details, v0).addr == arg1) {
                return v0
            };
            v0 = v0 + 1;
        };
        v1
    }

    public fun get_total_funds(arg0: &Event) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.funds)
    }

    public fun hello_world() : 0x1::string::String {
        0x1::string::utf8(b"Hello from Seaya Contract!")
    }

    public fun is_attendee(arg0: &Event, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.attendees, &arg1)
    }

    public fun is_refunded(arg0: &Event, arg1: address) : bool {
        let v0 = find_attendee_index(arg0, arg1);
        v0 == 0x1::vector::length<Attendee>(&arg0.attendee_details) && false || 0x1::vector::borrow<Attendee>(&arg0.attendee_details, v0).refunded
    }

    public fun register_for_event(arg0: &mut Event, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 5);
        assert!(0x1::vector::length<address>(&arg0.attendees) < arg0.max_attendees, 2);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(!0x1::vector::contains<address>(&arg0.attendees, &v0), 3);
        0x1::vector::push_back<address>(&mut arg0.attendees, v0);
        let v1 = Attendee{
            addr     : v0,
            amount   : 0,
            refunded : false,
        };
        0x1::vector::push_back<Attendee>(&mut arg0.attendee_details, v1);
        let v2 = EventTicket{
            id       : 0x2::object::new(arg1),
            event_id : 0x2::object::uid_to_inner(&arg0.id),
            attendee : v0,
        };
        let v3 = AttendeeRegistered{
            event_id : 0x2::object::uid_to_inner(&arg0.id),
            attendee : v0,
        };
        0x2::event::emit<AttendeeRegistered>(v3);
        0x2::transfer::transfer<EventTicket>(v2, v0);
    }

    public fun register_with_any_coin<T0>(arg0: &mut Event, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 5);
        assert!(0x1::vector::length<address>(&arg0.attendees) < arg0.max_attendees, 2);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(!0x1::vector::contains<address>(&arg0.attendees, &v0), 3);
        let v1 = 0x2::coin::value<T0>(&arg1);
        assert!(v1 >= arg0.ticket_price, 4);
        0x1::vector::push_back<address>(&mut arg0.attendees, v0);
        let v2 = Attendee{
            addr     : v0,
            amount   : v1,
            refunded : false,
        };
        0x1::vector::push_back<Attendee>(&mut arg0.attendee_details, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg0.host);
        let v3 = EventTicket{
            id       : 0x2::object::new(arg2),
            event_id : 0x2::object::uid_to_inner(&arg0.id),
            attendee : v0,
        };
        let v4 = AttendeeRegistered{
            event_id : 0x2::object::uid_to_inner(&arg0.id),
            attendee : v0,
        };
        0x2::event::emit<AttendeeRegistered>(v4);
        0x2::transfer::transfer<EventTicket>(v3, v0);
    }

    public fun register_with_fee(arg0: &mut Event, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 5);
        assert!(0x1::vector::length<address>(&arg0.attendees) < arg0.max_attendees, 2);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(!0x1::vector::contains<address>(&arg0.attendees, &v0), 3);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v1 >= arg0.ticket_price, 4);
        0x1::vector::push_back<address>(&mut arg0.attendees, v0);
        let v2 = Attendee{
            addr     : v0,
            amount   : v1,
            refunded : false,
        };
        0x1::vector::push_back<Attendee>(&mut arg0.attendee_details, v2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.funds, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v3 = EventTicket{
            id       : 0x2::object::new(arg2),
            event_id : 0x2::object::uid_to_inner(&arg0.id),
            attendee : v0,
        };
        let v4 = AttendeeRegistered{
            event_id : 0x2::object::uid_to_inner(&arg0.id),
            attendee : v0,
        };
        0x2::event::emit<AttendeeRegistered>(v4);
        0x2::transfer::transfer<EventTicket>(v3, v0);
    }

    public fun request_refund(arg0: &mut Event, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 2, 7);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x1::vector::contains<address>(&arg0.attendees, &v0), 8);
        let v1 = 0x1::vector::borrow_mut<Attendee>(&mut arg0.attendee_details, find_attendee_index(arg0, v0));
        assert!(!v1.refunded, 9);
        v1.refunded = true;
        let v2 = v1.amount;
        let v3 = RefundProcessed{
            event_id : 0x2::object::uid_to_inner(&arg0.id),
            attendee : v0,
            amount   : v2,
        };
        0x2::event::emit<RefundProcessed>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.funds, v2), arg1), v0);
    }

    // decompiled from Move bytecode v6
}

