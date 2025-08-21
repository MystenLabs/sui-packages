module 0x27c627489f07f51049b3162b9e7187b0060a3c53e7404ca600016df7f8ba0d1d::ttst01 {
    struct TTST01 has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TTST01>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TTST01>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: TTST01, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gateway.pinata.cloud/ipfs/bafybeid5akevipfygeojaaiqqg6qrbv4tla4ct7vphuga443af5wdndvaa";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafybeid5akevipfygeojaaiqqg6qrbv4tla4ct7vphuga443af5wdndvaa"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<TTST01>(arg0, 9, b"TTST01", b"Token Test 01", b"TKNTST01 Website: https://testtset.test X: https://x.com/testertest Telegram: https://t.me/testerlink Discord: https://discord.gg/1234-abcd", v1, false, arg1);
        let v5 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<TTST01>>(0x2::coin::mint<TTST01>(&mut v5, 999999999000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTST01>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<TTST01>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TTST01>>(v4, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

