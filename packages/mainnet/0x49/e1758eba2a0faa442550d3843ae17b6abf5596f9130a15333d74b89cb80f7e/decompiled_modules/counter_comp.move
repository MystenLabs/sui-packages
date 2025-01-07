module 0x49e1758eba2a0faa442550d3843ae17b6abf5596f9130a15333d74b89cb80f7e::counter_comp {
    struct Field has drop, store {
        data: vector<u8>,
    }

    public fun decode(arg0: vector<u8>) : u64 {
        let v0 = 0x2::bcs::new(arg0);
        0x2::bcs::peel_u64(&mut v0)
    }

    public fun encode(arg0: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg0));
        v0
    }

    public fun field_types() : vector<0x1::ascii::String> {
        let v0 = 0x1::vector::empty<0x1::ascii::String>();
        0x1::vector::push_back<0x1::ascii::String>(&mut v0, 0x1::ascii::string(b"u64"));
        v0
    }

    public fun get(arg0: &0x49e1758eba2a0faa442550d3843ae17b6abf5596f9130a15333d74b89cb80f7e::world::World) : u64 {
        decode(0x49e1758eba2a0faa442550d3843ae17b6abf5596f9130a15333d74b89cb80f7e::world::get_comp<Field>(arg0, id()).data)
    }

    public fun id() : address {
        0x49e1758eba2a0faa442550d3843ae17b6abf5596f9130a15333d74b89cb80f7e::entity_key::from_bytes(b"counter")
    }

    public fun register(arg0: &mut 0x49e1758eba2a0faa442550d3843ae17b6abf5596f9130a15333d74b89cb80f7e::world::World) {
        let v0 = Field{data: encode(0)};
        0x49e1758eba2a0faa442550d3843ae17b6abf5596f9130a15333d74b89cb80f7e::world::add_comp<Field>(arg0, b"counter", v0);
    }

    public(friend) fun update(arg0: &mut 0x49e1758eba2a0faa442550d3843ae17b6abf5596f9130a15333d74b89cb80f7e::world::World, arg1: u64) {
        let v0 = encode(arg1);
        0x49e1758eba2a0faa442550d3843ae17b6abf5596f9130a15333d74b89cb80f7e::world::get_mut_comp<Field>(arg0, id()).data = v0;
        0x49e1758eba2a0faa442550d3843ae17b6abf5596f9130a15333d74b89cb80f7e::world::emit_update_event(id(), 0x1::option::none<address>(), v0);
    }

    // decompiled from Move bytecode v6
}

