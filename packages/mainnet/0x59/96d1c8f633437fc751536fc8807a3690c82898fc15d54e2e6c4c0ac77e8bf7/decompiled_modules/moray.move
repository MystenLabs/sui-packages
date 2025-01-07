module 0x5996d1c8f633437fc751536fc8807a3690c82898fc15d54e2e6c4c0ac77e8bf7::moray {
    struct MORAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MORAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MORAY>(arg0, 6, b"MORAY", b"Sui Moray", b"MORAY is a sea snake belonging to the sui ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/moray_b135a083f1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MORAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MORAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

