module 0x3ff9020d0428c62f42a46b81fa40a1db2e746ac2bc3772b0b4de00aa2787c5bd::sam {
    struct SAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAM>(arg0, 6, b"Sam", b"Sam Nakamoto", b"Crypto Samurai", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3521_5cdd93cf91.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

