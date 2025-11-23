module 0xdcce259374ee87d79da1ce4f43a6eb96804a57f8a510c4d653ec4f523c7c6db4::ticket_seal {
    struct TicketPolicyCreated has copy, drop {
        policy_id: 0x2::object::ID,
        event_id: address,
        creator: address,
    }

    struct TicketHolderAdded has copy, drop {
        policy_id: 0x2::object::ID,
        ticket_id: address,
        holder: address,
        operator: address,
    }

    struct TicketBlobPublished has copy, drop {
        policy_id: 0x2::object::ID,
        ticket_id: address,
        blob_id: 0x1::string::String,
        publisher: address,
    }

    struct TicketPolicy has key {
        id: 0x2::object::UID,
        event_id: address,
        tickets: vector<address>,
        holders: vector<address>,
    }

    struct PolicyCap has store, key {
        id: 0x2::object::UID,
        policy_id: 0x2::object::ID,
    }

    public fun add_ticket_holder(arg0: &mut TicketPolicy, arg1: &PolicyCap, arg2: address, arg3: address, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1.policy_id == 0x2::object::id<TicketPolicy>(arg0), 0);
        assert!(!0x1::vector::contains<address>(&arg0.tickets, &arg2), 2);
        0x1::vector::push_back<address>(&mut arg0.tickets, arg2);
        0x1::vector::push_back<address>(&mut arg0.holders, arg3);
        let v0 = TicketHolderAdded{
            policy_id : 0x2::object::id<TicketPolicy>(arg0),
            ticket_id : arg2,
            holder    : arg3,
            operator  : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<TicketHolderAdded>(v0);
    }

    public(friend) fun add_ticket_holder_internal(arg0: &mut TicketPolicy, arg1: address, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert!(!0x1::vector::contains<address>(&arg0.tickets, &arg1), 2);
        0x1::vector::push_back<address>(&mut arg0.tickets, arg1);
        0x1::vector::push_back<address>(&mut arg0.holders, arg2);
        let v0 = TicketHolderAdded{
            policy_id : 0x2::object::id<TicketPolicy>(arg0),
            ticket_id : arg1,
            holder    : arg2,
            operator  : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<TicketHolderAdded>(v0);
    }

    fun approve_internal(arg0: address, arg1: vector<u8>, arg2: &TicketPolicy) : bool {
        if (!is_prefix(namespace(arg2), arg1)) {
            return false
        };
        0x1::vector::contains<address>(&arg2.holders, &arg0)
    }

    public fun create_policy(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : PolicyCap {
        let v0 = TicketPolicy{
            id       : 0x2::object::new(arg1),
            event_id : arg0,
            tickets  : 0x1::vector::empty<address>(),
            holders  : 0x1::vector::empty<address>(),
        };
        let v1 = 0x2::object::id<TicketPolicy>(&v0);
        let v2 = PolicyCap{
            id        : 0x2::object::new(arg1),
            policy_id : v1,
        };
        let v3 = TicketPolicyCreated{
            policy_id : v1,
            event_id  : arg0,
            creator   : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<TicketPolicyCreated>(v3);
        0x2::transfer::share_object<TicketPolicy>(v0);
        v2
    }

    public entry fun create_policy_entry(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_policy(arg0, arg1);
        0x2::transfer::public_transfer<PolicyCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun get_event_id(arg0: &TicketPolicy) : address {
        arg0.event_id
    }

    public fun get_policy_id(arg0: &PolicyCap) : 0x2::object::ID {
        arg0.policy_id
    }

    fun is_prefix(arg0: vector<u8>, arg1: vector<u8>) : bool {
        if (0x1::vector::length<u8>(&arg0) > 0x1::vector::length<u8>(&arg1)) {
            return false
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(&arg0)) {
            if (*0x1::vector::borrow<u8>(&arg0, v0) != *0x1::vector::borrow<u8>(&arg1, v0)) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public fun is_ticket_holder(arg0: &TicketPolicy, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.holders, &arg1)
    }

    public fun namespace(arg0: &TicketPolicy) : vector<u8> {
        0x2::object::uid_to_bytes(&arg0.id)
    }

    public fun publish_blob(arg0: &mut TicketPolicy, arg1: &PolicyCap, arg2: address, arg3: 0x1::string::String, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1.policy_id == 0x2::object::id<TicketPolicy>(arg0), 0);
        0x2::dynamic_field::add<0x1::string::String, u64>(&mut arg0.id, arg3, 3);
        let v0 = TicketBlobPublished{
            policy_id : 0x2::object::id<TicketPolicy>(arg0),
            ticket_id : arg2,
            blob_id   : arg3,
            publisher : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<TicketBlobPublished>(v0);
    }

    public fun remove_ticket_holder(arg0: &mut TicketPolicy, arg1: &PolicyCap, arg2: address) {
        assert!(arg1.policy_id == 0x2::object::id<TicketPolicy>(arg0), 0);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0.tickets)) {
            if (*0x1::vector::borrow<address>(&arg0.tickets, v0) == arg2) {
                0x1::vector::remove<address>(&mut arg0.tickets, v0);
                0x1::vector::remove<address>(&mut arg0.holders, v0);
                break
            };
            v0 = v0 + 1;
        };
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &TicketPolicy, arg2: &0x2::tx_context::TxContext) {
        assert!(approve_internal(0x2::tx_context::sender(arg2), arg0, arg1), 1);
    }

    public fun ticket_count(arg0: &TicketPolicy) : u64 {
        0x1::vector::length<address>(&arg0.tickets)
    }

    // decompiled from Move bytecode v6
}

