module 0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::ticket {
    struct AdminTicket has key {
        id: 0x2::object::UID,
        owner: address,
        created_at: u64,
        ticket_type: u8,
    }

    struct TicketCreated has copy, drop {
        ticket_id: 0x2::object::ID,
        ticket_type: u8,
    }

    struct TicketDestroyed has copy, drop {
        ticket_id: 0x2::object::ID,
        ticket_type: u8,
    }

    public fun cleanup_expired_ticket(arg0: AdminTicket, arg1: &0x2::clock::Clock) {
        assert!(is_ticket_expired(&arg0, arg1), 6);
        destroy_ticket(arg0);
    }

    public fun create_ticket(arg0: &0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::admin::AdminCap, arg1: u8, arg2: vector<vector<u8>>, arg3: vector<u8>, arg4: u16, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::multisig::check_if_sender_is_multisig_address(arg2, arg3, arg4, arg6), 5);
        let v0 = AdminTicket{
            id          : 0x2::object::new(arg6),
            owner       : 0x2::tx_context::sender(arg6),
            created_at  : 0x2::clock::timestamp_ms(arg5) / 1000,
            ticket_type : arg1,
        };
        let v1 = TicketCreated{
            ticket_id   : 0x2::object::uid_to_inner(&v0.id),
            ticket_type : arg1,
        };
        0x2::event::emit<TicketCreated>(v1);
        0x2::transfer::share_object<AdminTicket>(v0);
    }

    public(friend) fun destroy_ticket(arg0: AdminTicket) {
        let AdminTicket {
            id          : v0,
            owner       : _,
            created_at  : _,
            ticket_type : v3,
        } = arg0;
        let v4 = v0;
        let v5 = TicketDestroyed{
            ticket_id   : 0x2::object::uid_to_inner(&v4),
            ticket_type : v3,
        };
        0x2::event::emit<TicketDestroyed>(v5);
        0x2::object::delete(v4);
    }

    public fun is_ticket_expired(arg0: &AdminTicket, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) / 1000 >= arg0.created_at + 172800 + 259200
    }

    public fun is_ticket_ready(arg0: &AdminTicket, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) / 1000 >= arg0.created_at + 172800
    }

    public fun update_default_fees_ticket_type() : u8 {
        4
    }

    public fun update_pool_creation_protocol_fee_ticket_type() : u8 {
        3
    }

    public fun update_pool_specific_fees_ticket_type() : u8 {
        5
    }

    public(friend) fun validate_ticket(arg0: &AdminTicket, arg1: u8, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 1);
        assert!(arg0.ticket_type == arg1, 2);
        assert!(!is_ticket_expired(arg0, arg2), 3);
        assert!(is_ticket_ready(arg0, arg2), 4);
    }

    public fun withdraw_coverage_fee_ticket_type() : u8 {
        2
    }

    public fun withdraw_deep_reserves_ticket_type() : u8 {
        0
    }

    public fun withdraw_protocol_fee_ticket_type() : u8 {
        1
    }

    // decompiled from Move bytecode v6
}

