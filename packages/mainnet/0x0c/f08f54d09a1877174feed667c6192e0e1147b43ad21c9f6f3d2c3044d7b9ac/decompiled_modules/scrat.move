module 0xcf08f54d09a1877174feed667c6192e0e1147b43ad21c9f6f3d2c3044d7b9ac::scrat {
    struct SCRAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCRAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCRAT>(arg0, 6, b"SCRAT", b"Scrat", b"the move, always reaching for something just out of grasp, but never giving up. If crypto feels like a wild ride, Scrats the perfect mascot to remind you to embrace the chaos and laugh along ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000050805_ac7a35cad1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCRAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCRAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

