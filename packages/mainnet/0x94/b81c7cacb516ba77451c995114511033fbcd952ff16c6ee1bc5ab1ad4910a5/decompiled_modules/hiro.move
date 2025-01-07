module 0x94b81c7cacb516ba77451c995114511033fbcd952ff16c6ee1bc5ab1ad4910a5::hiro {
    struct HIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIRO>(arg0, 6, b"HIRO", b"Hiro", b"https://x.com/HirosAdventure", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000170819_2546605598.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

