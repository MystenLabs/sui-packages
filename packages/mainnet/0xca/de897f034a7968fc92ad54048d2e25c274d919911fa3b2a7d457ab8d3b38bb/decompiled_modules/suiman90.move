module 0xcade897f034a7968fc92ad54048d2e25c274d919911fa3b2a7d457ab8d3b38bb::suiman90 {
    struct SUIMAN90 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMAN90, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMAN90>(arg0, 9, b"SUIMAN90", b"Suiman", b"The Hero of SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d84bb0f5-0132-4f01-b3e5-9e2900c99575.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMAN90>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIMAN90>>(v1);
    }

    // decompiled from Move bytecode v6
}

