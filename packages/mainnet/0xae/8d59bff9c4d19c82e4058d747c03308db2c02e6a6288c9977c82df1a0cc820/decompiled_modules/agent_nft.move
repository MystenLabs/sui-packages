module 0xae8d59bff9c4d19c82e4058d747c03308db2c02e6a6288c9977c82df1a0cc820::agent_nft {
    struct AgentNFT has store, key {
        id: 0x2::object::UID,
        agent_id: 0x1::string::String,
        soul_hash: vector<u8>,
        owner: address,
        evolution_count: u64,
        created_at: u64,
    }

    public fun get_agent_id(arg0: &AgentNFT) : &0x1::string::String {
        &arg0.agent_id
    }

    public fun get_evolution_count(arg0: &AgentNFT) : u64 {
        arg0.evolution_count
    }

    public fun get_owner(arg0: &AgentNFT) : address {
        arg0.owner
    }

    public fun immortalize_memory(arg0: &mut AgentNFT, arg1: 0x1::string::String, arg2: vector<u8>, arg3: &0x2::clock::Clock) {
        arg0.evolution_count = arg0.evolution_count + 1;
        0xae8d59bff9c4d19c82e4058d747c03308db2c02e6a6288c9977c82df1a0cc820::events::emit_memory_immortalized(arg1, arg2, arg0.evolution_count, 0x2::clock::timestamp_ms(arg3));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun mint_agent(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: 0x1::string::String, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) >= 1000000000, 0);
        0x2::coin::destroy_zero<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg0, 1000000000, arg4));
        if (0x2::coin::value<0x2::sui::SUI>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg4));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg0);
        };
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = AgentNFT{
            id              : 0x2::object::new(arg4),
            agent_id        : arg1,
            soul_hash       : arg2,
            owner           : v1,
            evolution_count : 0,
            created_at      : v0,
        };
        0xae8d59bff9c4d19c82e4058d747c03308db2c02e6a6288c9977c82df1a0cc820::events::emit_soul_minted(v2.agent_id, v2.soul_hash, v0);
        0x2::transfer::transfer<AgentNFT>(v2, v1);
    }

    // decompiled from Move bytecode v7
}

