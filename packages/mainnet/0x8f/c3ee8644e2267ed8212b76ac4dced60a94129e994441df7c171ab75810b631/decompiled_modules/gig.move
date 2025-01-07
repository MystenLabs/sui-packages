module 0x8fc3ee8644e2267ed8212b76ac4dced60a94129e994441df7c171ab75810b631::gig {
    struct GIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIG>(arg0, 9, b"GIG", b"GIGGLECOIN", b"GIGGLECOIN (GIG) is a playful, community-driven cryptocurrency symbolized by a smiling cartoon coin, representing the power of laughter and joy in the digital economy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f99f6b81-cb6b-4bb0-955b-291a8527249c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

