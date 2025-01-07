module 0x5e9cd3ce5b9c0b9897a960f12df46942bf4a3fa0e626f88078069c5d41cbbbb0::fooly {
    struct FOOLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOOLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOOLY>(arg0, 9, b"FOOLY", b"Fool", b"Fooly meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7c02023e-eec2-4798-b044-bd9565992d84-IMG_1142.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOOLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FOOLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

