module 0x5f43f1cb73a5c3ec230c8347116ba806e5a5130829aa18c5d15873b0d3c3fe75::gig {
    struct GIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIG>(arg0, 9, b"GIG", b"Nag ", b"Funny ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d2c3435a-9882-4668-bf94-57bd34522e39.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

