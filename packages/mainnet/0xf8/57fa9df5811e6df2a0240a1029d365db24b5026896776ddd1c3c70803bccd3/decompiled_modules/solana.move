module 0xf857fa9df5811e6df2a0240a1029d365db24b5026896776ddd1c3c70803bccd3::solana {
    struct Solana has drop {
        dummy_field: bool,
    }

    public fun solana(arg0: &0xf857fa9df5811e6df2a0240a1029d365db24b5026896776ddd1c3c70803bccd3::suilink::AdminCap) : Solana {
        Solana{dummy_field: false}
    }

    public fun link<T0>(arg0: &mut 0xf857fa9df5811e6df2a0240a1029d365db24b5026896776ddd1c3c70803bccd3::suilink::SuiLinkRegistry, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"Welcome to SuiLink! Sign this message to link your Solana wallet to SUI address 0x");
        let v1 = 0x2::address::to_string(0x2::tx_context::sender(arg4));
        0x1::string::append_utf8(&mut v0, *0x1::string::bytes(&v1));
        0x1::string::append_utf8(&mut v0, b". No blockchain transaction or gas cost required.");
        assert!(0x2::ed25519::ed25519_verify(&arg1, &arg3, 0x1::string::bytes(&v0)), 0);
        0xf857fa9df5811e6df2a0240a1029d365db24b5026896776ddd1c3c70803bccd3::suilink::mint<T0>(arg0, 0xf857fa9df5811e6df2a0240a1029d365db24b5026896776ddd1c3c70803bccd3::utils::hex_to_base58(arg3), arg2, arg4);
    }

    // decompiled from Move bytecode v6
}

