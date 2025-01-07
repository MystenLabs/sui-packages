module 0xe5db6e932c5d653a16d1ba5fedd472e472dff3497f8dba2035ad90e3b2c2ce87::fooly {
    struct FOOLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOOLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOOLY>(arg0, 9, b"FOOLY", b"Fool", b"Fooly meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2ea8f92d-efde-4f41-91f4-a2d00a13c327-IMG_1142.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOOLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FOOLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

