module 0xe767e3cf924c36c0c9208e88050133936b95a09168bab31f2a2ed0af082ebb4d::addf {
    struct ADDF has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADDF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADDF>(arg0, 9, b"ADDF", b"Cat200", x"f09fa491f09fa491", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c4ea202e-2b4b-4e1f-964a-545cd68e3eab.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADDF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ADDF>>(v1);
    }

    // decompiled from Move bytecode v6
}

