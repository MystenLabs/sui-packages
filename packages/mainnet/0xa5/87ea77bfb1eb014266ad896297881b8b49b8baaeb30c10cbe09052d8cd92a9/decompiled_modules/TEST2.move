module 0xa587ea77bfb1eb014266ad896297881b8b49b8baaeb30c10cbe09052d8cd92a9::TEST2 {
    struct TEST2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST2>(arg0, 6, b"TEST2", b"TEST2", b"Find Our Community On Discord", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/ISF8TOC.jpeg"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TEST2>(&mut v2, 100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST2>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEST2>>(v1);
    }

    // decompiled from Move bytecode v6
}

