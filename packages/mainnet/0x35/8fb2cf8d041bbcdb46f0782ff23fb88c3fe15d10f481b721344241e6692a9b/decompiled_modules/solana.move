module 0xf857fa9df5811e6df2a0240a1029d365db24b5026896776ddd1c3c70803bccd3::solana {
    struct Solana has drop {
        dummy_field: bool,
    }

    public fun solana(arg0: &0xf857fa9df5811e6df2a0240a1029d365db24b5026896776ddd1c3c70803bccd3::suilink::AdminCap) : Solana {
        Solana{dummy_field: false}
    }

    public fun link<T0>(arg0: &mut 0xf857fa9df5811e6df2a0240a1029d365db24b5026896776ddd1c3c70803bccd3::suilink::SuiLinkRegistry, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        abort 1
    }

    public fun link_v2(arg0: &mut 0xf857fa9df5811e6df2a0240a1029d365db24b5026896776ddd1c3c70803bccd3::registry_v2::SuiLinkRegistryV2, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xf857fa9df5811e6df2a0240a1029d365db24b5026896776ddd1c3c70803bccd3::utils::hex_to_base58(arg3);
        let v1 = 0x1::string::utf8(x"57656c636f6d6520746f205375694c696e6b210a0a53696d706c79207369676e2074686973206d65737361676520746f20636f6e6e65637420796f757220536f6c616e61206164647265737320746f20796f75722053756920616464726573732e204974277320717569636b20616e64207365637572652c20706c7573206e6f207472616e73616374696f6e206f722067617320666565732e0a0a536f6c616e6120616464726573733a20");
        0x1::string::append_utf8(&mut v1, *0x1::string::bytes(&v0));
        let v2 = 0x1::string::utf8(x"0a53756920416464726573733a203078");
        0x1::string::append_utf8(&mut v1, *0x1::string::bytes(&v2));
        let v3 = 0x2::address::to_string(0x2::tx_context::sender(arg4));
        0x1::string::append_utf8(&mut v1, *0x1::string::bytes(&v3));
        assert!(0x2::ed25519::ed25519_verify(&arg1, &arg3, 0x1::string::bytes(&v1)), 0);
        0xf857fa9df5811e6df2a0240a1029d365db24b5026896776ddd1c3c70803bccd3::registry_v2::mint<Solana>(arg0, v0, arg2, 1, arg4);
    }

    // decompiled from Move bytecode v6
}

