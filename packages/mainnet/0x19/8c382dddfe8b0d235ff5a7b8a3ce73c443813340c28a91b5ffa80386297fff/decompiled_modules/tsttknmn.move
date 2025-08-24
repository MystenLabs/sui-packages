module 0x198c382dddfe8b0d235ff5a7b8a3ce73c443813340c28a91b5ffa80386297fff::tsttknmn {
    struct TSTTKNMN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TSTTKNMN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TSTTKNMN>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: TSTTKNMN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gateway.pinata.cloud/ipfs/bafkreigjiqrijocjvi3qpwkw5jovju7focozok3lwkomda3tiewvlopnyy";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafkreigjiqrijocjvi3qpwkw5jovju7focozok3lwkomda3tiewvlopnyy"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<TSTTKNMN>(arg0, 9, b"TSTTKNMN", b"Tester TKN", b"Test Website: https://scantset.test X: https://x.com/scannertest Telegram: https://t.me/scantest1 Discord: https://discord.gg/1234-SCNT", v1, true, arg1);
        let v5 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<TSTTKNMN>>(0x2::coin::mint<TSTTKNMN>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSTTKNMN>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<TSTTKNMN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TSTTKNMN>>(v4, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

