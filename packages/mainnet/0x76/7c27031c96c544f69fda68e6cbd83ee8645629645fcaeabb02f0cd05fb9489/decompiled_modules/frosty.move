module 0x767c27031c96c544f69fda68e6cbd83ee8645629645fcaeabb02f0cd05fb9489::frosty {
    struct FROSTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROSTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROSTY>(arg0, 6, b"FROSTY", b"Sui Frosty", b"The yeti with the bling ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000052521_37cad26931.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROSTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROSTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

