module 0x97c0ac60e36bf2415d82094f17adcd64673d529fdc067bef69a987513f32d8ac::tbear {
    struct TBEAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TBEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TBEAR>(arg0, 6, b"TBEAR", b"Tranquilized Bear", b"Just a Tranquilized Bear vibes on SUI NETWORK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4162_294a3afcaa.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TBEAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TBEAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

