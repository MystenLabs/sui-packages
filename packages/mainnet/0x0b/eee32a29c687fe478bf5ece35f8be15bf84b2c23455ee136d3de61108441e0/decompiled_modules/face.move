module 0xbeee32a29c687fe478bf5ece35f8be15bf84b2c23455ee136d3de61108441e0::face {
    struct FACE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FACE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FACE>(arg0, 6, b"FACE", b"wtf", b"sdasd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_27_09_35_29_19c6591eaf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FACE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FACE>>(v1);
    }

    // decompiled from Move bytecode v6
}

