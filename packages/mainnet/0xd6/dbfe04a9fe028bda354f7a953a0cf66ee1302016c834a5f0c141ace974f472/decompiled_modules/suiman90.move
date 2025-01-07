module 0xd6dbfe04a9fe028bda354f7a953a0cf66ee1302016c834a5f0c141ace974f472::suiman90 {
    struct SUIMAN90 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMAN90, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMAN90>(arg0, 9, b"SUIMAN90", b"Suiman", b"The Hero of SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2a1f8bd5-bbc0-4921-9fbb-d32e9020185c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMAN90>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIMAN90>>(v1);
    }

    // decompiled from Move bytecode v6
}

