module 0x49e1758eba2a0faa442550d3843ae17b6abf5596f9130a15333d74b89cb80f7e::player_comp {
    struct Field has drop, store {
        data: vector<u8>,
    }

    public(friend) fun add(arg0: &mut 0x49e1758eba2a0faa442550d3843ae17b6abf5596f9130a15333d74b89cb80f7e::world::World, arg1: address, arg2: address) {
        let v0 = encode(arg2);
        let v1 = Field{data: v0};
        0x2::table::add<address, Field>(0x49e1758eba2a0faa442550d3843ae17b6abf5596f9130a15333d74b89cb80f7e::world::get_mut_comp<0x2::table::Table<address, Field>>(arg0, id()), arg1, v1);
        0x49e1758eba2a0faa442550d3843ae17b6abf5596f9130a15333d74b89cb80f7e::world::emit_add_event(id(), arg1, v0);
    }

    public fun contains(arg0: &0x49e1758eba2a0faa442550d3843ae17b6abf5596f9130a15333d74b89cb80f7e::world::World, arg1: address) : bool {
        0x2::table::contains<address, Field>(0x49e1758eba2a0faa442550d3843ae17b6abf5596f9130a15333d74b89cb80f7e::world::get_comp<0x2::table::Table<address, Field>>(arg0, id()), arg1)
    }

    public(friend) fun remove(arg0: &mut 0x49e1758eba2a0faa442550d3843ae17b6abf5596f9130a15333d74b89cb80f7e::world::World, arg1: address) {
        0x2::table::remove<address, Field>(0x49e1758eba2a0faa442550d3843ae17b6abf5596f9130a15333d74b89cb80f7e::world::get_mut_comp<0x2::table::Table<address, Field>>(arg0, id()), arg1);
        0x49e1758eba2a0faa442550d3843ae17b6abf5596f9130a15333d74b89cb80f7e::world::emit_remove_event(id(), arg1);
    }

    public fun decode(arg0: vector<u8>) : address {
        let v0 = 0x2::bcs::new(arg0);
        0x2::bcs::peel_address(&mut v0)
    }

    public fun encode(arg0: address) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg0));
        v0
    }

    public fun field_types() : vector<0x1::ascii::String> {
        let v0 = 0x1::vector::empty<0x1::ascii::String>();
        0x1::vector::push_back<0x1::ascii::String>(&mut v0, 0x1::ascii::string(b"u64"));
        v0
    }

    public fun get(arg0: &0x49e1758eba2a0faa442550d3843ae17b6abf5596f9130a15333d74b89cb80f7e::world::World, arg1: address) : address {
        decode(0x2::table::borrow<address, Field>(0x49e1758eba2a0faa442550d3843ae17b6abf5596f9130a15333d74b89cb80f7e::world::get_comp<0x2::table::Table<address, Field>>(arg0, id()), arg1).data)
    }

    public fun get_profile(arg0: &0x49e1758eba2a0faa442550d3843ae17b6abf5596f9130a15333d74b89cb80f7e::world::World, arg1: address) : address {
        decode(0x2::table::borrow<address, Field>(0x49e1758eba2a0faa442550d3843ae17b6abf5596f9130a15333d74b89cb80f7e::world::get_comp<0x2::table::Table<address, Field>>(arg0, id()), arg1).data)
    }

    public fun id() : address {
        0x49e1758eba2a0faa442550d3843ae17b6abf5596f9130a15333d74b89cb80f7e::entity_key::from_bytes(b"player")
    }

    public fun register(arg0: &mut 0x49e1758eba2a0faa442550d3843ae17b6abf5596f9130a15333d74b89cb80f7e::world::World, arg1: &mut 0x2::tx_context::TxContext) {
        0x49e1758eba2a0faa442550d3843ae17b6abf5596f9130a15333d74b89cb80f7e::world::add_comp<0x2::table::Table<address, Field>>(arg0, b"player", 0x2::table::new<address, Field>(arg1));
    }

    public(friend) fun update(arg0: &mut 0x49e1758eba2a0faa442550d3843ae17b6abf5596f9130a15333d74b89cb80f7e::world::World, arg1: address, arg2: address) {
        let v0 = encode(arg2);
        0x2::table::borrow_mut<address, Field>(0x49e1758eba2a0faa442550d3843ae17b6abf5596f9130a15333d74b89cb80f7e::world::get_mut_comp<0x2::table::Table<address, Field>>(arg0, id()), arg1).data = v0;
        0x49e1758eba2a0faa442550d3843ae17b6abf5596f9130a15333d74b89cb80f7e::world::emit_update_event(id(), 0x1::option::some<address>(arg1), v0);
    }

    public(friend) fun update_profile(arg0: &mut 0x49e1758eba2a0faa442550d3843ae17b6abf5596f9130a15333d74b89cb80f7e::world::World, arg1: address, arg2: address) {
        let v0 = 0x2::table::borrow_mut<address, Field>(0x49e1758eba2a0faa442550d3843ae17b6abf5596f9130a15333d74b89cb80f7e::world::get_mut_comp<0x2::table::Table<address, Field>>(arg0, id()), arg1);
        decode(v0.data);
        let v1 = encode(arg2);
        v0.data = v1;
        0x49e1758eba2a0faa442550d3843ae17b6abf5596f9130a15333d74b89cb80f7e::world::emit_update_event(id(), 0x1::option::some<address>(arg1), v1);
    }

    // decompiled from Move bytecode v6
}

