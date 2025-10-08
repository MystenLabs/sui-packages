module 0xd971feca54d340efdaec6426bee6fd0c21f535a685f8e50cc2cd390a76dba139::crydr1663 {
    struct CRYDR1663 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRYDR1663, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRYDR1663>(arg0, 12, b"CRYDR1663", b"Crystal Dragon #1663", b"Transparent, powerful, and legendary", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://example.com/crystal-dragon.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRYDR1663>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRYDR1663>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

