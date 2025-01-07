module 0xbfec71e0f811e27d3393b0470941fe3da85df8c7df8497d5538cc758f90cb2ef::event {
    struct SuiVer has key {
        id: 0x2::object::UID,
        version: 0x1::string::String,
        description: 0x1::string::String,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Event has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        cover_url: 0x1::string::String,
        created_at: 0x1::string::String,
        start_at: 0x1::string::String,
        end_at: 0x1::string::String,
        time_zone: 0x1::string::String,
    }

    struct Ticket has store, key {
        id: 0x2::object::UID,
        event_id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct Host has store {
        name: 0x1::string::String,
        owner: address,
        avatar_url: 0x1::string::String,
        bio_short: 0x1::string::String,
        website: 0x1::string::String,
        instagram_handle: 0x1::string::String,
        linkedin_handle: 0x1::string::String,
        tiktok_handle: 0x1::string::String,
        twitter_handle: 0x1::string::String,
        youtube_handle: 0x1::string::String,
        timezone: 0x1::string::String,
    }

    struct Location has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
    }

    struct EventTicket has store, key {
        id: 0x2::object::UID,
        price: u32,
        is_sold_out: bool,
        spots_remaining: u32,
        is_near_capacity: bool,
        ticket_currency: 0x1::string::String,
        total: u32,
    }

    struct NewEventEvent has copy, drop {
        event_id: 0x2::object::ID,
        owner: address,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = SuiVer{
            id          : 0x2::object::new(arg0),
            version     : 0x1::string::utf8(b"1.0"),
            description : 0x1::string::utf8(b"suiver"),
        };
        0x2::transfer::share_object<SuiVer>(v1);
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun new_event(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u32, arg7: 0x1::string::String, arg8: u32, arg9: 0x1::string::String, arg10: &mut SuiVer, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg11)};
        let v1 = Event{
            id         : 0x2::object::new(arg11),
            name       : arg0,
            cover_url  : arg1,
            created_at : arg2,
            start_at   : arg3,
            end_at     : arg4,
            time_zone  : arg5,
        };
        let v2 = EventTicket{
            id               : 0x2::object::new(arg11),
            price            : arg6,
            is_sold_out      : false,
            spots_remaining  : arg8,
            is_near_capacity : false,
            ticket_currency  : arg7,
            total            : arg8,
        };
        0x2::dynamic_object_field::add<vector<u8>, EventTicket>(&mut v1.id, b"ticket_info", v2);
        let v3 = Location{
            id   : 0x2::object::new(arg11),
            name : arg9,
        };
        0x2::dynamic_object_field::add<vector<u8>, Location>(&mut v1.id, b"location", v3);
        0x2::dynamic_object_field::add<0x2::object::ID, Event>(&mut arg10.id, 0x2::object::uid_to_inner(&v1.id), v1);
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg11));
    }

    public entry fun new_ticket(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::ascii::String, arg3: 0x2::object::ID, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Ticket{
            id          : 0x2::object::new(arg5),
            event_id    : arg3,
            name        : arg0,
            description : arg1,
            url         : 0x2::url::new_unsafe(arg2),
        };
        0x2::transfer::public_transfer<Ticket>(v0, 0x2::tx_context::sender(arg5));
    }

    public entry fun send_ticket(arg0: address, arg1: Ticket, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<Ticket>(arg1, arg0);
    }

    // decompiled from Move bytecode v6
}

