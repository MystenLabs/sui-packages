module 0x221db80d90b9374559a6c3826c17d30e77723738f0b245a74ecbf569b25eb5a2::view {
    struct VIEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: VIEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VIEW>(arg0, 9, b"VIEW", b"ultra", b"VIRWE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9873f384-ce64-4e52-8fdf-ce6f1da1f7b4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VIEW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VIEW>>(v1);
    }

    // decompiled from Move bytecode v6
}

