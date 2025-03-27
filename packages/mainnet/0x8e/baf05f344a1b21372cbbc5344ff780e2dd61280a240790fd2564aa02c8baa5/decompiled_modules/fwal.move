module 0x8ebaf05f344a1b21372cbbc5344ff780e2dd61280a240790fd2564aa02c8baa5::fwal {
    struct FWAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: FWAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FWAL>(arg0, 6, b"FWAL", b"Walrus Fart Dust", b"Unicorns aren't only ones with magic fart!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000012212_4c8caf68b7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FWAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FWAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

