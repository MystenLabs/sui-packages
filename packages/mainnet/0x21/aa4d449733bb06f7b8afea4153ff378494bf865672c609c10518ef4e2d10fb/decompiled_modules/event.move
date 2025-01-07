module 0x21aa4d449733bb06f7b8afea4153ff378494bf865672c609c10518ef4e2d10fb::event {
    struct EVENT has drop {
        dummy_field: bool,
    }

    struct EventOrganizerCap has store, key {
        id: 0x2::object::UID,
        event_id: address,
    }

    struct NftEvent has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_uri: 0x1::string::String,
        properties: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct Event has key {
        id: 0x2::object::UID,
        event_nft_id: address,
        creator: address,
        n_tickets: u32,
        start_time: u64,
        end_time: u64,
        resale_cap_bps: u16,
        royalty_bps: u16,
        event_capacity: EventCapacity,
        ticket_types: vector<TicketType>,
    }

    struct EventCapacity has store {
        tickets_sold: u32,
        seats: 0x21aa4d449733bb06f7b8afea4153ff378494bf865672c609c10518ef4e2d10fb::bitmap::Bitmap,
    }

    struct SeatRange has store {
        from: u64,
        to: u64,
    }

    struct TicketType has store {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        mt_root: vector<u8>,
        n_tickets: u32,
        sale_start_time: u64,
        sale_end_time: u64,
        seat_range: SeatRange,
    }

    struct EventCreated has copy, drop {
        id: address,
        creator: address,
    }

    struct EventNftCreated has copy, drop {
        id: address,
        creator: address,
    }

    public fun add_sale_type<T0: store>(arg0: T0, arg1: &mut Event, arg2: u64, arg3: &0x2::clock::Clock) {
        let v0 = 0x1::vector::borrow_mut<TicketType>(&mut arg1.ticket_types, arg2);
        assert_add_sale_type(arg1.start_time, v0, arg3);
        0x2::dynamic_field::add<vector<u8>, T0>(&mut v0.id, b"sale_type", arg0);
    }

    public fun add_ticket_types(arg0: vector<0x1::string::String>, arg1: vector<vector<u8>>, arg2: vector<u32>, arg3: vector<u64>, arg4: vector<u64>, arg5: vector<vector<u64>>, arg6: &mut Event, arg7: &EventOrganizerCap, arg8: &mut 0x2::tx_context::TxContext) : vector<address> {
        assert!(0x1::vector::length<TicketType>(&arg6.ticket_types) == 0, 2);
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg0)) {
            let v2 = *0x1::vector::borrow<u64>(&arg3, v1);
            let v3 = *0x1::vector::borrow<u64>(&arg4, v1);
            let v4 = *0x1::vector::borrow<vector<u8>>(&arg1, v1);
            let v5 = *0x1::vector::borrow<vector<u64>>(&arg5, v1);
            let v6 = SeatRange{
                from : *0x1::vector::borrow<u64>(&v5, 0),
                to   : *0x1::vector::borrow<u64>(&v5, 1),
            };
            assert!(v2 < v3, 0);
            assert!(0x1::vector::length<u8>(&v4) == 32, 1);
            let v7 = 0x2::object::new(arg8);
            0x1::vector::push_back<address>(&mut v0, 0x2::object::uid_to_address(&v7));
            let v8 = TicketType{
                id              : v7,
                name            : *0x1::vector::borrow<0x1::string::String>(&arg0, v1),
                mt_root         : v4,
                n_tickets       : *0x1::vector::borrow<u32>(&arg2, v1),
                sale_start_time : v2,
                sale_end_time   : v3,
                seat_range      : v6,
            };
            0x1::vector::push_back<TicketType>(&mut arg6.ticket_types, v8);
            v1 = v1 + 1;
        };
        v0
    }

    fun assert_add_sale_type(arg0: u64, arg1: &TicketType, arg2: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg2) < arg0, 4);
        assert!(!0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, b"sale_type"), 3);
    }

    public(friend) fun create_event(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: u32, arg6: u64, arg7: u64, arg8: u16, arg9: u16, arg10: &mut 0x2::tx_context::TxContext) : address {
        let v0 = 0x2::object::new(arg10);
        let v1 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::string::String>(&arg3)) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v1, 0x1::vector::pop_back<0x1::string::String>(&mut arg3), 0x1::vector::pop_back<0x1::string::String>(&mut arg4));
            v2 = v2 + 1;
        };
        let v3 = NftEvent{
            id          : 0x2::object::new(arg10),
            name        : arg0,
            description : arg1,
            image_uri   : arg2,
            properties  : v1,
        };
        let v4 = 0x2::tx_context::sender(arg10);
        let v5 = create_event_capacity(arg10);
        let v6 = Event{
            id             : v0,
            event_nft_id   : 0x2::object::uid_to_address(&v3.id),
            creator        : v4,
            n_tickets      : arg5,
            start_time     : arg6,
            end_time       : arg7,
            resale_cap_bps : arg8,
            royalty_bps    : arg9,
            event_capacity : v5,
            ticket_types   : 0x1::vector::empty<TicketType>(),
        };
        let v7 = EventOrganizerCap{
            id       : 0x2::object::new(arg10),
            event_id : 0x2::object::uid_to_address(&v6.id),
        };
        let v8 = 0x2::object::uid_to_address(&v6.id);
        let v9 = EventCreated{
            id      : v8,
            creator : v4,
        };
        0x2::event::emit<EventCreated>(v9);
        let v10 = EventNftCreated{
            id      : 0x2::object::uid_to_address(&v3.id),
            creator : v4,
        };
        0x2::event::emit<EventNftCreated>(v10);
        0x2::transfer::share_object<Event>(v6);
        0x2::transfer::transfer<NftEvent>(v3, v4);
        0x2::transfer::transfer<EventOrganizerCap>(v7, v4);
        v8
    }

    fun create_event_capacity(arg0: &mut 0x2::tx_context::TxContext) : EventCapacity {
        EventCapacity{
            tickets_sold : 0,
            seats        : 0x21aa4d449733bb06f7b8afea4153ff378494bf865672c609c10518ef4e2d10fb::bitmap::empty(arg0),
        }
    }

    public fun get_available_seats(arg0: &Event) : u32 {
        arg0.n_tickets - arg0.event_capacity.tickets_sold
    }

    public fun get_event_creator(arg0: &Event) : address {
        arg0.creator
    }

    public fun get_event_id(arg0: &Event) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public(friend) fun get_event_organizer_cap_event_id(arg0: &EventOrganizerCap) : address {
        arg0.event_id
    }

    public fun get_resale_cap_bps(arg0: &Event) : u16 {
        arg0.resale_cap_bps
    }

    public fun get_royalty_bps(arg0: &Event) : u16 {
        arg0.royalty_bps
    }

    public fun get_sale_type<T0: store>(arg0: &Event, arg1: u64) : &T0 {
        0x2::dynamic_field::borrow<vector<u8>, T0>(&0x1::vector::borrow<TicketType>(&arg0.ticket_types, arg1).id, b"sale_type")
    }

    public fun get_seat_range(arg0: &TicketType) : (u64, u64) {
        (arg0.seat_range.from, arg0.seat_range.to)
    }

    public fun get_seats(arg0: &Event) : &0x21aa4d449733bb06f7b8afea4153ff378494bf865672c609c10518ef4e2d10fb::bitmap::Bitmap {
        &arg0.event_capacity.seats
    }

    public fun get_ticket_type(arg0: &Event, arg1: u64) : &TicketType {
        0x1::vector::borrow<TicketType>(&arg0.ticket_types, arg1)
    }

    public fun get_ticket_type_id(arg0: &TicketType) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun get_ticket_type_mt_root(arg0: &TicketType) : &vector<u8> {
        &arg0.mt_root
    }

    public fun get_ticket_type_sale_time(arg0: &TicketType) : (u64, u64) {
        (arg0.sale_start_time, arg0.sale_end_time)
    }

    public fun has_ticket_type(arg0: &Event, arg1: &address) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<TicketType>(&arg0.ticket_types)) {
            let v1 = 0x2::object::uid_to_address(&0x1::vector::borrow<TicketType>(&arg0.ticket_types, v0).id);
            if (&v1 == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public(friend) fun increment_tickets_sold(arg0: &mut Event) {
        arg0.event_capacity.tickets_sold = arg0.event_capacity.tickets_sold + 1;
    }

    fun init(arg0: EVENT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"Name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"Description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"Image Uri"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"Link"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"Creator"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"Resale Cap BPS"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"Roaylty BPS"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_uri}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://app.ticketland/events/{id}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x2::address::to_string(v0));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{resale_cap_bps}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{royalty_bps}"));
        let v5 = 0x2::package::claim<EVENT>(arg0, arg1);
        let v6 = 0x2::display::new_with_fields<NftEvent>(&v5, v1, v3, arg1);
        0x2::display::update_version<NftEvent>(&mut v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, v0);
        0x2::transfer::public_transfer<0x2::display::Display<NftEvent>>(v6, v0);
    }

    public fun is_event_ticket_type(arg0: &Event, arg1: address) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<TicketType>(&arg0.ticket_types)) {
            if (0x2::object::uid_to_address(&0x1::vector::borrow<TicketType>(&arg0.ticket_types, v0).id) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public(friend) fun update_seats(arg0: &mut Event, arg1: u64) {
        0x21aa4d449733bb06f7b8afea4153ff378494bf865672c609c10518ef4e2d10fb::bitmap::flip_bit(&mut arg0.event_capacity.seats, arg1);
    }

    // decompiled from Move bytecode v6
}

