module 0xa0185fc48931f70cb5e2ac4aa25583e7e83f732f3286977e2426d323dbde529c::hip2_0 {
    struct HIP2_0 has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIP2_0, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIP2_0>(arg0, 9, b"HIP2_0", b"Hippo 2.0", b"A meme token after the main Hippo ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f7d05008-4b89-4188-a846-355dd3b73c55.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIP2_0>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HIP2_0>>(v1);
    }

    // decompiled from Move bytecode v6
}

