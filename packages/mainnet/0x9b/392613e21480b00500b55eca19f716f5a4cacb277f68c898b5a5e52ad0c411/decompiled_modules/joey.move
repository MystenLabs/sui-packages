module 0x9b392613e21480b00500b55eca19f716f5a4cacb277f68c898b5a5e52ad0c411::joey {
    struct JOEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOEY>(arg0, 9, b"JOEY", b"JOEY", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://h4swpwiztxadr5wd.public.blob.vercel-storage.com/create-logos/416127b55ce440a19852a222da758f58dc0a12749a7148856abbcebe6ddde562.webp")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<JOEY>>(0x2::coin::mint<JOEY>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JOEY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOEY>>(v2, 0x2::address::from_u256(0));
    }

    // decompiled from Move bytecode v7
}

