module 0xdcce259374ee87d79da1ce4f43a6eb96804a57f8a510c4d653ec4f523c7c6db4::ticket_nft {
    struct TICKET_NFT has drop {
        dummy_field: bool,
    }

    struct Ticket has store, key {
        id: 0x2::object::UID,
        event_id: address,
        owner: address,
        walrus_blob_ref: 0x1::string::String,
        encrypted_meta_hash: vector<u8>,
        ticket_type: u8,
        status: u8,
        created_at: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct TicketMinted has copy, drop {
        ticket_id: address,
        event_id: address,
        owner: address,
        ticket_type: u8,
    }

    struct TicketTransferred has copy, drop {
        ticket_id: address,
        from: address,
        to: address,
    }

    struct TicketRevoked has copy, drop {
        ticket_id: address,
        revoked_by: address,
        reason: 0x1::string::String,
    }

    struct TicketUsed has copy, drop {
        ticket_id: address,
        used_by: address,
    }

    public fun get_event_id(arg0: &Ticket) : address {
        arg0.event_id
    }

    public fun get_owner(arg0: &Ticket) : address {
        arg0.owner
    }

    public fun get_status(arg0: &Ticket) : u8 {
        arg0.status
    }

    fun init(arg0: TICKET_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://attenda.io"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Attenda"));
        let v4 = 0x2::package::claim<TICKET_NFT>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Ticket>>(0x2::display::new_with_fields<Ticket>(&v4, v0, v2, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun is_valid(arg0: &Ticket) : bool {
        arg0.status == 0
    }

    public entry fun mark_used(arg0: &mut Ticket, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 2003);
        arg0.status = 1;
        let v0 = TicketUsed{
            ticket_id : 0x2::object::uid_to_address(&arg0.id),
            used_by   : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<TicketUsed>(v0);
    }

    public entry fun mint_ticket(arg0: &mut 0xdcce259374ee87d79da1ce4f43a6eb96804a57f8a510c4d653ec4f523c7c6db4::event_registry::EventInfo, arg1: &mut 0xdcce259374ee87d79da1ce4f43a6eb96804a57f8a510c4d653ec4f523c7c6db4::ticket_seal::TicketPolicy, arg2: address, arg3: vector<u8>, arg4: vector<u8>, arg5: u8, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0xdcce259374ee87d79da1ce4f43a6eb96804a57f8a510c4d653ec4f523c7c6db4::event_registry::is_active(arg0), 2001);
        assert!(!0xdcce259374ee87d79da1ce4f43a6eb96804a57f8a510c4d653ec4f523c7c6db4::event_registry::has_registered(arg0, arg2), 2004);
        0xdcce259374ee87d79da1ce4f43a6eb96804a57f8a510c4d653ec4f523c7c6db4::event_registry::mark_registered(arg0, arg2);
        0xdcce259374ee87d79da1ce4f43a6eb96804a57f8a510c4d653ec4f523c7c6db4::event_registry::increment_tickets_sold(arg0);
        let v0 = 0x2::object::id<0xdcce259374ee87d79da1ce4f43a6eb96804a57f8a510c4d653ec4f523c7c6db4::event_registry::EventInfo>(arg0);
        let v1 = Ticket{
            id                  : 0x2::object::new(arg10),
            event_id            : 0x2::object::id_to_address(&v0),
            owner               : arg2,
            walrus_blob_ref     : 0x1::string::utf8(arg3),
            encrypted_meta_hash : arg4,
            ticket_type         : arg5,
            status              : 0,
            created_at          : 0x2::clock::timestamp_ms(arg9),
            name                : 0x1::string::utf8(arg6),
            description         : 0x1::string::utf8(arg7),
            url                 : 0x2::url::new_unsafe_from_bytes(arg8),
        };
        let v2 = 0x2::object::uid_to_address(&v1.id);
        0xdcce259374ee87d79da1ce4f43a6eb96804a57f8a510c4d653ec4f523c7c6db4::ticket_seal::add_ticket_holder_internal(arg1, v2, arg2, arg10);
        let v3 = TicketMinted{
            ticket_id   : v2,
            event_id    : v1.event_id,
            owner       : arg2,
            ticket_type : arg5,
        };
        0x2::event::emit<TicketMinted>(v3);
        0x2::transfer::public_transfer<Ticket>(v1, arg2);
    }

    public entry fun revoke_ticket(arg0: &mut Ticket, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 2001);
        arg0.status = 2;
        let v0 = TicketRevoked{
            ticket_id  : 0x2::object::uid_to_address(&arg0.id),
            revoked_by : 0x2::tx_context::sender(arg2),
            reason     : 0x1::string::utf8(arg1),
        };
        0x2::event::emit<TicketRevoked>(v0);
    }

    public entry fun transfer_ticket(arg0: Ticket, arg1: &mut 0xdcce259374ee87d79da1ce4f43a6eb96804a57f8a510c4d653ec4f523c7c6db4::ticket_seal::TicketPolicy, arg2: &0xdcce259374ee87d79da1ce4f43a6eb96804a57f8a510c4d653ec4f523c7c6db4::ticket_seal::PolicyCap, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg4), 2000);
        assert!(arg0.status == 0, 2001);
        let v0 = 0x2::object::uid_to_address(&arg0.id);
        0xdcce259374ee87d79da1ce4f43a6eb96804a57f8a510c4d653ec4f523c7c6db4::ticket_seal::remove_ticket_holder(arg1, arg2, v0);
        0xdcce259374ee87d79da1ce4f43a6eb96804a57f8a510c4d653ec4f523c7c6db4::ticket_seal::add_ticket_holder(arg1, arg2, v0, arg3, arg4);
        let v1 = TicketTransferred{
            ticket_id : v0,
            from      : arg0.owner,
            to        : arg3,
        };
        0x2::event::emit<TicketTransferred>(v1);
        0x2::transfer::public_transfer<Ticket>(arg0, arg3);
    }

    // decompiled from Move bytecode v6
}

