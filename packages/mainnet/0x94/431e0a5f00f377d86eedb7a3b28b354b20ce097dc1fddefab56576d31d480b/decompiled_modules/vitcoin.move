module 0x94431e0a5f00f377d86eedb7a3b28b354b20ce097dc1fddefab56576d31d480b::vitcoin {
    struct VITCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: VITCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg1) == 678 || 0x2::tx_context::epoch(arg1) == 679, 1);
        let (v0, v1) = 0x2::coin::create_currency<VITCOIN>(arg0, 4, b"vtc", b"vitcoin", b"Vitcoin is a form of hard money that enables peer-to-peer transactions without intermediaries like banks or governments. It operates on a public database called a blockchain that records all transactions transparently and securely", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://bafkreig4oluvrca5unuqvocuvedkytujqlkdmvhu6al7m4smj3mut6avke.ipfs.w3s.link/"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<VITCOIN>(&mut v2, 18000000000000000, @0xbf7b7831b08f6ccea19e0d321c86682588ea61923bb99173c49ea50865cdec8e, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VITCOIN>>(v2, @0xbf7b7831b08f6ccea19e0d321c86682588ea61923bb99173c49ea50865cdec8e);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VITCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

