module 0x8bad41a7efcc1294a99706e9639ae888dea01789c8ae70dd67e58f38594c0dfb::suigpt {
    struct SUIGPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGPT>(arg0, 6, b"SUIGPT", b"suigpt4", b"Suigpt", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_26_21_04_04_7058c027b4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGPT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGPT>>(v1);
    }

    // decompiled from Move bytecode v6
}

