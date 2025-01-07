module 0xe78184468dbd3e8e65a2fa510368bc4357b18b5ec60f618d00d732bc605f7caa::heart {
    struct HEART has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEART>(arg0, 6, b"Heart", b"SUIheart", b"Heart for the SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Heart_f062475f06.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEART>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HEART>>(v1);
    }

    // decompiled from Move bytecode v6
}

