module 0x77d074e2a0d1e4e4deab95a649cede24a127ee709aa4d9683643c3103490d1::suinavy {
    struct SUINAVY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINAVY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINAVY>(arg0, 6, b"SUINAVY", b"SuiNavy", b"The first navy on sui chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000991_acec3f4b0a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINAVY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINAVY>>(v1);
    }

    // decompiled from Move bytecode v6
}

