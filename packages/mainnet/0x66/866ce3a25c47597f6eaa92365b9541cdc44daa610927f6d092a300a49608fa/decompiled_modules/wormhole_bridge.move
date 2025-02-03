module 0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::wormhole_bridge {
    struct NFTRegistered has copy, drop {
        origin_chain: u16,
        token_id: u64,
        collection_address: vector<u8>,
        name: vector<u8>,
    }

    public fun bytes_to_string(arg0: vector<u8>) : vector<u8> {
        arg0
    }

    public fun get_clock(arg0: &0x2::clock::Clock) : u8 {
        14
    }

    public fun get_user_registry(arg0: &mut 0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::nft_market::UserRegistry) : u8 {
        12
    }

    public fun get_vaa_emitter_chain(arg0: &0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::vaa::VAA) : u16 {
        0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::vaa::emitter_chain(arg0)
    }

    public fun get_vaa_sequence(arg0: &0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::vaa::VAA) : u64 {
        0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::vaa::sequence(arg0)
    }

    public fun get_wormhole_state(arg0: &0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::state::State) : u8 {
        11
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    fun parse_nft_data(arg0: vector<u8>) : (vector<u8>, vector<u8>, u64, vector<u8>, vector<u8>) {
        let v0 = 0x1::vector::length<u8>(&arg0);
        let v1 = b"Payload length:";
        0x1::debug::print<vector<u8>>(&v1);
        0x1::debug::print<u64>(&v0);
        assert!(v0 >= 74, 1001);
        let v2 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&arg0, 0));
        0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&arg0, 1));
        let v3 = 0x1::vector::empty<u8>();
        let v4 = 2;
        while (v4 < 34) {
            0x1::vector::push_back<u8>(&mut v3, *0x1::vector::borrow<u8>(&arg0, v4));
            v4 = v4 + 1;
        };
        let v5 = b"Owner address:";
        0x1::debug::print<vector<u8>>(&v5);
        0x1::debug::print<vector<u8>>(&v3);
        let v6 = 0x1::vector::empty<u8>();
        let v7 = 42;
        while (v7 < 74) {
            0x1::vector::push_back<u8>(&mut v6, *0x1::vector::borrow<u8>(&arg0, v7));
            v7 = v7 + 1;
        };
        let v8 = 0x1::vector::empty<u8>();
        let v9 = 74;
        while (v9 < v0) {
            0x1::vector::push_back<u8>(&mut v8, *0x1::vector::borrow<u8>(&arg0, v9));
            v9 = v9 + 1;
        };
        (v2, v3, read_u64_at_index(&arg0, 34), v6, v8)
    }

    public fun prepare_vaa_bytes(arg0: vector<u8>) : u8 {
        13
    }

    fun read_bytes(arg0: &vector<u8>, arg1: u64, arg2: u64) : (vector<u8>, u64) {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < arg2) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, arg1 + v1));
            v1 = v1 + 1;
        };
        (v0, arg1 + arg2)
    }

    fun read_u16(arg0: &mut vector<u8>) : u16 {
        (0x1::vector::pop_back<u8>(arg0) as u16) << 8 | (0x1::vector::pop_back<u8>(arg0) as u16)
    }

    fun read_u16_at_index(arg0: &vector<u8>, arg1: u64) : u16 {
        (*0x1::vector::borrow<u8>(arg0, arg1) as u16) << 8 | (*0x1::vector::borrow<u8>(arg0, arg1 + 1) as u16)
    }

    fun read_u32(arg0: &mut vector<u8>) : u32 {
        (0x1::vector::pop_back<u8>(arg0) as u32) << 24 | (0x1::vector::pop_back<u8>(arg0) as u32) << 16 | (0x1::vector::pop_back<u8>(arg0) as u32) << 8 | (0x1::vector::pop_back<u8>(arg0) as u32)
    }

    fun read_u32_at_index(arg0: &vector<u8>, arg1: u64) : u32 {
        (*0x1::vector::borrow<u8>(arg0, arg1) as u32) << 24 | (*0x1::vector::borrow<u8>(arg0, arg1 + 1) as u32) << 16 | (*0x1::vector::borrow<u8>(arg0, arg1 + 2) as u32) << 8 | (*0x1::vector::borrow<u8>(arg0, arg1 + 3) as u32)
    }

    fun read_u64(arg0: &mut vector<u8>) : u64 {
        (0x1::vector::pop_back<u8>(arg0) as u64) << 56 | (0x1::vector::pop_back<u8>(arg0) as u64) << 48 | (0x1::vector::pop_back<u8>(arg0) as u64) << 40 | (0x1::vector::pop_back<u8>(arg0) as u64) << 32 | (0x1::vector::pop_back<u8>(arg0) as u64) << 24 | (0x1::vector::pop_back<u8>(arg0) as u64) << 16 | (0x1::vector::pop_back<u8>(arg0) as u64) << 8 | (0x1::vector::pop_back<u8>(arg0) as u64)
    }

    fun read_u64_at_index(arg0: &vector<u8>, arg1: u64) : u64 {
        (*0x1::vector::borrow<u8>(arg0, arg1) as u64) << 56 | (*0x1::vector::borrow<u8>(arg0, arg1 + 1) as u64) << 48 | (*0x1::vector::borrow<u8>(arg0, arg1 + 2) as u64) << 40 | (*0x1::vector::borrow<u8>(arg0, arg1 + 3) as u64) << 32 | (*0x1::vector::borrow<u8>(arg0, arg1 + 4) as u64) << 24 | (*0x1::vector::borrow<u8>(arg0, arg1 + 5) as u64) << 16 | (*0x1::vector::borrow<u8>(arg0, arg1 + 6) as u64) << 8 | (*0x1::vector::borrow<u8>(arg0, arg1 + 7) as u64)
    }

    public fun register_nft_from_vaa(arg0: &0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::state::State, arg1: &mut 0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::nft_market::UserRegistry, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::vaa::VAA {
        let v0 = verify_and_parse_vaa(arg0, arg2, arg3);
        let v1 = 0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::vaa::payload(&v0);
        0x1::debug::print<vector<u8>>(&v1);
        assert!(0x1::vector::length<u8>(&v1) >= 74, 1);
        let (v2, v3, v4, v5, v6) = parse_nft_data(v1);
        0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::nft_market::register_wormhole_nft(arg1, v2, v3, v4, v5, v6, arg4);
        let v7 = NFTRegistered{
            origin_chain       : 0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::vaa::emitter_chain(&v0),
            token_id           : v4,
            collection_address : v5,
            name               : v6,
        };
        0x2::event::emit<NFTRegistered>(v7);
        v0
    }

    public fun verify_and_parse_vaa(arg0: &0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::state::State, arg1: vector<u8>, arg2: &0x2::clock::Clock) : 0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::vaa::VAA {
        0x1::debug::print<vector<u8>>(&arg1);
        0x66866ce3a25c47597f6eaa92365b9541cdc44daa610927f6d092a300a49608fa::vaa::parse_and_verify(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

