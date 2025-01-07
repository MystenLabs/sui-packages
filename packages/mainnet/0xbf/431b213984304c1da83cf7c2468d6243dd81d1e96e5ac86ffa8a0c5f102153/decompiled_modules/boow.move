module 0xbf431b213984304c1da83cf7c2468d6243dd81d1e96e5ac86ffa8a0c5f102153::boow {
    struct BOOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOW>(arg0, 6, b"BOOW", b"Book Of Wojak", x"446973636f7665722054686520576f726c64204f6620576f6a616b2c204f6e65204d656d6520417420412054696d652e204a6f696e205573204f6e205468652053746f7279204f662054686520486f6c7920426f6f6b204f6620576f6a616b2026204265636f6d652041205472756520576f6a616b20576974682024424f4f570a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_R_Up_SAG_Dr_T_Bhii_Azvy4_DUZ_6rz6_NL_9xp_C8yho_C9_FAY_Kp_ND_a291dc9f43.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

