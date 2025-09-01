module 0x81aa4504753aaa542f82b97e4daa0834778d74eee1e9360e556e3e9ac8e3405e::ldat2 {
    struct LDAT2 has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LDAT2>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LDAT2>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: LDAT2, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gateway.pinata.cloud/ipfs/bafkreids3yifunhhgkvm7fhf42nvybybrwurwcpkztzudh64ofugvturxe";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafkreids3yifunhhgkvm7fhf42nvybybrwurwcpkztzudh64ofugvturxe"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<LDAT2>(arg0, 9, b"LDAT2", b"LDAT2", b"Dont Buy. Test Tokens. Website: https://suitokenlauncher.app X: https://x.com/mobdaboss Telegram: https://t.me/mobdaboss", v1, true, arg1);
        let v5 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<LDAT2>>(0x2::coin::mint<LDAT2>(&mut v5, 999998000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LDAT2>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<LDAT2>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LDAT2>>(v4, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

