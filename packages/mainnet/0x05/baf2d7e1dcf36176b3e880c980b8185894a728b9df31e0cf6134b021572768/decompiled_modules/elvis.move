module 0x5baf2d7e1dcf36176b3e880c980b8185894a728b9df31e0cf6134b021572768::elvis {
    struct ELVIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELVIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELVIS>(arg0, 6, b"Elvis", b"ELV Protocol", b"OFFICIAL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fdc9f518_3fb8_417a_bb54_9f11cb20f779_8c91a276cf.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELVIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELVIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

