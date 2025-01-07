module 0xc336f1681c41a78532b22be611aab399408b024879a53433fac21595bc8f9bbd::mare {
    struct MARE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARE>(arg0, 6, b"MARE", b"Mare", b"The Official Mascot of Sui. \"Mare\" means \"Sea\" in Italian. She is the protector of the Blue World and the Spiritual Guide of its inhabitants.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/AQUA_e1757928a7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARE>>(v1);
    }

    // decompiled from Move bytecode v6
}

