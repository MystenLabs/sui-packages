module 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::address_system {
    fun base58_decode(arg0: 0x1::ascii::String) : vector<u8> {
        let v0 = b"123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz";
        let v1 = 0x1::ascii::as_bytes(&arg0);
        let v2 = b"";
        let v3 = 0;
        while (v3 < 32) {
            0x1::vector::push_back<u8>(&mut v2, 0);
            v3 = v3 + 1;
        };
        let v4 = 0;
        while (v4 < 0x1::vector::length<u8>(v1)) {
            let v5 = 0;
            let v6 = false;
            let v7 = 0;
            while (v7 < 58) {
                if (*0x1::vector::borrow<u8>(&v0, v7) == *0x1::vector::borrow<u8>(v1, v4)) {
                    v5 = v7;
                    v6 = true;
                    break
                };
                v7 = v7 + 1;
            };
            assert!(v6, 2);
            let v8 = v5;
            let v9 = 32 - 1;
            while (v9 < 32) {
                let v10 = 0x1::vector::borrow_mut<u8>(&mut v2, v9);
                let v11 = (*v10 as u64) * 58 + v8;
                v8 = v11 / 256;
                *v10 = ((v11 % 256) as u8);
                if (v9 == 0) {
                    break
                };
                v9 = v9 - 1;
            };
            v4 = v4 + 1;
        };
        v2
    }

    fun base58_encode(arg0: vector<u8>) : 0x1::ascii::String {
        let v0 = b"123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz";
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<u8>(&arg0)) {
            if (*0x1::vector::borrow<u8>(&arg0, v3) == 0) {
                v2 = v2 + 1;
                v3 = v3 + 1;
            } else {
                break
            };
        };
        while (!is_zero(&arg0)) {
            let v4 = &mut arg0;
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v0, div_mod_58(v4)));
        };
        let v5 = 0;
        while (v5 < v2) {
            0x1::vector::push_back<u8>(&mut v1, 49);
            v5 = v5 + 1;
        };
        0x1::vector::reverse<u8>(&mut v1);
        0x1::ascii::string(v1)
    }

    fun detect_chain_type_from_tx_hash(arg0: &vector<u8>) : u8 {
        let v0 = if (0x1::vector::length<u8>(arg0) != 32) {
            true
        } else if (*0x1::vector::borrow<u8>(arg0, 0) != 219) {
            true
        } else if (*0x1::vector::borrow<u8>(arg0, 1) != 219) {
            true
        } else {
            *0x1::vector::borrow<u8>(arg0, 2) != 1
        };
        if (v0) {
            return 0
        };
        let v1 = *0x1::vector::borrow<u8>(arg0, 3);
        if (v1 == 225) {
            1
        } else if (v1 == 226) {
            2
        } else {
            0
        }
    }

    fun div_mod_58(arg0: &mut vector<u8>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            let v2 = 0x1::vector::borrow_mut<u8>(arg0, v1);
            let v3 = v0 * 256 + (*v2 as u64);
            *v2 = ((v3 / 58) as u8);
            v0 = v3 % 58;
            v1 = v1 + 1;
        };
        v0
    }

    public fun ensure_origin<T0: copy + drop>(arg0: &0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: &0x2::tx_context::TxContext) : 0x1::ascii::String {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::address::to_bytes(v0);
        let v2 = detect_chain_type_from_tx_hash(0x2::tx_context::digest(arg1));
        if (v2 == 1) {
            let v4 = b"";
            let v5 = 12;
            while (v5 < 32) {
                0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v1, v5));
                v5 = v5 + 1;
            };
            0x1::ascii::string(0x2::hex::encode(v4))
        } else if (v2 == 2) {
            base58_encode(v1)
        } else {
            let v6 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
            let v7 = 0x2::address::to_ascii_string(v0);
            if (0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::proxy_config::has(arg0, v6, v7)) {
                let (v8, v9) = 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::proxy_config::get(arg0, v6, v7);
                if (0x2::tx_context::epoch_timestamp_ms(arg1) < v9) {
                    return v8
                };
            };
            0x1::ascii::string(0x2::hex::encode(v1))
        }
    }

    public fun evm_to_sui(arg0: 0x1::ascii::String) : address {
        let v0 = hex_string_to_bytes(arg0);
        assert!(0x1::vector::length<u8>(&v0) == 20, 1);
        let v1 = b"";
        let v2 = 0;
        while (v2 < 12) {
            0x1::vector::push_back<u8>(&mut v1, 0);
            v2 = v2 + 1;
        };
        0x1::vector::append<u8>(&mut v1, v0);
        0x2::address::from_bytes(v1)
    }

    fun hex_string_to_bytes(arg0: 0x1::ascii::String) : vector<u8> {
        let v0 = 0x1::ascii::into_bytes(arg0);
        let v1 = if (0x1::vector::length<u8>(&v0) >= 2) {
            if (*0x1::vector::borrow<u8>(&v0, 0) == 48) {
                *0x1::vector::borrow<u8>(&v0, 1) == 120 || *0x1::vector::borrow<u8>(&v0, 1) == 88
            } else {
                false
            }
        } else {
            false
        };
        let v2 = if (v1) {
            let v3 = b"";
            let v4 = 2;
            while (v4 < 0x1::vector::length<u8>(&v0)) {
                0x1::vector::push_back<u8>(&mut v3, *0x1::vector::borrow<u8>(&v0, v4));
                v4 = v4 + 1;
            };
            v3
        } else {
            v0
        };
        0x2::hex::decode(v2)
    }

    public fun is_evm_address(arg0: &0x2::tx_context::TxContext) : bool {
        detect_chain_type_from_tx_hash(0x2::tx_context::digest(arg0)) == 1
    }

    public fun is_solana_address(arg0: &0x2::tx_context::TxContext) : bool {
        detect_chain_type_from_tx_hash(0x2::tx_context::digest(arg0)) == 2
    }

    public fun is_sui_address(arg0: &0x2::tx_context::TxContext) : bool {
        detect_chain_type_from_tx_hash(0x2::tx_context::digest(arg0)) == 0
    }

    fun is_zero(arg0: &vector<u8>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            if (*0x1::vector::borrow<u8>(arg0, v0) != 0) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public fun solana_to_sui(arg0: 0x1::ascii::String) : address {
        let v0 = base58_decode(arg0);
        assert!(0x1::vector::length<u8>(&v0) == 32, 2);
        0x2::address::from_bytes(v0)
    }

    // decompiled from Move bytecode v6
}

