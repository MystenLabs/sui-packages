module 0xe7509c727189330146d2e8115513647d13ac62c03f8198d4df2ac31d7034e035::codfather {
    struct CODFATHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: CODFATHER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CODFATHER>(arg0, 6, b"CODFATHER", b"The Cod Father", b"'Make them a memecoin they can't refuse'", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_512_x_512_px_22_125e3c9c0b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CODFATHER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CODFATHER>>(v1);
    }

    // decompiled from Move bytecode v6
}

