module 0x5e7a2bfe6055f502889528b591a9e204b1361df9102cb9b0bba6df118f2ca399::disney {
    struct DISNEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DISNEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DISNEY>(arg0, 9, b"DISNEY", x"e2ad90efb88f4469736e6579", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DISNEY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DISNEY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DISNEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

