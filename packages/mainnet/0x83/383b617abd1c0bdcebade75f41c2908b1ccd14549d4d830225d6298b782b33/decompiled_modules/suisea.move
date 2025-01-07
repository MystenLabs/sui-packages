module 0x83383b617abd1c0bdcebade75f41c2908b1ccd14549d4d830225d6298b782b33::suisea {
    struct SUISEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISEA>(arg0, 6, b"Suisea", b"SUISEA", b"sui sea in s fjsdj fkdsf sd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Designer_3_d01908818d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISEA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISEA>>(v1);
    }

    // decompiled from Move bytecode v6
}

