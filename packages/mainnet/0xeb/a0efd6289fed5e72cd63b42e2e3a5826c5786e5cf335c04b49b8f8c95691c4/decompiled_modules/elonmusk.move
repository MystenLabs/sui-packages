module 0xeba0efd6289fed5e72cd63b42e2e3a5826c5786e5cf335c04b49b8f8c95691c4::elonmusk {
    struct ELONMUSK has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELONMUSK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELONMUSK>(arg0, 9, b"ElonMusk", b"SATOSHI NAKAMOTO", b"Elon is the real Satoshi Nukumutu and you guys could not accept the truth", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/7zaQb3Sqpisqw3JZnUT5qnx7PWCwGcVPK84goy5vpump.png?size=lg&key=3f50a2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ELONMUSK>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELONMUSK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELONMUSK>>(v1);
    }

    // decompiled from Move bytecode v6
}

