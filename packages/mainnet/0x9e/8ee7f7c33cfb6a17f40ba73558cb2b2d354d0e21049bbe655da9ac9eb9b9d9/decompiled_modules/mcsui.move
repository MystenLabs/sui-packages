module 0x9e8ee7f7c33cfb6a17f40ba73558cb2b2d354d0e21049bbe655da9ac9eb9b9d9::mcsui {
    struct MCSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCSUI>(arg0, 6, b"MCSUI", b"Mc Sui", x"492077696c6c2068656c7020796f752072657469726520616e6420616368696576652066696e616e6369616c2066726565646f6d0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_10_15_02_16_42_bbf39bd0ab_c4b9c6016d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MCSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

