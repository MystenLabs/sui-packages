module 0xc41081e94d25e0eef1261e352da88c4bcd4f97fc1cbc074ef948b38136c8c2b7::melania {
    struct MELANIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MELANIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MELANIA>(arg0, 6, b"MELANIA", b"MELANIA OFFICAL", b"Melania memes are digital collectibles intended to function as an expression of support for and engagement with the values embodied by the symbol MELANIA. and the associated artwork, and are not intended to be, or to be the subject of, an investment opportunity, investment contract, or security of", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/S_db2eef358c_380db8a440.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MELANIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MELANIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

