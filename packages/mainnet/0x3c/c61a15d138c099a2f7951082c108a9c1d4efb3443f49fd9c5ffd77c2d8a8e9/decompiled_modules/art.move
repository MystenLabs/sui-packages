module 0x3cc61a15d138c099a2f7951082c108a9c1d4efb3443f49fd9c5ffd77c2d8a8e9::art {
    struct ART has drop {
        dummy_field: bool,
    }

    fun init(arg0: ART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ART>(arg0, 9, b"ART", b"art", x"63656c6562726174696e6720696e6e6f766174696f6e20f09f8ea8", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9afb6881-75b7-43ea-998c-63888f0e769a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ART>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ART>>(v1);
    }

    // decompiled from Move bytecode v6
}

