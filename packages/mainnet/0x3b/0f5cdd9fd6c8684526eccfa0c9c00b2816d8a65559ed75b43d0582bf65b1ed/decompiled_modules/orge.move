module 0x3b0f5cdd9fd6c8684526eccfa0c9c00b2816d8a65559ed75b43d0582bf65b1ed::orge {
    struct ORGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORGE>(arg0, 6, b"ORGE", b"ORGE Coin", x"49276d204f726765202c2049206c6f7665207375690a4669727374204f72616e676520436174206f6e205375692052656c61756e6368", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5257302543_8f882a9ed6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ORGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

