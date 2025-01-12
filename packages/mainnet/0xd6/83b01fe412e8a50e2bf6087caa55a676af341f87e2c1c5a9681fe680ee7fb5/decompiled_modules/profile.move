module 0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::profile {
    struct Profile has store, key {
        id: 0x2::object::UID,
        ticket_stores: 0x2::vec_map::VecMap<0x2::object::ID, TicketStore>,
        tickets: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct TicketStore has copy, drop, store {
        pool_id: 0x2::object::ID,
        tickets: vector<0x2::object::ID>,
    }

    struct ProfileCreated has copy, drop {
        profile_id: 0x2::object::ID,
        created_by: address,
        created_time: u64,
    }

    public fun add_ticket_ids(arg0: &mut TicketStore, arg1: vector<0x2::object::ID>) {
        0x1::vector::append<0x2::object::ID>(&mut arg0.tickets, arg1);
    }

    public fun add_ticket_store(arg0: &mut Profile, arg1: 0x2::object::ID, arg2: TicketStore) {
        if (0x2::vec_map::contains<0x2::object::ID, TicketStore>(&arg0.ticket_stores, &arg1)) {
            let v0 = 0x2::vec_map::get_mut<0x2::object::ID, TicketStore>(&mut arg0.ticket_stores, &arg1);
            append_store(v0, arg2);
        } else {
            0x2::vec_map::insert<0x2::object::ID, TicketStore>(&mut arg0.ticket_stores, arg1, arg2);
        };
    }

    public fun append_store(arg0: &mut TicketStore, arg1: TicketStore) {
        assert!(arg0.pool_id == arg1.pool_id, 0);
        0x1::vector::append<0x2::object::ID>(&mut arg0.tickets, arg1.tickets);
    }

    public fun create_profile(arg0: &mut 0x2::tx_context::TxContext) : Profile {
        Profile{
            id            : 0x2::object::new(arg0),
            ticket_stores : 0x2::vec_map::empty<0x2::object::ID, TicketStore>(),
            tickets       : 0x2::vec_set::empty<0x2::object::ID>(),
        }
    }

    public fun create_ticket_store(arg0: 0x2::object::ID, arg1: vector<0x2::object::ID>) : TicketStore {
        TicketStore{
            pool_id : arg0,
            tickets : arg1,
        }
    }

    public fun emit_profile_created_event(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = ProfileCreated{
            profile_id   : arg0,
            created_by   : arg1,
            created_time : arg2,
        };
        0x2::event::emit<ProfileCreated>(v0);
    }

    public fun get_profile_id(arg0: &Profile) : 0x2::object::ID {
        0x2::object::id<Profile>(arg0)
    }

    public fun get_ticket_count(arg0: &Profile) : u64 {
        0x2::vec_set::size<0x2::object::ID>(&arg0.tickets)
    }

    public fun get_ticket_count_by_pool(arg0: &Profile, arg1: &0x2::object::ID) : u64 {
        let v0 = 0x2::vec_map::try_get<0x2::object::ID, TicketStore>(&arg0.ticket_stores, arg1);
        let v1 = if (0x1::option::is_some<TicketStore>(&v0)) {
            let v2 = 0x1::option::destroy_some<TicketStore>(v0);
            0x1::option::some<u64>(0x1::vector::length<0x2::object::ID>(&v2.tickets))
        } else {
            0x1::option::destroy_none<TicketStore>(v0);
            0x1::option::none<u64>()
        };
        let v3 = v1;
        0x1::option::get_with_default<u64>(&v3, 0)
    }

    public fun get_tickets_by_pool(arg0: &Profile, arg1: &0x2::object::ID) : vector<0x2::object::ID> {
        let v0 = 0x2::vec_map::try_get<0x2::object::ID, TicketStore>(&arg0.ticket_stores, arg1);
        let v1 = if (0x1::option::is_some<TicketStore>(&v0)) {
            let v2 = 0x1::option::destroy_some<TicketStore>(v0);
            0x1::option::some<vector<0x2::object::ID>>(v2.tickets)
        } else {
            0x1::option::destroy_none<TicketStore>(v0);
            0x1::option::none<vector<0x2::object::ID>>()
        };
        let v3 = v1;
        0x1::option::get_with_default<vector<0x2::object::ID>>(&v3, 0x1::vector::empty<0x2::object::ID>())
    }

    public fun insert_ticket(arg0: &mut Profile, arg1: 0x2::object::ID) {
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.tickets, arg1);
    }

    public fun insert_tickets(arg0: &mut Profile, arg1: vector<0x2::object::ID>) {
        0x1::vector::reverse<0x2::object::ID>(&mut arg1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg1)) {
            0x2::vec_set::insert<0x2::object::ID>(&mut arg0.tickets, 0x1::vector::pop_back<0x2::object::ID>(&mut arg1));
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<0x2::object::ID>(arg1);
    }

    public fun pop_ticket(arg0: &mut Profile, arg1: &0x2::object::ID) {
        0x2::vec_set::remove<0x2::object::ID>(&mut arg0.tickets, arg1);
    }

    public fun update_ticket(arg0: &mut Profile, arg1: 0x2::object::ID, arg2: vector<0x2::object::ID>) {
        add_ticket_store(arg0, arg1, create_ticket_store(arg1, arg2));
        insert_tickets(arg0, arg2);
    }

    // decompiled from Move bytecode v6
}

