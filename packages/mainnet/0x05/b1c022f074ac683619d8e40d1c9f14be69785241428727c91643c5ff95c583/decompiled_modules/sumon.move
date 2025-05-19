module 0x5b1c022f074ac683619d8e40d1c9f14be69785241428727c91643c5ff95c583::sumon {
    struct SUMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUMON>(arg0, 6, b"SUMON", b"Sui Sumon", b"Sumon is the most unique Pokemon in Sui, with its running speed it can surpass all other Pokemon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifyuovah7ujugpba4ygi2wwqguw3brflmr4ypcxtktuqsrhnt2pti")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUMON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

