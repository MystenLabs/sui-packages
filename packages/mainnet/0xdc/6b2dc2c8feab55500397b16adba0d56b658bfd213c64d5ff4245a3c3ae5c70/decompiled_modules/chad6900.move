module 0xdc6b2dc2c8feab55500397b16adba0d56b658bfd213c64d5ff4245a3c3ae5c70::chad6900 {
    struct CHAD6900 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHAD6900, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHAD6900>(arg0, 6, b"CHAD6900", b"CHAD SUI", b"Introducing CHAD6900, a groundbreaking new asset that is set to redefine how we think about trading and market dynamics. Inspired by the ebbs and flows of the traditional stock market, CHAD6900 offers a unique and innovative opportunity for investors looking to capitalize on the evolving landscape of finance and DeFI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CHAD_c549ce7292.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHAD6900>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHAD6900>>(v1);
    }

    // decompiled from Move bytecode v6
}

