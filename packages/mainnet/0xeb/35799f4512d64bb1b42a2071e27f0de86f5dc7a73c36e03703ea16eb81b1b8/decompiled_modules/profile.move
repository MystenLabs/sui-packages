module 0xeb35799f4512d64bb1b42a2071e27f0de86f5dc7a73c36e03703ea16eb81b1b8::profile {
    struct AgentProfile has store, key {
        id: 0x2::object::UID,
        owner: address,
        genome_id: 0x2::object::ID,
        name: vector<u8>,
        description: vector<u8>,
        avatar_blob_id: vector<u8>,
        banner_blob_id: vector<u8>,
        karma: u64,
        created_at: u64,
    }

    public entry fun create_profile(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<u8>(&arg1);
        assert!(v0 >= 0xeb35799f4512d64bb1b42a2071e27f0de86f5dc7a73c36e03703ea16eb81b1b8::types::agent_name_min_length(), 500);
        assert!(v0 <= 0xeb35799f4512d64bb1b42a2071e27f0de86f5dc7a73c36e03703ea16eb81b1b8::types::agent_name_max_length(), 501);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        let v3 = AgentProfile{
            id             : 0x2::object::new(arg3),
            owner          : v1,
            genome_id      : arg0,
            name           : arg1,
            description    : 0x1::vector::empty<u8>(),
            avatar_blob_id : 0x1::vector::empty<u8>(),
            banner_blob_id : 0x1::vector::empty<u8>(),
            karma          : 0,
            created_at     : v2,
        };
        0xeb35799f4512d64bb1b42a2071e27f0de86f5dc7a73c36e03703ea16eb81b1b8::events::emit_profile_created(0x2::object::id<AgentProfile>(&v3), v1, arg0, v3.name, v2);
        0x2::transfer::transfer<AgentProfile>(v3, v1);
    }

    public fun profile_avatar_blob_id(arg0: &AgentProfile) : &vector<u8> {
        &arg0.avatar_blob_id
    }

    public fun profile_banner_blob_id(arg0: &AgentProfile) : &vector<u8> {
        &arg0.banner_blob_id
    }

    public fun profile_description(arg0: &AgentProfile) : &vector<u8> {
        &arg0.description
    }

    public fun profile_genome_id(arg0: &AgentProfile) : 0x2::object::ID {
        arg0.genome_id
    }

    public fun profile_karma(arg0: &AgentProfile) : u64 {
        arg0.karma
    }

    public fun profile_name(arg0: &AgentProfile) : &vector<u8> {
        &arg0.name
    }

    public fun profile_owner(arg0: &AgentProfile) : address {
        arg0.owner
    }

    public entry fun update_profile(arg0: &mut AgentProfile, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg6), 203);
        if (0x1::vector::length<u8>(&arg1) > 0) {
            assert!(0x1::vector::length<u8>(&arg1) >= 0xeb35799f4512d64bb1b42a2071e27f0de86f5dc7a73c36e03703ea16eb81b1b8::types::agent_name_min_length(), 500);
            assert!(0x1::vector::length<u8>(&arg1) <= 0xeb35799f4512d64bb1b42a2071e27f0de86f5dc7a73c36e03703ea16eb81b1b8::types::agent_name_max_length(), 501);
            arg0.name = arg1;
        };
        if (0x1::vector::length<u8>(&arg2) > 0) {
            arg0.description = arg2;
        };
        if (0x1::vector::length<u8>(&arg3) > 0) {
            arg0.avatar_blob_id = arg3;
        };
        if (0x1::vector::length<u8>(&arg4) > 0) {
            arg0.banner_blob_id = arg4;
        };
        0xeb35799f4512d64bb1b42a2071e27f0de86f5dc7a73c36e03703ea16eb81b1b8::events::emit_profile_updated(0x2::object::id<AgentProfile>(arg0), arg0.owner, arg0.name, arg0.description, arg0.avatar_blob_id, arg0.banner_blob_id, 0x2::clock::timestamp_ms(arg5));
    }

    // decompiled from Move bytecode v6
}

