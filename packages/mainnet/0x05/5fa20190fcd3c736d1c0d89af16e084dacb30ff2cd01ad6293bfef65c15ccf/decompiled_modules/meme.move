module 0x55fa20190fcd3c736d1c0d89af16e084dacb30ff2cd01ad6293bfef65c15ccf::meme {
    struct MEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEME>(arg0, 6, b"Meme", b"Memez.gg", b"something is cooking ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/n8_KMWY_6_400x400_8b5cc1cf5e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

