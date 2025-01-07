module 0x1ff0207f9c54b6fed849401174b2e2a4b4bdaeac72c304ba4696e0d1dbe4542d::frenk {
    struct FRENK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRENK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRENK>(arg0, 6, b"FRENK", b"Frenk", b"Frenk frenk frenk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250105_WA_0027_1603ec80d2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRENK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRENK>>(v1);
    }

    // decompiled from Move bytecode v6
}

