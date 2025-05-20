module 0x2a36238690e7c68d970c6383a97567fbd8b207b35edefdee93e0d499733b49ff::testing {
    struct TESTING has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTING>(arg0, 6, b"TESTING", b"test", b"THIS TESTER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibiinybonops3lw2jx6bcm5ydzk33oktpu55k7uovopsua4bl5b3m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TESTING>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

