module 0x177ee18e81c6eb5446f17937c4af8cf4cedae48606dfeead83c06500a85a1b71::ykt {
    struct YKT has drop {
        dummy_field: bool,
    }

    fun init(arg0: YKT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YKT>(arg0, 6, b"YKT", b"Yukata", b"A vibrant meme coin inspired by the charm and elegance of a cute girl in a traditional Yukata! Combining the beauty of Japanese culture with the playful spirit of the crypto world, Yukata brings a fresh and delight twist to the SUI ecosystem!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732381243181.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YKT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YKT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

