module 0x1148744c05eb3bf24c1ea6321283721363621ed1047d4568eb57bde3b38984ba::sssss {
    struct SSSSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSSSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSSSS>(arg0, 6, b"SSSSS", b"Sui Snake Hat", b"Its time we make snakes cute again. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000013017_2a0a0d2ee1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSSSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSSSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

