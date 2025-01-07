module 0xcce1cfcd48c4836a999cba6e7e06aeebf246c357affcd22e44992bab2d09ec6c::pewzy {
    struct PEWZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEWZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEWZY>(arg0, 6, b"PEWZY", b"Just Pewzy", b"PEWZY - where only the sharpest shooters thrive. A haven for the quick, the bold, and the degens aiming for moonshots this new year", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_88ecbbdda2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEWZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEWZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

