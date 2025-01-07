module 0x1cb9d20da4db654ab47dd790ee4b9735a431ae80df6d61b2c0dfeab71a131b8e::fooly {
    struct FOOLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOOLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOOLY>(arg0, 9, b"FOOLY", b"Fool", b"Fooly meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ee543379-b2c6-422d-9af5-a5d074e5cf31-IMG_1142.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOOLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FOOLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

