module 0x6ed6ed4db13d925875c5b9a6737960911ac4d1666f8f2690fb99405312d1a934::bol {
    struct BOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOL>(arg0, 6, b"BOL", b"Bolana", b"is boowl", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731434457838.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

