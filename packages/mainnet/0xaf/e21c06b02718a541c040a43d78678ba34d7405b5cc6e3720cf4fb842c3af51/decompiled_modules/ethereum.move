module 0xf857fa9df5811e6df2a0240a1029d365db24b5026896776ddd1c3c70803bccd3::ethereum {
    struct Ethereum has drop {
        dummy_field: bool,
    }

    public fun ethereum(arg0: &0xf857fa9df5811e6df2a0240a1029d365db24b5026896776ddd1c3c70803bccd3::suilink::AdminCap) : Ethereum {
        Ethereum{dummy_field: false}
    }

    fun ecrecover_eth_address(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::borrow_mut<u8>(&mut arg0, 64);
        if (*v0 == 27) {
            *v0 = 0;
        } else if (*v0 == 28) {
            *v0 = 1;
        } else if (*v0 > 35) {
            *v0 = (*v0 - 1) % 2;
        };
        let v1 = 0x2::ecdsa_k1::secp256k1_ecrecover(&arg0, &arg1, 0);
        let v2 = 0x2::ecdsa_k1::decompress_pubkey(&v1);
        let v3 = b"";
        let v4 = 1;
        while (v4 < 65) {
            0x1::vector::push_back<u8>(&mut v3, *0x1::vector::borrow<u8>(&v2, v4));
            v4 = v4 + 1;
        };
        let v5 = 0x2::hash::keccak256(&v3);
        let v6 = b"";
        let v7 = 12;
        while (v7 < 32) {
            0x1::vector::push_back<u8>(&mut v6, *0x1::vector::borrow<u8>(&v5, v7));
            v7 = v7 + 1;
        };
        v6
    }

    public fun link<T0>(arg0: &mut 0xf857fa9df5811e6df2a0240a1029d365db24b5026896776ddd1c3c70803bccd3::suilink::SuiLinkRegistry, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        abort 1
    }

    public fun link_v2(arg0: &mut 0xf857fa9df5811e6df2a0240a1029d365db24b5026896776ddd1c3c70803bccd3::registry_v2::SuiLinkRegistryV2, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(x"19457468657265756d205369676e6564204d6573736167653a0a31393757656c636f6d6520746f205375694c696e6b21205369676e2074686973206d65737361676520746f206c696e6b20796f757220457468657265756d2077616c6c657420746f205355492061646472657373203078");
        let v1 = 0x2::address::to_string(0x2::tx_context::sender(arg3));
        0x1::string::append_utf8(&mut v0, *0x1::string::bytes(&v1));
        0x1::string::append_utf8(&mut v0, b". No blockchain transaction or gas cost required.");
        0xf857fa9df5811e6df2a0240a1029d365db24b5026896776ddd1c3c70803bccd3::registry_v2::mint<Ethereum>(arg0, 0xf857fa9df5811e6df2a0240a1029d365db24b5026896776ddd1c3c70803bccd3::utils::bytes_to_hex(ecrecover_eth_address(arg1, *0x1::string::bytes(&v0))), arg2, 0, arg3);
    }

    // decompiled from Move bytecode v6
}

