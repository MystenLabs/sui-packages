module 0x73cdef3e5c502fc12834dcbf41cf9e60c8f840848e50abb8b53dd6207dfdd48d::jooce {
    struct JOOCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOOCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOOCE>(arg0, 6, b"JOOCE", b"Jooce coin", b"Memecoin index with jooced up yields. Its bulking season and your favourite memes are competing for weight! Memes on $JOOCE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048519_114be96ff5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOOCE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOOCE>>(v1);
    }

    // decompiled from Move bytecode v6
}

