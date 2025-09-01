module 0xfc6ab9e1c6a322951424ee36c35e7a0367f64a5f060bcb907e916a7437d5af0d::firsttkn {
    struct FIRSTTKN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FIRSTTKN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FIRSTTKN>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: FIRSTTKN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gateway.pinata.cloud/ipfs/bafybeihl43y5slnzavn534ytxazmhh2fcqugjtly3yv7jgfzkceg4bw5ry";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafybeihl43y5slnzavn534ytxazmhh2fcqugjtly3yv7jgfzkceg4bw5ry"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<FIRSTTKN>(arg0, 9, b"FIRSTTKN", b"1ST Tester MN", b"DONT BUY. This is Test Website: https://suitokenlauncher.app X: https://x.com/mobdaboss Telegram: https://t.me/mobdaboss", v1, true, arg1);
        let v5 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<FIRSTTKN>>(0x2::coin::mint<FIRSTTKN>(&mut v5, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIRSTTKN>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<FIRSTTKN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FIRSTTKN>>(v4, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

