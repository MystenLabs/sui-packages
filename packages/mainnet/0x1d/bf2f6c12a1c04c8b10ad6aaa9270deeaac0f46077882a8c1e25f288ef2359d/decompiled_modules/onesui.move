module 0x1dbf2f6c12a1c04c8b10ad6aaa9270deeaac0f46077882a8c1e25f288ef2359d::onesui {
    struct ONESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONESUI>(arg0, 6, b"ONESUI", b"SUI ONE", x"4669727374206d656d65206f6e6520737569206f6e207375692e0a546f6b656e2057696c6c206275726e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000005244_f4754dff86.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ONESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

