module 0x5efcc1f130ff4893e4e9779b1ad9b920687ea751ab982126b5f4c1e32cba1728::groke {
    struct GROKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GROKE>(arg0, 6, b"GROKE", b"THE GROKE", b"Groke is a longly penguin.    $GROKE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/groke_logo_ab7867d262.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GROKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GROKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

