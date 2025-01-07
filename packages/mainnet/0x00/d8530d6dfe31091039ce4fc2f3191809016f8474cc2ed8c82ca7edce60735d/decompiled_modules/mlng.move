module 0xd8530d6dfe31091039ce4fc2f3191809016f8474cc2ed8c82ca7edce60735d::mlng {
    struct MLNG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MLNG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MLNG>(arg0, 9, b"MLNG", b"MLNGcoin", b"mlng is the best", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/db6118bb-24fa-4ed1-9bc0-e6c9448bd795.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MLNG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MLNG>>(v1);
    }

    // decompiled from Move bytecode v6
}

