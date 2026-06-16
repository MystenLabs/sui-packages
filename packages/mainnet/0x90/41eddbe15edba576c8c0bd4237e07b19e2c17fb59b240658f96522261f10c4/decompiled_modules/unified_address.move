module 0x9041eddbe15edba576c8c0bd4237e07b19e2c17fb59b240658f96522261f10c4::unified_address {
    struct UnifiedAddress has copy, drop, store {
        chain_id: u8,
        bytes: vector<u8>,
        identifier: address,
        display: 0x1::string::String,
    }

    fun assert_chain_address_length(arg0: u8, arg1: u64) {
        if (arg0 == 0) {
            assert!(arg1 == 32, invalid_chain_address());
        } else if (arg0 == 1) {
            assert!(arg1 == 20, invalid_chain_address());
        } else {
            assert!(arg0 == 2, invalid_chain_address());
            assert!(arg1 == 32, invalid_chain_address());
        };
    }

    public fun assert_same_chain(arg0: &UnifiedAddress, arg1: &UnifiedAddress) {
        assert!(arg0.chain_id == arg1.chain_id, chain_mismatch());
    }

    public fun base58_encode_solana_pubkey(arg0: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::length<u8>(&arg0);
        assert!(v0 == 32, invalid_chain_address());
        let v1 = 0;
        let v2 = 0;
        while (v2 < v0) {
            let v3 = v1 << 8;
            v1 = v3 | (*0x1::vector::borrow<u8>(&arg0, v2) as u256);
            v2 = v2 + 1;
        };
        let v4 = b"123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz";
        let v5 = 0x1::vector::empty<u8>();
        while (v1 > 0) {
            let v6 = ((v1 % 58) as u64);
            v1 = v1 / 58;
            0x1::vector::push_back<u8>(&mut v5, *0x1::vector::borrow<u8>(&v4, v6));
        };
        let v7 = 0;
        while (v7 < v0 && *0x1::vector::borrow<u8>(&arg0, v7) == 0) {
            0x1::vector::push_back<u8>(&mut v5, *0x1::vector::borrow<u8>(&v4, 0));
            v7 = v7 + 1;
        };
        0x1::vector::reverse<u8>(&mut v5);
        v5
    }

    public fun bytes(arg0: &UnifiedAddress) : vector<u8> {
        arg0.bytes
    }

    public fun chain_id(arg0: &UnifiedAddress) : u8 {
        arg0.chain_id
    }

    public fun chain_id_ethereum() : u8 {
        1
    }

    public fun chain_id_solana() : u8 {
        2
    }

    public fun chain_id_sui() : u8 {
        0
    }

    public fun chain_mismatch() : u64 {
        10002
    }

    public fun display(arg0: &UnifiedAddress) : 0x1::string::String {
        arg0.display
    }

    public fun display_bytes(arg0: &UnifiedAddress) : vector<u8> {
        *0x1::string::as_bytes(&arg0.display)
    }

    public fun display_matches(arg0: &UnifiedAddress, arg1: &0x1::string::String) : bool {
        &arg0.display == arg1
    }

    public fun display_matches_bytes(arg0: &UnifiedAddress, arg1: &vector<u8>) : bool {
        0x1::string::as_bytes(&arg0.display) == arg1
    }

    public fun display_string_from_chain(arg0: u8, arg1: vector<u8>) : 0x1::string::String {
        assert_chain_address_length(arg0, 0x1::vector::length<u8>(&arg1));
        if (arg0 == 0) {
            let v1 = b"Sui:0x";
            0x1::vector::append<u8>(&mut v1, 0x2::hex::encode(arg1));
            0x1::string::utf8(v1)
        } else if (arg0 == 1) {
            let v2 = b"Ethereum:0x";
            0x1::vector::append<u8>(&mut v2, 0x2::hex::encode(arg1));
            0x1::string::utf8(v2)
        } else {
            assert!(arg0 == 2, invalid_chain_address());
            let v3 = b"Solana:";
            0x1::vector::append<u8>(&mut v3, base58_encode_solana_pubkey(arg1));
            0x1::string::utf8(v3)
        }
    }

    public fun equals(arg0: &UnifiedAddress, arg1: &UnifiedAddress) : bool {
        arg0.chain_id == arg1.chain_id && arg0.bytes == arg1.bytes
    }

    public fun evm_address_length() : u64 {
        20
    }

    public fun from_chain_id_and_bytes(arg0: u8, arg1: vector<u8>) : UnifiedAddress {
        UnifiedAddress{
            chain_id   : arg0,
            bytes      : arg1,
            identifier : sui_address_from_chain(arg0, arg1),
            display    : display_string_from_chain(arg0, arg1),
        }
    }

    public fun from_sui_address(arg0: address) : UnifiedAddress {
        from_chain_id_and_bytes(0, 0x2::address::to_bytes(arg0))
    }

    public fun from_tagged_bytes(arg0: vector<u8>) : UnifiedAddress {
        let (v0, v1) = parse_chain_address(arg0);
        from_chain_id_and_bytes(v0, v1)
    }

    public fun get_public_address(arg0: vector<u8>) : address {
        let v0 = 0x2::hash::blake2b256(&arg0);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0;
        while (v2 < 32) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v0, v2));
            v2 = v2 + 1;
        };
        0x2::address::from_bytes(v1)
    }

    public fun identifier(arg0: &UnifiedAddress) : address {
        arg0.identifier
    }

    public fun invalid_chain_address() : u64 {
        10001
    }

    public fun is_sui(arg0: &UnifiedAddress) : bool {
        arg0.chain_id == 0
    }

    public fun parse_chain_address(arg0: vector<u8>) : (u8, vector<u8>) {
        let v0 = 0x1::vector::length<u8>(&arg0);
        assert!(v0 >= 1, invalid_chain_address());
        let v1 = *0x1::vector::borrow<u8>(&arg0, 0);
        let v2 = 0x1::vector::empty<u8>();
        let v3 = 1;
        while (v3 < v0) {
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&arg0, v3));
            v3 = v3 + 1;
        };
        assert_chain_address_length(v1, 0x1::vector::length<u8>(&v2));
        (v1, v2)
    }

    public fun solana_pubkey_length() : u64 {
        32
    }

    public fun sui_address_from_chain(arg0: u8, arg1: vector<u8>) : address {
        assert_chain_address_length(arg0, 0x1::vector::length<u8>(&arg1));
        if (arg0 == 0) {
            0x2::address::from_bytes(arg1)
        } else if (arg0 == 1) {
            sui_address_from_evm_address(arg1)
        } else {
            assert!(arg0 == 2, invalid_chain_address());
            sui_address_from_solana_pubkey(arg1)
        }
    }

    fun sui_address_from_evm_address(arg0: vector<u8>) : address {
        let v0 = b"Dipcoin Unified Address";
        0x1::vector::push_back<u8>(&mut v0, 4);
        0x1::vector::append<u8>(&mut v0, arg0);
        get_public_address(v0)
    }

    fun sui_address_from_solana_pubkey(arg0: vector<u8>) : address {
        let v0 = b"Dipcoin Unified Address";
        0x1::vector::push_back<u8>(&mut v0, 5);
        0x1::vector::append<u8>(&mut v0, arg0);
        get_public_address(v0)
    }

    public fun sui_address_length() : u64 {
        32
    }

    // decompiled from Move bytecode v7
}

