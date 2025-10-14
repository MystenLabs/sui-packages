module 0x20ac194de89c0c2535fd1c7ad7ee002072008cefcc9ac4e4a662f8f5afa79505::presana {
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
        pending_payments: 0x2::vec_map::VecMap<address, 0x2::balance::Balance<0x2::sui::SUI>>,
        event_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        created_at: u64,
        updated_at: u64,
        checked_in_attendees: 0x2::vec_set::VecSet<address>,
    }

    struct EventNFT has store, key {
        id: 0x2::object::UID,
        event_id: 0x2::object::ID,
        event_name: 0x1::string::String,
        event_image: 0x1::string::String,
        event_date: u64,
        event_location: 0x1::string::String,
        minted_by: address,
    }

    struct EventPOAP has store, key {
        id: 0x2::object::UID,
        event_id: 0x2::object::ID,
        event_name: 0x1::string::String,
        event_description: 0x1::string::String,
        event_image: 0x1::string::String,
        event_date: u64,
        event_location: 0x1::string::String,
        claimed_by: address,
        claimed_at: u64,
    }

    struct SuperAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct EventOrganizerCap has store, key {
        id: 0x2::object::UID,
        event_id: 0x2::object::ID,
        event_end_ms: u64,
    }

    struct EventRegistry has key {
        id: 0x2::object::UID,
        total_events: u64,
        events: 0x2::vec_map::VecMap<0x2::object::ID, Event>,
        events_by_creator: 0x2::vec_map::VecMap<address, 0x2::vec_set::VecSet<0x2::object::ID>>,
        events_by_category: 0x2::vec_map::VecMap<0x1::string::String, 0x2::vec_set::VecSet<0x2::object::ID>>,
        active_events: 0x2::vec_set::VecSet<0x2::object::ID>,
        featured_events: 0x2::vec_set::VecSet<0x2::object::ID>,
        total_attendees: u64,
        total_nfts_minted: u64,
        total_poaps_claimed: u64,
        platform_fee_bps: u64,
        platform_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        admin: address,
        created_at: u64,
    }

    struct EventCreated has copy, drop {
        event_id: 0x2::object::ID,
        creator: address,
        title: 0x1::string::String,
        start_date: u64,
        is_free: bool,
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

    struct EventNFTMinted has copy, drop {
        nft_id: 0x2::object::ID,
        event_id: 0x2::object::ID,
        minter: address,
    }

    struct EventPOAPMinted has copy, drop {
        poap_id: 0x2::object::ID,
        event_id: 0x2::object::ID,
        claimer: address,
    }

    struct UserRegistered has copy, drop {
        event_id: 0x2::object::ID,
        attendee: address,
        payment_amount: u64,
        requires_approval: bool,
        registered_at: u64,
    }

    struct RegistrationApproved has copy, drop {
        event_id: 0x2::object::ID,
        attendee: address,
        approved_by: address,
    }

    struct RegistrationRejected has copy, drop {
        event_id: 0x2::object::ID,
        attendee: address,
        rejected_by: address,
    }

    struct UserCheckedIn has copy, drop {
        event_id: 0x2::object::ID,
        attendee: address,
        checked_in_at: u64,
    }

    struct PRESANA has drop {
        dummy_field: bool,
    }

    public fun id(arg0: &EventNFT) : &0x2::object::UID {
        &arg0.id
    }

    public fun active_events(arg0: &EventRegistry) : &0x2::vec_set::VecSet<0x2::object::ID> {
        &arg0.active_events
    }

    public fun admin(arg0: &EventRegistry) : address {
        arg0.admin
    }

    public fun approve_registration(arg0: &mut EventRegistry, arg1: 0x2::object::ID, arg2: address, arg3: &EventOrganizerCap, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::vec_map::contains<0x2::object::ID, Event>(&arg0.events, &arg1), 0);
        let v0 = 0x2::vec_map::get_mut<0x2::object::ID, Event>(&mut arg0.events, &arg1);
        assert!(v0.creator == 0x2::tx_context::sender(arg5), 5);
        assert!(arg3.event_id == arg1, 5);
        assert!(0x2::vec_set::contains<address>(&v0.pending_approvals, &arg2), 6);
        0x2::vec_set::remove<address>(&mut v0.pending_approvals, &arg2);
        0x2::vec_set::insert<address>(&mut v0.attendees, arg2);
        0x2::vec_set::insert<address>(&mut v0.approved_attendees, arg2);
        v0.updated_at = 0x2::clock::timestamp_ms(arg4);
        let v1 = RegistrationApproved{
            event_id    : arg1,
            attendee    : arg2,
            approved_by : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<RegistrationApproved>(v1);
    }

    public fun approved_attendees(arg0: &Event) : 0x2::vec_set::VecSet<address> {
        arg0.approved_attendees
    }

    public fun attendees(arg0: &Event) : 0x2::vec_set::VecSet<address> {
        arg0.attendees
    }

    public fun banner_url(arg0: &Event) : 0x1::string::String {
        arg0.banner_url
    }

    public fun cancel_event(arg0: &mut EventRegistry, arg1: 0x2::object::ID, arg2: &EventOrganizerCap, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::vec_map::contains<0x2::object::ID, Event>(&arg0.events, &arg1), 0);
        let v0 = 0x2::vec_map::get_mut<0x2::object::ID, Event>(&mut arg0.events, &arg1);
        assert!(v0.creator == 0x2::tx_context::sender(arg4), 5);
        assert!(arg2.event_id == arg1, 5);
        assert!(v0.is_active, 1);
        v0.is_active = false;
        let v1 = 0;
        let v2 = 0x2::vec_map::keys<address, 0x2::balance::Balance<0x2::sui::SUI>>(&v0.pending_payments);
        while (v1 < 0x1::vector::length<address>(&v2)) {
            let v3 = *0x1::vector::borrow<address>(&v2, v1);
            let (_, v5) = 0x2::vec_map::remove<address, 0x2::balance::Balance<0x2::sui::SUI>>(&mut v0.pending_payments, &v3);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v5, arg4), v3);
            v1 = v1 + 1;
        };
        v0.updated_at = 0x2::clock::timestamp_ms(arg3);
        let v6 = EventCancelled{
            event_id      : arg1,
            creator       : 0x2::tx_context::sender(arg4),
            refund_amount : v0.ticket_price,
        };
        0x2::event::emit<EventCancelled>(v6);
    }

    public fun capacity(arg0: &Event) : 0x1::option::Option<u64> {
        arg0.capacity
    }

    public fun category(arg0: &Event) : 0x1::string::String {
        arg0.category
    }

    public fun check_in(arg0: &mut EventRegistry, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::vec_map::contains<0x2::object::ID, Event>(&arg0.events, &arg1), 0);
        let v0 = 0x2::vec_map::get_mut<0x2::object::ID, Event>(&mut arg0.events, &arg1);
        assert!(v0.is_active, 1);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(0x2::vec_set::contains<address>(&v0.attendees, &v1), 5);
        if (v0.requires_approval) {
            assert!(0x2::vec_set::contains<address>(&v0.approved_attendees, &v1), 5);
        };
        assert!(!0x2::vec_set::contains<address>(&v0.checked_in_attendees, &v1), 3);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        assert!(v2 >= v0.start_date, 5);
        assert!(v2 <= v0.end_date, 5);
        0x2::vec_set::insert<address>(&mut v0.checked_in_attendees, v1);
        let v3 = UserCheckedIn{
            event_id      : arg1,
            attendee      : v1,
            checked_in_at : v2,
        };
        0x2::event::emit<UserCheckedIn>(v3);
    }

    public fun checked_in_attendees(arg0: &Event) : &0x2::vec_set::VecSet<address> {
        &arg0.checked_in_attendees
    }

    public fun claimed_at(arg0: &EventPOAP) : u64 {
        arg0.claimed_at
    }

    public fun claimed_by(arg0: &EventPOAP) : address {
        arg0.claimed_by
    }

    public fun create_event(arg0: &mut EventRegistry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: u64, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::option::Option<u64>, arg11: u64, arg12: bool, arg13: bool, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        let v0 = Event{
            id                   : 0x2::object::new(arg15),
            creator              : 0x2::tx_context::sender(arg15),
            title                : arg1,
            description          : arg2,
            banner_url           : arg3,
            nft_image_url        : arg4,
            poap_image_url       : arg5,
            start_date           : arg6,
            end_date             : arg7,
            location             : arg8,
            category             : arg9,
            capacity             : arg10,
            ticket_price         : arg11,
            is_free              : arg11 == 0,
            requires_approval    : arg12,
            is_private           : arg13,
            is_active            : true,
            attendees            : 0x2::vec_set::empty<address>(),
            approved_attendees   : 0x2::vec_set::empty<address>(),
            pending_approvals    : 0x2::vec_set::empty<address>(),
            pending_payments     : 0x2::vec_map::empty<address, 0x2::balance::Balance<0x2::sui::SUI>>(),
            event_balance        : 0x2::balance::zero<0x2::sui::SUI>(),
            created_at           : 0x2::clock::timestamp_ms(arg14),
            updated_at           : 0x2::clock::timestamp_ms(arg14),
            checked_in_attendees : 0x2::vec_set::empty<address>(),
        };
        let v1 = EventOrganizerCap{
            id           : 0x2::object::new(arg15),
            event_id     : 0x2::object::id<Event>(&v0),
            event_end_ms : v0.end_date,
        };
        let v2 = EventCreated{
            event_id   : 0x2::object::id<Event>(&v0),
            creator    : 0x2::tx_context::sender(arg15),
            title      : v0.title,
            start_date : v0.start_date,
            is_free    : v0.is_free,
        };
        0x2::event::emit<EventCreated>(v2);
        let v3 = 0x2::object::id<Event>(&v0);
        let v4 = v0.creator;
        let v5 = 0x2::vec_map::try_get<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.events_by_creator, &v4);
        if (0x1::option::is_some<0x2::vec_set::VecSet<0x2::object::ID>>(&v5)) {
            0x2::vec_set::insert<0x2::object::ID>(0x2::vec_map::get_mut<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.events_by_creator, &v4), v3);
        } else {
            let v6 = 0x2::vec_set::empty<0x2::object::ID>();
            0x2::vec_set::insert<0x2::object::ID>(&mut v6, v3);
            0x2::vec_map::insert<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.events_by_creator, v4, v6);
        };
        let v7 = v0.category;
        let v8 = 0x2::vec_map::try_get<0x1::string::String, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.events_by_category, &v7);
        if (0x1::option::is_some<0x2::vec_set::VecSet<0x2::object::ID>>(&v8)) {
            0x2::vec_set::insert<0x2::object::ID>(0x2::vec_map::get_mut<0x1::string::String, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.events_by_category, &v7), v3);
        } else {
            let v9 = 0x2::vec_set::empty<0x2::object::ID>();
            0x2::vec_set::insert<0x2::object::ID>(&mut v9, v3);
            0x2::vec_map::insert<0x1::string::String, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.events_by_category, v7, v9);
        };
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.active_events, v3);
        arg0.total_events = arg0.total_events + 1;
        0x2::vec_map::insert<0x2::object::ID, Event>(&mut arg0.events, v3, v0);
        0x2::transfer::public_transfer<EventOrganizerCap>(v1, 0x2::tx_context::sender(arg15));
    }

    public fun created_at(arg0: &Event) : u64 {
        arg0.created_at
    }

    public fun creator(arg0: &Event) : address {
        arg0.creator
    }

    public fun description(arg0: &Event) : 0x1::string::String {
        arg0.description
    }

    public fun end_date(arg0: &Event) : u64 {
        arg0.end_date
    }

    public fun event_balance(arg0: &Event) : &0x2::balance::Balance<0x2::sui::SUI> {
        &arg0.event_balance
    }

    public fun event_date(arg0: &EventNFT) : u64 {
        arg0.event_date
    }

    public fun event_description(arg0: &EventPOAP) : &0x1::string::String {
        &arg0.event_description
    }

    public fun event_end_ms(arg0: &EventOrganizerCap) : u64 {
        arg0.event_end_ms
    }

    public fun event_id(arg0: &EventNFT) : &0x2::object::ID {
        &arg0.event_id
    }

    public fun event_image(arg0: &EventNFT) : &0x1::string::String {
        &arg0.event_image
    }

    public fun event_location(arg0: &EventNFT) : &0x1::string::String {
        &arg0.event_location
    }

    public fun event_name(arg0: &EventNFT) : &0x1::string::String {
        &arg0.event_name
    }

    public fun event_organizer_cap_id(arg0: &EventOrganizerCap) : &0x2::object::UID {
        &arg0.id
    }

    public fun event_registry_created_at(arg0: &EventRegistry) : u64 {
        arg0.created_at
    }

    public fun event_registry_id(arg0: &EventRegistry) : &0x2::object::UID {
        &arg0.id
    }

    public fun events(arg0: &EventRegistry) : &0x2::vec_map::VecMap<0x2::object::ID, Event> {
        &arg0.events
    }

    public fun events_by_category(arg0: &EventRegistry) : &0x2::vec_map::VecMap<0x1::string::String, 0x2::vec_set::VecSet<0x2::object::ID>> {
        &arg0.events_by_category
    }

    public fun events_by_creator(arg0: &EventRegistry) : &0x2::vec_map::VecMap<address, 0x2::vec_set::VecSet<0x2::object::ID>> {
        &arg0.events_by_creator
    }

    public fun featured_events(arg0: &EventRegistry) : &0x2::vec_set::VecSet<0x2::object::ID> {
        &arg0.featured_events
    }

    fun init(arg0: PRESANA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<PRESANA>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"event_date"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"event_location"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{event_name} - Event NFT "));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Commemorative NFT for attending {event_name}. This NFT proves your participation in this event on the Presana platform."));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{event_image}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://presana.xyz/event/{event_id}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Presana"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{event_date}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{event_location}"));
        let v5 = 0x2::display::new_with_fields<EventNFT>(&v0, v1, v3, arg1);
        0x2::display::update_version<EventNFT>(&mut v5);
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"event_date"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"event_location"));
        let v8 = 0x1::vector::empty<0x1::string::String>();
        let v9 = &mut v8;
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"{event_name} - POAP"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"Proof of Attendance Protocol NFT for {event_name}. {event_description}"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"{event_image}"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"https://suilens.xyz/event/{event_id}"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"Presana"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"{event_date}"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"{event_location}"));
        let v10 = 0x2::display::new_with_fields<EventPOAP>(&v0, v6, v8, arg1);
        0x2::display::update_version<EventPOAP>(&mut v10);
        let v11 = SuperAdminCap{id: 0x2::object::new(arg1)};
        let v12 = EventRegistry{
            id                  : 0x2::object::new(arg1),
            total_events        : 0,
            events              : 0x2::vec_map::empty<0x2::object::ID, Event>(),
            events_by_creator   : 0x2::vec_map::empty<address, 0x2::vec_set::VecSet<0x2::object::ID>>(),
            events_by_category  : 0x2::vec_map::empty<0x1::string::String, 0x2::vec_set::VecSet<0x2::object::ID>>(),
            active_events       : 0x2::vec_set::empty<0x2::object::ID>(),
            featured_events     : 0x2::vec_set::empty<0x2::object::ID>(),
            total_attendees     : 0,
            total_nfts_minted   : 0,
            total_poaps_claimed : 0,
            platform_fee_bps    : 250,
            platform_balance    : 0x2::balance::zero<0x2::sui::SUI>(),
            admin               : @0x17c9ba64e43dbb64c57c33bf10f9b3807f8bfcf29990d477cbb54d18a19de81e,
            created_at          : 0x2::tx_context::epoch_timestamp_ms(arg1),
        };
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<EventNFT>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<EventPOAP>>(v10, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<SuperAdminCap>(v11, @0x17c9ba64e43dbb64c57c33bf10f9b3807f8bfcf29990d477cbb54d18a19de81e);
        0x2::transfer::share_object<EventRegistry>(v12);
    }

    public fun is_active(arg0: &Event) : bool {
        arg0.is_active
    }

    public fun is_free(arg0: &Event) : bool {
        arg0.is_free
    }

    public fun is_private(arg0: &Event) : bool {
        arg0.is_private
    }

    public fun location(arg0: &Event) : 0x1::string::String {
        arg0.location
    }

    public fun mint_event_nft(arg0: &mut EventRegistry, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::vec_map::contains<0x2::object::ID, Event>(&arg0.events, &arg1), 0);
        let v0 = 0x2::vec_map::get<0x2::object::ID, Event>(&arg0.events, &arg1);
        let v1 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_set::contains<address>(&v0.attendees, &v1), 5);
        let v2 = EventNFT{
            id             : 0x2::object::new(arg2),
            event_id       : arg1,
            event_name     : v0.title,
            event_image    : v0.nft_image_url,
            event_date     : v0.start_date,
            event_location : v0.location,
            minted_by      : v1,
        };
        arg0.total_nfts_minted = arg0.total_nfts_minted + 1;
        let v3 = EventNFTMinted{
            nft_id   : 0x2::object::id<EventNFT>(&v2),
            event_id : arg1,
            minter   : v1,
        };
        0x2::event::emit<EventNFTMinted>(v3);
        0x2::transfer::public_transfer<EventNFT>(v2, v1);
    }

    public fun mint_event_poap(arg0: &mut EventRegistry, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::vec_map::contains<0x2::object::ID, Event>(&arg0.events, &arg1), 0);
        let v0 = 0x2::vec_map::get<0x2::object::ID, Event>(&arg0.events, &arg1);
        let v1 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_set::contains<address>(&v0.attendees, &v1), 5);
        assert!(0x2::vec_set::contains<address>(&v0.checked_in_attendees, &v1), 5);
        let v2 = EventPOAP{
            id                : 0x2::object::new(arg2),
            event_id          : arg1,
            event_name        : v0.title,
            event_description : v0.description,
            event_image       : v0.poap_image_url,
            event_date        : v0.start_date,
            event_location    : v0.location,
            claimed_by        : v1,
            claimed_at        : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        arg0.total_poaps_claimed = arg0.total_poaps_claimed + 1;
        let v3 = EventPOAPMinted{
            poap_id  : 0x2::object::id<EventPOAP>(&v2),
            event_id : arg1,
            claimer  : v1,
        };
        0x2::event::emit<EventPOAPMinted>(v3);
        0x2::transfer::public_transfer<EventPOAP>(v2, v1);
    }

    public fun minted_by(arg0: &EventNFT) : address {
        arg0.minted_by
    }

    public fun nft_image_url(arg0: &Event) : 0x1::string::String {
        arg0.nft_image_url
    }

    public fun organizer_cap_event_id(arg0: &EventOrganizerCap) : &0x2::object::ID {
        &arg0.event_id
    }

    public fun pending_approvals(arg0: &Event) : 0x2::vec_set::VecSet<address> {
        arg0.pending_approvals
    }

    public fun pending_payments(arg0: &Event) : &0x2::vec_map::VecMap<address, 0x2::balance::Balance<0x2::sui::SUI>> {
        &arg0.pending_payments
    }

    public fun platform_balance(arg0: &EventRegistry) : &0x2::balance::Balance<0x2::sui::SUI> {
        &arg0.platform_balance
    }

    public fun platform_fee_bps(arg0: &EventRegistry) : u64 {
        arg0.platform_fee_bps
    }

    public fun poap_event_id(arg0: &EventPOAP) : &0x2::object::ID {
        &arg0.event_id
    }

    public fun poap_event_image(arg0: &EventPOAP) : &0x1::string::String {
        &arg0.event_image
    }

    public fun poap_event_location(arg0: &EventPOAP) : &0x1::string::String {
        &arg0.event_location
    }

    public fun poap_event_name(arg0: &EventPOAP) : &0x1::string::String {
        &arg0.event_name
    }

    public fun poap_id(arg0: &EventPOAP) : &0x2::object::UID {
        &arg0.id
    }

    public fun poap_image_url(arg0: &Event) : 0x1::string::String {
        arg0.poap_image_url
    }

    public fun poevent_date(arg0: &EventPOAP) : u64 {
        arg0.event_date
    }

    public fun register_for_event(arg0: &mut EventRegistry, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::vec_map::contains<0x2::object::ID, Event>(&arg0.events, &arg1), 0);
        let v0 = 0x2::vec_map::get_mut<0x2::object::ID, Event>(&mut arg0.events, &arg1);
        assert!(v0.is_active, 1);
        if (0x1::option::is_some<u64>(&v0.capacity)) {
            assert!(0x2::vec_set::size<address>(&v0.attendees) < *0x1::option::borrow<u64>(&v0.capacity), 2);
        };
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(!0x2::vec_set::contains<address>(&v0.attendees, &v1), 3);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v2 == v0.ticket_price, 4);
        let v3 = v2 * arg0.platform_fee_bps / 10000;
        let v4 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.platform_balance, 0x2::balance::split<0x2::sui::SUI>(&mut v4, v3));
        if (v0.requires_approval) {
            0x2::vec_map::insert<address, 0x2::balance::Balance<0x2::sui::SUI>>(&mut v0.pending_payments, v1, 0x2::balance::split<0x2::sui::SUI>(&mut v4, v2 - v3));
            0x2::vec_set::insert<address>(&mut v0.pending_approvals, v1);
            0x2::balance::destroy_zero<0x2::sui::SUI>(v4);
        } else {
            0x2::balance::join<0x2::sui::SUI>(&mut v0.event_balance, v4);
            0x2::vec_set::insert<address>(&mut v0.attendees, v1);
            0x2::vec_set::insert<address>(&mut v0.approved_attendees, v1);
        };
        arg0.total_attendees = arg0.total_attendees + 1;
        let v5 = UserRegistered{
            event_id          : arg1,
            attendee          : v1,
            payment_amount    : v2,
            requires_approval : v0.requires_approval,
            registered_at     : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<UserRegistered>(v5);
    }

    public fun reject_registration(arg0: &mut EventRegistry, arg1: 0x2::object::ID, arg2: address, arg3: &EventOrganizerCap, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::vec_map::contains<0x2::object::ID, Event>(&arg0.events, &arg1), 0);
        let v0 = 0x2::vec_map::get_mut<0x2::object::ID, Event>(&mut arg0.events, &arg1);
        assert!(v0.creator == 0x2::tx_context::sender(arg5), 5);
        assert!(arg3.event_id == arg1, 5);
        assert!(0x2::vec_set::contains<address>(&v0.pending_approvals, &arg2), 6);
        0x2::vec_set::remove<address>(&mut v0.pending_approvals, &arg2);
        if (0x2::vec_map::contains<address, 0x2::balance::Balance<0x2::sui::SUI>>(&v0.pending_payments, &arg2)) {
            let (_, v2) = 0x2::vec_map::remove<address, 0x2::balance::Balance<0x2::sui::SUI>>(&mut v0.pending_payments, &arg2);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v2, arg5), arg2);
        };
        v0.updated_at = 0x2::clock::timestamp_ms(arg4);
        let v3 = RegistrationRejected{
            event_id    : arg1,
            attendee    : arg2,
            rejected_by : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<RegistrationRejected>(v3);
    }

    public fun requires_approval(arg0: &Event) : bool {
        arg0.requires_approval
    }

    public fun set_platform_fee_rate(arg0: &mut EventRegistry, arg1: &SuperAdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 5);
        assert!(arg2 <= 1000, 7);
        arg0.platform_fee_bps = arg2;
    }

    public fun start_date(arg0: &Event) : u64 {
        arg0.start_date
    }

    public fun super_admin_id(arg0: &SuperAdminCap) : &0x2::object::UID {
        &arg0.id
    }

    public fun ticket_price(arg0: &Event) : u64 {
        arg0.ticket_price
    }

    public fun title(arg0: &Event) : 0x1::string::String {
        arg0.title
    }

    public fun total_attendees(arg0: &EventRegistry) : u64 {
        arg0.total_attendees
    }

    public fun total_events(arg0: &EventRegistry) : u64 {
        arg0.total_events
    }

    public fun total_nfts_minted(arg0: &EventRegistry) : u64 {
        arg0.total_nfts_minted
    }

    public fun total_poaps_claimed(arg0: &EventRegistry) : u64 {
        arg0.total_poaps_claimed
    }

    public fun update_event_details(arg0: &mut EventRegistry, arg1: 0x2::object::ID, arg2: &EventOrganizerCap, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: u64, arg9: u64, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: 0x1::option::Option<u64>, arg13: u64, arg14: bool, arg15: bool, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::vec_map::contains<0x2::object::ID, Event>(&arg0.events, &arg1), 0);
        let v0 = 0x2::vec_map::get_mut<0x2::object::ID, Event>(&mut arg0.events, &arg1);
        assert!(v0.is_active, 1);
        assert!(v0.creator == 0x2::tx_context::sender(arg17), 5);
        assert!(arg2.event_id == arg1, 5);
        v0.title = arg3;
        v0.description = arg4;
        v0.banner_url = arg5;
        v0.nft_image_url = arg6;
        v0.poap_image_url = arg7;
        v0.start_date = arg8;
        v0.end_date = arg9;
        v0.location = arg10;
        v0.category = arg11;
        v0.capacity = arg12;
        v0.ticket_price = arg13;
        v0.is_free = arg13 == 0;
        v0.requires_approval = arg14;
        v0.is_private = arg15;
        v0.updated_at = 0x2::clock::timestamp_ms(arg16);
    }

    public fun updated_at(arg0: &Event) : u64 {
        arg0.updated_at
    }

    public fun withdraw_event_funds(arg0: &mut EventRegistry, arg1: 0x2::object::ID, arg2: &EventOrganizerCap, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::vec_map::contains<0x2::object::ID, Event>(&arg0.events, &arg1), 0);
        let v0 = 0x2::vec_map::get_mut<0x2::object::ID, Event>(&mut arg0.events, &arg1);
        assert!(v0.creator == 0x2::tx_context::sender(arg4), 5);
        assert!(arg2.event_id == arg1, 5);
        assert!(arg3 <= 0x2::balance::value<0x2::sui::SUI>(&v0.event_balance), 4);
        let v1 = arg3 * arg0.platform_fee_bps / 10000;
        let v2 = 0x2::balance::split<0x2::sui::SUI>(&mut v0.event_balance, arg3);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.platform_balance, 0x2::balance::split<0x2::sui::SUI>(&mut v2, v1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v2, arg4), 0x2::tx_context::sender(arg4));
        let v3 = EventFundsWithdrawn{
            event_id     : arg1,
            creator      : 0x2::tx_context::sender(arg4),
            amount       : arg3,
            platform_fee : v1,
        };
        0x2::event::emit<EventFundsWithdrawn>(v3);
    }

    public fun withdraw_platform_fees(arg0: &mut EventRegistry, arg1: &SuperAdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 5);
        assert!(arg2 <= 0x2::balance::value<0x2::sui::SUI>(&arg0.platform_balance), 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.platform_balance, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

