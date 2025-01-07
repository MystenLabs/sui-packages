module 0x2139d6fc23c3ade500bd89155369d2d1e89dfd72b9b9485f2842ae0bccf7225b::goat {
    struct GOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOAT>(arg0, 9, b"GOAT", b"GT", b"A cartoon logo features a cheerful goat with exaggerated features, leaning on a gold coin with 'MemeNation', and an abstract motif highlighting cryptocurrency themes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dbbd7f86-927f-42b4-aff1-c196e93abc97.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

