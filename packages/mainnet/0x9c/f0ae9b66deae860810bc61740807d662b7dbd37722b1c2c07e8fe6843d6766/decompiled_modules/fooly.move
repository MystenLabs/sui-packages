module 0x9cf0ae9b66deae860810bc61740807d662b7dbd37722b1c2c07e8fe6843d6766::fooly {
    struct FOOLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOOLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOOLY>(arg0, 9, b"FOOLY", b"Fool", b"Fooly meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c5af962c-552b-49bf-966a-f99cf968294c-IMG_1142.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOOLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FOOLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

