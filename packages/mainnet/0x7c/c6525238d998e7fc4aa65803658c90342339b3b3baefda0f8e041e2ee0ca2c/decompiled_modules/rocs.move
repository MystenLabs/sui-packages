module 0x7cc6525238d998e7fc4aa65803658c90342339b3b3baefda0f8e041e2ee0ca2c::rocs {
    struct ROCS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROCS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROCS>(arg0, 6, b"ROCS", b"Rocket Shark", b"The most loving shark", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8456_393898697c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROCS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROCS>>(v1);
    }

    // decompiled from Move bytecode v6
}

