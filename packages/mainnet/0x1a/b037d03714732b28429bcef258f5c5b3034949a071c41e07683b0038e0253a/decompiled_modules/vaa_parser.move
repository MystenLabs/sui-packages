module 0x1ab037d03714732b28429bcef258f5c5b3034949a071c41e07683b0038e0253a::vaa_parser {
    struct ParsedTransfer has copy, drop {
        token_address: vector<u8>,
        token_chain: u16,
    }

    public fun extract_payload_type(arg0: vector<u8>) : u8 {
        *0x1::vector::borrow<u8>(&arg0, get_payload_offset(arg0))
    }

    fun get_payload_offset(arg0: vector<u8>) : u64 {
        let v0 = 0x1::vector::length<u8>(&arg0);
        assert!(v0 >= 6, 1);
        let v1 = 0 + 1 + 4;
        let v2 = *0x1::vector::borrow<u8>(&arg0, v1);
        assert!(v2 <= 19, 2);
        assert!(v0 >= 6 + 66 * (v2 as u64) + 57, 1);
        v1 + 1 + 66 * (v2 as u64) + 4 + 4 + 2 + 32 + 8 + 1
    }

    public fun parse_transfer_info(arg0: vector<u8>) : ParsedTransfer {
        validate_transfer_with_payload(arg0);
        let v0 = get_payload_offset(arg0);
        assert!(0x1::vector::length<u8>(&arg0) >= v0 + 67, 1);
        let v1 = v0 + 1 + 32;
        let v2 = 0x1::vector::empty<u8>();
        let v3 = 0;
        while (v3 < 32) {
            0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(&arg0, v1 + v3));
            v3 = v3 + 1;
        };
        let v4 = v1 + 32;
        ParsedTransfer{
            token_address : v2,
            token_chain   : (*0x1::vector::borrow<u8>(&arg0, v4) as u16) << 8 | (*0x1::vector::borrow<u8>(&arg0, v4 + 1) as u16),
        }
    }

    public fun token_address(arg0: &ParsedTransfer) : vector<u8> {
        arg0.token_address
    }

    public fun token_chain(arg0: &ParsedTransfer) : u16 {
        arg0.token_chain
    }

    public fun validate_transfer_with_payload(arg0: vector<u8>) {
        assert!(extract_payload_type(arg0) == 3, 0);
    }

    // decompiled from Move bytecode v6
}

