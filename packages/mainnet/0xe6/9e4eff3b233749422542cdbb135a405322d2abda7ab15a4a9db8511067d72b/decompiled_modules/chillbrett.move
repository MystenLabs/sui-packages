module 0xe69e4eff3b233749422542cdbb135a405322d2abda7ab15a4a9db8511067d72b::chillbrett {
    struct CHILLBRETT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLBRETT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLBRETT>(arg0, 6, b"CHILLBRETT", b"Just a chill Brett", b"Just a chill brett", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6331_76a5f250e4.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLBRETT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILLBRETT>>(v1);
    }

    // decompiled from Move bytecode v6
}

