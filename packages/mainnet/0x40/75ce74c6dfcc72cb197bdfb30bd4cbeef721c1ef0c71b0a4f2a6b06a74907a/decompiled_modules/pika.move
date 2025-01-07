module 0x4075ce74c6dfcc72cb197bdfb30bd4cbeef721c1ef0c71b0a4f2a6b06a74907a::pika {
    struct PIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIKA>(arg0, 6, b"PIKA", b"PikaRug", b"Pika Rug", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PIKA>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIKA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

