module 0x8d90e4d3ab8c59f326ca9f9b9f147f8aeb65bf432126b6e35579dfad5889b88d::degtyhu {
    struct DEGTYHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEGTYHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEGTYHU>(arg0, 9, b"DEGTYHU", b"ghghkjtgh", b"bnhdgjy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bf8e97da-6e92-4335-ad09-db6cb8d65c41.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEGTYHU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEGTYHU>>(v1);
    }

    // decompiled from Move bytecode v6
}

