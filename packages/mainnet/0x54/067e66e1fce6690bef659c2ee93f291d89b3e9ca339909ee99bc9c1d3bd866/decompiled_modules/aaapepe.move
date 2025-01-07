module 0x54067e66e1fce6690bef659c2ee93f291d89b3e9ca339909ee99bc9c1d3bd866::aaapepe {
    struct AAAPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAPEPE>(arg0, 6, b"AAAPEPE", b"aaa pepe", b"the top pepe on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CZCXZ_bd4a8e627c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

