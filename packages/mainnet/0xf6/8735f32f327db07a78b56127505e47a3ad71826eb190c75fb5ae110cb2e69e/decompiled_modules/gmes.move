module 0xf68735f32f327db07a78b56127505e47a3ad71826eb190c75fb5ae110cb2e69e::gmes {
    struct GMES has drop {
        dummy_field: bool,
    }

    fun init(arg0: GMES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GMES>(arg0, 6, b"GMES", b"GameStop on sui", b"Join the revolution!!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5736_4c8539c52e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GMES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GMES>>(v1);
    }

    // decompiled from Move bytecode v6
}

