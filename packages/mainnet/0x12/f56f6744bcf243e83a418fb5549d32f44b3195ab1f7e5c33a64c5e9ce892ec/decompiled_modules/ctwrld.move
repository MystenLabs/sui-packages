module 0x12f56f6744bcf243e83a418fb5549d32f44b3195ab1f7e5c33a64c5e9ce892ec::ctwrld {
    struct CTWRLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTWRLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTWRLD>(arg0, 6, b"CTWRLD", b"CatWorld CTWRLD", b"rewards are auto-claimed & airdropped to the CURRENT Top 20 holders after 1 hour", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_sui_b7aabe00c1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTWRLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CTWRLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

