module 0x5eb8089ad529432ab17aaa6efbd19449c20d55cc707165fe36452d19731dd8e::morty {
    struct MORTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MORTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MORTY>(arg0, 9, b"morty", b"Morty", b"Morty Morty Morty", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafybeiclmczt7j6dyfwrt6sc7cmaepny3lyjvtytkei46gweptmwdlrttq.ipfs.w3s.link")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MORTY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MORTY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MORTY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

