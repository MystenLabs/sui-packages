module 0xbe147b85aadb8f4bc8da9d481078f7d19ab5397cfca84e3d76924ef33a598543::memememememememe {
    struct MEMEMEMEMEMEMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEMEMEMEMEMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEMEMEMEMEMEME>(arg0, 6, b"MEMEMEMEMEMEMEME", b"MEMEME", b"MEME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pub-efea87dea3f94e8084e073588c980c50.r2.dev/logo/01JB6GV0A2AGAFB6JPVDCVHSKD/01JBB44PAPHMXFNTE0JBGRQKCJ")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEMEMEMEMEMEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MEMEMEMEMEMEMEME>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

