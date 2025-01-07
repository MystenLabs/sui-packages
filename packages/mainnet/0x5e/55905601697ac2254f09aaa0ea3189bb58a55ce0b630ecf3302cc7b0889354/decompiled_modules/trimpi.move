module 0x5e55905601697ac2254f09aaa0ea3189bb58a55ce0b630ecf3302cc7b0889354::trimpi {
    struct TRIMPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRIMPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRIMPI>(arg0, 9, b"TRIMPI", b"Trump", b"President of America", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/04613cb3-baa3-48be-883a-68e1528e6fa1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRIMPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRIMPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

