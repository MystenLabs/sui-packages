module 0xc4407c6ae60aec1fb087a515fc9216eea306eac3f8ae5168f4b09b3c3e2bdbf1::hook_data {
    struct DecodedHookData has drop {
        src_evm_address: vector<u8>,
        net_hint: u64,
        memo: vector<u8>,
    }

    fun append_address_word(arg0: &mut vector<u8>, arg1: address) {
        let v0 = 0x1::bcs::to_bytes<address>(&arg1);
        let v1 = 0;
        while (v1 < 12) {
            0x1::vector::push_back<u8>(arg0, 0);
            v1 = v1 + 1;
        };
        let v2 = 12;
        while (v2 < 32) {
            0x1::vector::push_back<u8>(arg0, *0x1::vector::borrow<u8>(&v0, v2));
            v2 = v2 + 1;
        };
    }

    fun append_padding(arg0: &mut vector<u8>, arg1: u64) {
        let v0 = arg1 % 32;
        if (v0 == 0) {
            return
        };
        let v1 = 0;
        while (v1 < 32 - v0) {
            0x1::vector::push_back<u8>(arg0, 0);
            v1 = v1 + 1;
        };
    }

    fun append_u64_word(arg0: &mut vector<u8>, arg1: u64) {
        let v0 = 0;
        while (v0 < 24) {
            0x1::vector::push_back<u8>(arg0, 0);
            v0 = v0 + 1;
        };
        0x1::vector::push_back<u8>(arg0, ((arg1 / 72057594037927936 % 256) as u8));
        0x1::vector::push_back<u8>(arg0, ((arg1 / 281474976710656 % 256) as u8));
        0x1::vector::push_back<u8>(arg0, ((arg1 / 1099511627776 % 256) as u8));
        0x1::vector::push_back<u8>(arg0, ((arg1 / 4294967296 % 256) as u8));
        0x1::vector::push_back<u8>(arg0, ((arg1 / 16777216 % 256) as u8));
        0x1::vector::push_back<u8>(arg0, ((arg1 / 65536 % 256) as u8));
        0x1::vector::push_back<u8>(arg0, ((arg1 / 256 % 256) as u8));
        0x1::vector::push_back<u8>(arg0, ((arg1 % 256) as u8));
    }

    fun assert_selector(arg0: &vector<u8>) {
        assert!(selector_matches(arg0), 1);
    }

    public fun decode(arg0: &vector<u8>) : DecodedHookData {
        assert!(0x1::vector::length<u8>(arg0) >= 100 + 32, 2);
        assert_selector(arg0);
        assert!(read_u64_word(arg0, 4 + 32 + 32) == 96, 3);
        let v0 = read_u64_word(arg0, 100);
        assert!(0x1::vector::length<u8>(arg0) == 100 + 32 + padded_len(v0), 4);
        DecodedHookData{
            src_evm_address : read_evm_address(arg0),
            net_hint        : read_u64_word(arg0, 4 + 32),
            memo            : read_bytes(arg0, 100 + 32, v0),
        }
    }

    public fun encode(arg0: address, arg1: u64, arg2: vector<u8>) : vector<u8> {
        let v0 = on_receive_selector();
        let v1 = &mut v0;
        append_address_word(v1, arg0);
        let v2 = &mut v0;
        append_u64_word(v2, arg1);
        let v3 = &mut v0;
        append_u64_word(v3, 96);
        let v4 = &mut v0;
        append_u64_word(v4, 0x1::vector::length<u8>(&arg2));
        0x1::vector::append<u8>(&mut v0, arg2);
        let v5 = &mut v0;
        append_padding(v5, 0x1::vector::length<u8>(&arg2));
        v0
    }

    public fun memo(arg0: &DecodedHookData) : vector<u8> {
        arg0.memo
    }

    public fun net_hint(arg0: &DecodedHookData) : u64 {
        arg0.net_hint
    }

    public fun on_receive_selector() : vector<u8> {
        x"8baa69ea"
    }

    fun padded_len(arg0: u64) : u64 {
        let v0 = arg0 % 32;
        if (v0 == 0) {
            arg0
        } else {
            arg0 + 32 - v0
        }
    }

    fun read_bytes(arg0: &vector<u8>, arg1: u64, arg2: u64) : vector<u8> {
        let v0 = b"";
        let v1 = 0;
        while (v1 < arg2) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, arg1 + v1));
            v1 = v1 + 1;
        };
        v0
    }

    fun read_evm_address(arg0: &vector<u8>) : vector<u8> {
        read_bytes(arg0, 4 + 12, 20)
    }

    fun read_u64_word(arg0: &vector<u8>, arg1: u64) : u64 {
        let v0 = 0;
        let v1 = 24;
        while (v1 < 32) {
            let v2 = v0 * 256;
            v0 = v2 + (*0x1::vector::borrow<u8>(arg0, arg1 + v1) as u64);
            v1 = v1 + 1;
        };
        v0
    }

    public fun selector_matches(arg0: &vector<u8>) : bool {
        if (0x1::vector::length<u8>(arg0) >= 4) {
            if (*0x1::vector::borrow<u8>(arg0, 0) == 139) {
                if (*0x1::vector::borrow<u8>(arg0, 1) == 170) {
                    if (*0x1::vector::borrow<u8>(arg0, 2) == 105) {
                        *0x1::vector::borrow<u8>(arg0, 3) == 234
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun src_evm_address(arg0: &DecodedHookData) : vector<u8> {
        arg0.src_evm_address
    }

    // decompiled from Move bytecode v7
}

