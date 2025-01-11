module 0x8262992fc5e8750a98fb97fea0e90a4a419aebb4320e3ebd3304bbc0e150a3ca::cinajiro {
    struct CINAJIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CINAJIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CINAJIRO>(arg0, 6, b"CINAJIRO", b"cinacina by SuiAI", b"yoroshiku", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_0559_6e509e1d77.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CINAJIRO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CINAJIRO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

