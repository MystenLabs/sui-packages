module 0xf1171a911c98dc86282f7b80be3612ae1848dc2e26b7835b8e0a98e243805b17::turt {
    struct TURT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURT>(arg0, 6, b"TURT", b"Sui Turt", b"Turt is a cute and curious creature who loves moving around and exploring new places. Always ready for an adventure", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_22_04_05_02_2cd8003d2d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TURT>>(v1);
    }

    // decompiled from Move bytecode v6
}

