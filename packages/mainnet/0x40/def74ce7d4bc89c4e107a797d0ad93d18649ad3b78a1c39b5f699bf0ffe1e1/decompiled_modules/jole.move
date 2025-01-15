module 0x40def74ce7d4bc89c4e107a797d0ad93d18649ad3b78a1c39b5f699bf0ffe1e1::jole {
    struct JOLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOLE>(arg0, 6, b"JOLE", b"JOLE me", b"he", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/HJ_e88877be7c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

