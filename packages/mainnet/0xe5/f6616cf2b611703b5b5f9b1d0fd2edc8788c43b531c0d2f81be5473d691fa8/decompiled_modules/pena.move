module 0xe5f6616cf2b611703b5b5f9b1d0fd2edc8788c43b531c0d2f81be5473d691fa8::pena {
    struct PENA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENA>(arg0, 6, b"PENA", b"PITZOS", x"66656c697a206a75657665732070656e613b20656c206d656e7520646520686f7920736f6e3a2062657369746f73202e53454e542049540a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Zg3bi2_WUAQK_Pnd_bf8efa766e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PENA>>(v1);
    }

    // decompiled from Move bytecode v6
}

