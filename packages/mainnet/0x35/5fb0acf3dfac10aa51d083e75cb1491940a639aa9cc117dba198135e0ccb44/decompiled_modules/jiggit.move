module 0x355fb0acf3dfac10aa51d083e75cb1491940a639aa9cc117dba198135e0ccb44::jiggit {
    struct JIGGIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: JIGGIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JIGGIT>(arg0, 9, b"JIGGIT", b"Jiggit token", b"Central asian token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://res.cloudinary.com/dqlywbmwc/image/upload/v1746051355/okuknn1lqpdzhalsuqcd.png")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<JIGGIT>(&mut v2, 10000000000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JIGGIT>>(v1, v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JIGGIT>>(v2, v3);
    }

    // decompiled from Move bytecode v6
}

