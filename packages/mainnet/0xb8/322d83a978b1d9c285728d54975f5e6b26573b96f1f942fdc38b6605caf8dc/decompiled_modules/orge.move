module 0xb8322d83a978b1d9c285728d54975f5e6b26573b96f1f942fdc38b6605caf8dc::orge {
    struct ORGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORGE>(arg0, 6, b"ORGE", b"ORGE CAT", x"49276d204f5247452c204669727374204f72616e676520436174206f6e205375692e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5257302543_ad17f33d34.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ORGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

