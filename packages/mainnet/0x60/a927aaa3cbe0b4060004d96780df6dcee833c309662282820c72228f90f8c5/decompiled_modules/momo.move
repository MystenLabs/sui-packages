module 0x60a927aaa3cbe0b4060004d96780df6dcee833c309662282820c72228f90f8c5::momo {
    struct MOMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOMO>(arg0, 9, b"MOMO", b"MOMO", b"https://www.twitch.tv/momoladinastia?lang=es", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://steamuserimages-a.akamaihd.net/ugc/2053113256304375594/401C5B9AB9669F8B00CA93CD44EEB2E96C3C89E1/?imw=512&&ima=fit&impolicy=Letterbox&imcolor=%23000000&letterbox=false")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MOMO>(&mut v2, 3999999999000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOMO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

