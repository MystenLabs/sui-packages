module 0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::event {
    struct Event has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        details: 0x1::string::String,
        type: 0x1::string::String,
        participants: 0x2::table::Table<address, Participant>,
        ticket_current_supply: u64,
        ticket_max_supply: u64,
        participant_max_tickets: u64,
        image_url: 0x1::string::String,
        creator: NamedAddress,
        collaborators: 0x2::table::Table<address, NamedAddress>,
    }

    struct NamedAddress has copy, drop, store {
        addr: address,
        name: 0x1::string::String,
    }

    struct CollaborationRequest has key {
        id: 0x2::object::UID,
        event_id: 0x2::object::ID,
    }

    struct Participant has drop, store {
        user_address: address,
        tickets_bought: u64,
    }

    struct EVENT has drop {
        dummy_field: bool,
    }

    struct NewEventMinted has copy, drop {
        event_id: 0x2::object::ID,
        name: 0x1::string::String,
        creator: NamedAddress,
        ticket_max_supply: u64,
    }

    struct NewCollaboratorEvent has copy, drop {
        event_id: 0x2::object::ID,
        collaborator: address,
    }

    public fun accept_collaboration_request(arg0: CollaborationRequest, arg1: &mut Event, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.event_id == get_event_id(arg1), 2);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(!is_creator(arg1, v0), 5);
        assert!(!is_collaborator(arg1, v0), 1);
        let v1 = NamedAddress{
            addr : v0,
            name : arg2,
        };
        0x2::table::add<address, NamedAddress>(&mut arg1.collaborators, v0, v1);
        let v2 = NewCollaboratorEvent{
            event_id     : get_event_id(arg1),
            collaborator : v0,
        };
        0x2::event::emit<NewCollaboratorEvent>(v2);
        burn_collaboration_ticket(arg0);
    }

    public fun add_or_update_participant(arg0: &mut Event, arg1: address, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(is_creator(arg0, v0) || is_collaborator(arg0, v0), 2);
        assert!(can_buy_tickets(arg0, arg2, arg1), 0);
        if (0x2::table::contains<address, Participant>(&arg0.participants, arg1)) {
            let v1 = 0x2::table::borrow_mut<address, Participant>(&mut arg0.participants, arg1);
            v1.tickets_bought = v1.tickets_bought + arg2;
        } else {
            let v2 = Participant{
                user_address   : arg1,
                tickets_bought : arg2,
            };
            0x2::table::add<address, Participant>(&mut arg0.participants, v2.user_address, v2);
        };
    }

    fun burn_collaboration_ticket(arg0: CollaborationRequest) {
        let CollaborationRequest {
            id       : v0,
            event_id : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun can_buy_tickets(arg0: &Event, arg1: u64, arg2: address) : bool {
        0x2::table::contains<address, Participant>(&arg0.participants, arg2) && 0x2::table::borrow<address, Participant>(&arg0.participants, arg2).tickets_bought + arg1 <= arg0.participant_max_tickets || arg1 <= arg0.participant_max_tickets
    }

    public fun can_mint_tickets_for_event(arg0: &Event, arg1: u64) : bool {
        arg0.ticket_current_supply + arg1 <= arg0.ticket_max_supply
    }

    public fun create_collaboration_request(arg0: &Event, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(is_creator(arg0, v0) || is_collaborator(arg0, v0), 2);
        assert!(!is_creator(arg0, arg1), 5);
        assert!(!is_collaborator(arg0, arg1), 1);
        let v1 = CollaborationRequest{
            id       : 0x2::object::new(arg2),
            event_id : get_event_id(arg0),
        };
        0x2::transfer::transfer<CollaborationRequest>(v1, arg1);
    }

    public fun create_event(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::core::Blacklist, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!0x89f0a1481600ea5efde8da94fc33277341b6192ffc4366d168e9bd54ea6dfbd6::core::is_blacklisted(arg7, 0x2::tx_context::sender(arg8)), 6);
        let v0 = NamedAddress{
            addr : 0x2::tx_context::sender(arg8),
            name : arg6,
        };
        let v1 = Event{
            id                      : 0x2::object::new(arg8),
            name                    : arg0,
            details                 : arg1,
            type                    : arg2,
            participants            : 0x2::table::new<address, Participant>(arg8),
            ticket_current_supply   : 0,
            ticket_max_supply       : arg3,
            participant_max_tickets : arg4,
            image_url               : arg5,
            creator                 : v0,
            collaborators           : 0x2::table::new<address, NamedAddress>(arg8),
        };
        let v2 = NewEventMinted{
            event_id          : get_event_id(&v1),
            name              : arg0,
            creator           : v1.creator,
            ticket_max_supply : arg3,
        };
        0x2::event::emit<NewEventMinted>(v2);
        0x2::transfer::share_object<Event>(v1);
    }

    public fun creator_destroy_event(arg0: Event, arg1: &0x2::tx_context::TxContext) {
        assert!(is_creator(&arg0, 0x2::tx_context::sender(arg1)), 3);
        let Event {
            id                      : v0,
            name                    : _,
            details                 : _,
            type                    : _,
            participants            : v4,
            ticket_current_supply   : _,
            ticket_max_supply       : _,
            participant_max_tickets : _,
            image_url               : _,
            creator                 : _,
            collaborators           : v10,
        } = arg0;
        0x2::table::drop<address, Participant>(v4);
        0x2::table::drop<address, NamedAddress>(v10);
        0x2::object::delete(v0);
    }

    public fun decline_collaboration_request(arg0: CollaborationRequest) {
        burn_collaboration_ticket(arg0);
    }

    public fun get_event_id(arg0: &Event) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun get_participant_tickets(arg0: address, arg1: &0x2::table::Table<address, Participant>) : u64 {
        0x2::table::borrow<address, Participant>(arg1, arg0).tickets_bought
    }

    public fun get_participants(arg0: &Event) : &0x2::table::Table<address, Participant> {
        &arg0.participants
    }

    public fun get_ticket_current_supply(arg0: &Event) : u64 {
        arg0.ticket_current_supply
    }

    public fun get_ticket_max_supply(arg0: &Event) : u64 {
        arg0.ticket_max_supply
    }

    fun init(arg0: EVENT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<EVENT>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{img_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{details}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{creator.name}"));
        let v5 = 0x2::display::new_with_fields<Event>(&v0, v1, v3, arg1);
        0x2::display::update_version<Event>(&mut v5);
        0x2::transfer::public_transfer<0x2::display::Display<Event>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun is_collaborator(arg0: &Event, arg1: address) : bool {
        0x2::table::contains<address, NamedAddress>(&arg0.collaborators, arg1)
    }

    public fun is_creator(arg0: &Event, arg1: address) : bool {
        arg0.creator.addr == arg1
    }

    public fun is_participant(arg0: &Event, arg1: address) : bool {
        0x2::table::contains<address, Participant>(&arg0.participants, arg1)
    }

    public(friend) fun update_event_current_supply(arg0: &mut Event) {
        arg0.ticket_current_supply = arg0.ticket_current_supply + 1;
    }

    public fun update_event_details(arg0: &mut Event, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(is_creator(arg0, v0) || is_collaborator(arg0, v0), 2);
        arg0.details = arg1;
    }

    public fun update_event_image_url(arg0: &mut Event, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(is_creator(arg0, v0) || is_collaborator(arg0, v0), 2);
        arg0.image_url = arg1;
    }

    public fun update_event_my_address_name(arg0: &mut Event, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(is_creator(arg0, v0) || is_collaborator(arg0, v0), 2);
        if (is_creator(arg0, v0)) {
            arg0.creator.name = arg1;
        } else {
            0x2::table::borrow_mut<address, NamedAddress>(&mut arg0.collaborators, v0).name = arg1;
        };
    }

    public fun update_event_name(arg0: &mut Event, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(is_creator(arg0, v0) || is_collaborator(arg0, v0), 2);
        arg0.name = arg1;
    }

    public fun update_event_participant_max_tickets(arg0: &mut Event, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(is_creator(arg0, v0) || is_collaborator(arg0, v0), 2);
        arg0.participant_max_tickets = arg1;
    }

    public fun update_event_ticket_max_supply(arg0: &mut Event, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(is_creator(arg0, v0) || is_collaborator(arg0, v0), 2);
        assert!(arg1 >= arg0.ticket_current_supply, 7);
        arg0.ticket_max_supply = arg1;
    }

    public fun update_event_type(arg0: &mut Event, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(is_creator(arg0, v0) || is_collaborator(arg0, v0), 2);
        arg0.type = arg1;
    }

    public fun withdraw_collaborator_from_event(arg0: &mut Event, arg1: &0x2::tx_context::TxContext) {
        assert!(is_collaborator(arg0, 0x2::tx_context::sender(arg1)), 4);
        0x2::table::remove<address, NamedAddress>(&mut arg0.collaborators, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

