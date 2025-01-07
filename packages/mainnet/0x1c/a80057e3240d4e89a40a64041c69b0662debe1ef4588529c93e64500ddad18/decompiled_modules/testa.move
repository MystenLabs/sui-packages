module 0x1ca80057e3240d4e89a40a64041c69b0662debe1ef4588529c93e64500ddad18::testa {
    struct TESTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTA>(arg0, 6, b"TESTA", b"tesersf", b"asdfasdf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Bildschirmfoto_2024_10_07_um_10_30_55_d001de1850.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

