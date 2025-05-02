module 0xb992ae6aa47169aa14ecd7d01e10311a93f57d5cf71dd248ef3119b4d5743808::balor {
    struct BALOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALOR>(arg0, 9, b"balor", b"balor", b"just a test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BALOR>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALOR>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BALOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

