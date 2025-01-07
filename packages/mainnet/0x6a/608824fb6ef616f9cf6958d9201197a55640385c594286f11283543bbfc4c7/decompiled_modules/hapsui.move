module 0x6a608824fb6ef616f9cf6958d9201197a55640385c594286f11283543bbfc4c7::hapsui {
    struct HAPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAPSUI>(arg0, 6, b"HAPSUI", b"HAPSUI HALLOWEEN", b"Happy Sui Halloween", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8678_f13131540a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAPSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAPSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

