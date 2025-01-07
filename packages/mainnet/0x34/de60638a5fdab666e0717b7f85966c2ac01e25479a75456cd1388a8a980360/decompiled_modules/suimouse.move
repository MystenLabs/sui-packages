module 0x34de60638a5fdab666e0717b7f85966c2ac01e25479a75456cd1388a8a980360::suimouse {
    struct SUIMOUSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMOUSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMOUSE>(arg0, 9, b"SUIMOUSE", b"MOUSE", b"MOUSE Coin is a Meme coin, MOUSE released First on SUI blockchain with inspiration and main image from the MOUSE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/36d9e871-f9c8-4385-9c65-97947e03e9e6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMOUSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIMOUSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

