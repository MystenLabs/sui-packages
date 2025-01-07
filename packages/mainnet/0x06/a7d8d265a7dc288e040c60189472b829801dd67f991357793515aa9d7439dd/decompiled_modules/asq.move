module 0x6a7d8d265a7dc288e040c60189472b829801dd67f991357793515aa9d7439dd::asq {
    struct ASQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASQ>(arg0, 6, b"ASQ", b"Astronaut Squirrel", b"Astronaut squirrel meme coin standing proudly in the airlock, wearing a stylish spacesuit and his utility belt, with a helmet visor reflecting the curvature of the Earth, surrounded by a halo of stars and planets, he is ready to mine crypto on new pl", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732105120413.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASQ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASQ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

