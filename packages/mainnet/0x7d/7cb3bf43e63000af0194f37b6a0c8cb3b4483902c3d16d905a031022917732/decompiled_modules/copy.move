module 0x7d7cb3bf43e63000af0194f37b6a0c8cb3b4483902c3d16d905a031022917732::copy {
    struct COPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: COPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COPY>(arg0, 9, b"COPY", b"Copy Past", b"Copy Past Copy Past Copy Past", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2d3355b9-3dff-40de-9bb4-48e235d49d5b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

