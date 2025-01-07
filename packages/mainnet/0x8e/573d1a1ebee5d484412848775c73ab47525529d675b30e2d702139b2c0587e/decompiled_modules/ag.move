module 0x8e573d1a1ebee5d484412848775c73ab47525529d675b30e2d702139b2c0587e::ag {
    struct AG has drop {
        dummy_field: bool,
    }

    fun init(arg0: AG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AG>(arg0, 9, b"AG", b"Alpha Genesis", b"Koin meme jadi jangan berharap apapun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.app.goo.gl/fiZxhaDbRVnQnSYv8")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AG>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AG>>(v1);
    }

    // decompiled from Move bytecode v6
}

