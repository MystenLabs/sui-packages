module 0xe1ced8e5ebfe31ca2d8e845f5499c5a80c2822044b550b54ea365f0958788fc1::chillsnt {
    struct CHILLSNT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLSNT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLSNT>(arg0, 6, b"CHILLSNT", b"Chill Santa", b"Chill Santa is here to bring some chilly vibe.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734273400034.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHILLSNT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLSNT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

