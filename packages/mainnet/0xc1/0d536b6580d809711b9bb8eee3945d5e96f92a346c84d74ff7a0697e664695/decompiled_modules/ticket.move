module 0xc10d536b6580d809711b9bb8eee3945d5e96f92a346c84d74ff7a0697e664695::ticket {
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
        is_expired: bool,
    }

    public fun cleanup_expired_ticket(arg0: AdminTicket, arg1: &0x2::clock::Clock) {
        assert!(is_ticket_expired(&arg0, arg1), 5);
        destroy_ticket(arg0, arg1);
    }

    public fun create_ticket(arg0: &0xc10d536b6580d809711b9bb8eee3945d5e96f92a346c84d74ff7a0697e664695::multisig_config::MultisigConfig, arg1: &0xc10d536b6580d809711b9bb8eee3945d5e96f92a346c84d74ff7a0697e664695::admin::AdminCap, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xc10d536b6580d809711b9bb8eee3945d5e96f92a346c84d74ff7a0697e664695::multisig_config::validate_sender_is_admin_multisig(arg0, arg4);
        let v0 = AdminTicket{
            id          : 0x2::object::new(arg4),
            owner       : 0x2::tx_context::sender(arg4),
            created_at  : 0x2::clock::timestamp_ms(arg3),
            ticket_type : arg2,
        };
        let v1 = TicketCreated{
            ticket_id   : 0x2::object::uid_to_inner(&v0.id),
            ticket_type : arg2,
        };
        0x2::event::emit<TicketCreated>(v1);
        0x2::transfer::share_object<AdminTicket>(v0);
    }

    public(friend) fun destroy_ticket(arg0: AdminTicket, arg1: &0x2::clock::Clock) {
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
            is_expired  : is_ticket_expired(&arg0, arg1),
        };
        0x2::event::emit<TicketDestroyed>(v5);
        0x2::object::delete(v4);
    }

    public fun is_ticket_expired(arg0: &AdminTicket, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.created_at + 172800000 + 259200000
    }

    public fun is_ticket_ready(arg0: &AdminTicket, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.created_at + 172800000
    }

    public fun ticket_active_duration() : u64 {
        259200000
    }

    public fun ticket_delay_duration() : u64 {
        172800000
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

