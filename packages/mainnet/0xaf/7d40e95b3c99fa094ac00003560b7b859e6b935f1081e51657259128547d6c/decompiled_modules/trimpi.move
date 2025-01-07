module 0xaf7d40e95b3c99fa094ac00003560b7b859e6b935f1081e51657259128547d6c::trimpi {
    struct TRIMPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRIMPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRIMPI>(arg0, 9, b"TRIMPI", b"Trump", b"President of America", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c787414f-d400-47e4-858e-c5ea25a31507.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRIMPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRIMPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

