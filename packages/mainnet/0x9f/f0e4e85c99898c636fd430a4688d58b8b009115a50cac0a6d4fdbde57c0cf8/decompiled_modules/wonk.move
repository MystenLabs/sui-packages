module 0x9ff0e4e85c99898c636fd430a4688d58b8b009115a50cac0a6d4fdbde57c0cf8::wonk {
    struct WONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: WONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WONK>(arg0, 6, b"WONK", b"Blue Wonk", b"WONK  - Maybe cat, Maybe frog, Maybe trend", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logoround_779dea292b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WONK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

