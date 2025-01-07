module 0x3545b4f6517fe1ae33cc74f2e32404791c18f10992c977aff56325ffa7d87dd2::wayg {
    struct WAYG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAYG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAYG>(arg0, 6, b"WAYG", b"Why are you Gay?", b"Please tell me why are you GAY?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7062_850ee40b71.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAYG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAYG>>(v1);
    }

    // decompiled from Move bytecode v6
}

