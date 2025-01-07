module 0xbfb2ec1303a18a7263aaa73671c3bc1ae0d96b51bf73a57e039b005b55fca565::rain {
    struct RAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAIN>(arg0, 6, b"RAIN", b"Raindrop", x"5241494e44524f502c206c696665e2809973206d6f737420657373656e7469616c207265736f75726365", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731002511748.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RAIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

