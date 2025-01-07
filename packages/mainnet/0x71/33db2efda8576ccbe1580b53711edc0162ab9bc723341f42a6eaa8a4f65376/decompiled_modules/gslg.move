module 0x7133db2efda8576ccbe1580b53711edc0162ab9bc723341f42a6eaa8a4f65376::gslg {
    struct GSLG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GSLG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GSLG>(arg0, 6, b"GSLG", b"GOLDEN SLUG", b"Slow, shiny, and dripping in gold. The slug that wins the race of gains", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_19_031239482_2a4bc31c42.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GSLG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GSLG>>(v1);
    }

    // decompiled from Move bytecode v6
}

