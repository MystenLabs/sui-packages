module 0xa2eb1c312abf2e369d0d7aed811c5d7779e7747fee536dad51f744f934412784::blastcat {
    struct BLASTCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLASTCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLASTCAT>(arg0, 9, b"BLASTCAT", b"BLASTCAT", b"BLASTCAT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://launchdesk.38.242.215.238.sslip.io/assets/527636fd1222edf58df9632d9d98de081134e30361ef2faa0e81dcebf8d88fed.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLASTCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLASTCAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

