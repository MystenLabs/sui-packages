module 0x932a81bfaaed2d6eaa493c7c732861ac703e774b5ea818a78eeb998f4b44efc5::retardion {
    struct RETARDION has drop {
        dummy_field: bool,
    }

    fun init(arg0: RETARDION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RETARDION>(arg0, 6, b"RETARDIon", b"RETARDIO MODE ON", b"new world order retardio only avaible", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GXIQI_0_JWYA_Et_Kg4_3c7d461f48.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RETARDION>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RETARDION>>(v1);
    }

    // decompiled from Move bytecode v6
}

