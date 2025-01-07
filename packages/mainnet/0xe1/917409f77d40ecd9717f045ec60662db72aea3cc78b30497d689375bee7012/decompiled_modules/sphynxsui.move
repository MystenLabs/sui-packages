module 0xe1917409f77d40ecd9717f045ec60662db72aea3cc78b30497d689375bee7012::sphynxsui {
    struct SPHYNXSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPHYNXSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPHYNXSUI>(arg0, 6, b"sphynxSui", b"sphynx.meme", b"sphynxcoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_06_02_23_51_53_db80e62f50.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPHYNXSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPHYNXSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

