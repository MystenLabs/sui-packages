module 0x821993334e7100aa4985b1244b02fbc978799a5b3c4ab89c00a00886e2d8ee1d::ketchup {
    struct KETCHUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: KETCHUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KETCHUP>(arg0, 6, b"Ketchup", b"Ketchup Chip", b"The showstopper of snack - a diva in edible form - cast your gaze upon this  bold red beacon of culinary Einsteinery", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734501396727.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KETCHUP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KETCHUP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

