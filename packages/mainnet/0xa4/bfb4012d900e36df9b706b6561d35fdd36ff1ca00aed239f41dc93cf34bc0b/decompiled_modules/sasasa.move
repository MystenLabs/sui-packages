module 0xa4bfb4012d900e36df9b706b6561d35fdd36ff1ca00aed239f41dc93cf34bc0b::sasasa {
    struct SASASA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SASASA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SASASA>(arg0, 6, b"SASASA", b"asd", b"asfsfasa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigkjdy3fddrwappdoonihlmv4tsqeyhzabrimwdaihtrmnli3mi2i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SASASA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SASASA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

