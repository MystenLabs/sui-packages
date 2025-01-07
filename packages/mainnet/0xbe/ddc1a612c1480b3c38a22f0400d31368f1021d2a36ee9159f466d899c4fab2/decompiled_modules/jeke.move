module 0xbeddc1a612c1480b3c38a22f0400d31368f1021d2a36ee9159f466d899c4fab2::jeke {
    struct JEKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JEKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JEKE>(arg0, 6, b"JEKE", b"Jeke Paal", b"Tiem to go asleep old bleck maan, your tiem is up", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0097_aa563ebd5f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JEKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JEKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

