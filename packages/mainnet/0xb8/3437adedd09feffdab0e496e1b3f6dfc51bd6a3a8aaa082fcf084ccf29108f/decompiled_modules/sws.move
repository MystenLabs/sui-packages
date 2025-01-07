module 0xb83437adedd09feffdab0e496e1b3f6dfc51bd6a3a8aaa082fcf084ccf29108f::sws {
    struct SWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWS>(arg0, 6, b"SWS", b"Sui wall street", b"Wall street wolfs live ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000029117_38574598af.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWS>>(v1);
    }

    // decompiled from Move bytecode v6
}

