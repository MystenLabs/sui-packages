module 0xc73aeb6d0c3082e13ad672ff6b43221b620a12d7a35dbb0fc56be190fac86b07::gooye {
    struct GOOYE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOOYE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOOYE>(arg0, 6, b"Gooye", b"Gooye on Sui", b"Gooye on Sui..!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241226_212834_101_c16f87f8fd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOOYE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOOYE>>(v1);
    }

    // decompiled from Move bytecode v6
}

