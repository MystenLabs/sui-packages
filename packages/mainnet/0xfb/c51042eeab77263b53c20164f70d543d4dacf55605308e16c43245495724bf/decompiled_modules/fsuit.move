module 0xfbc51042eeab77263b53c20164f70d543d4dacf55605308e16c43245495724bf::fsuit {
    struct FSUIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FSUIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FSUIT>(arg0, 6, b"FSUIT", b"Fausuit", b"Ive just turned on the Fausuit! Splash it. Flood it. Send it to the DEX!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0964_b6119f149f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FSUIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FSUIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

