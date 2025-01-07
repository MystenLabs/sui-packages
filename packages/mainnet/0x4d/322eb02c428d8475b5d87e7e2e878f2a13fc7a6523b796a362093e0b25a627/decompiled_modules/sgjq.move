module 0x4d322eb02c428d8475b5d87e7e2e878f2a13fc7a6523b796a362093e0b25a627::sgjq {
    struct SGJQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGJQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGJQ>(arg0, 9, b"SGJQ", b"jejd", b"hdbd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/64ae58c0-3bec-490d-a71d-bb0ced5935fd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGJQ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SGJQ>>(v1);
    }

    // decompiled from Move bytecode v6
}

