module 0x5faf55d6c88128f3d78436f6f774fa36fdd41ec1ff9f7a0ac34525b9841a19d7::sofas {
    struct SOFAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOFAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOFAS>(arg0, 9, b"SOFAS", b"SOFA ", b"SOFAS IN MORNING AND ITS BOOOOOOM IN MARKET ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a9b6e67c-82b2-4a33-ae84-5c8abe0ebe1c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOFAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOFAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

