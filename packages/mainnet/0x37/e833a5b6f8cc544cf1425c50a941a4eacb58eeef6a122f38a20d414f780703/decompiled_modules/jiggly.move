module 0x37e833a5b6f8cc544cf1425c50a941a4eacb58eeef6a122f38a20d414f780703::jiggly {
    struct JIGGLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JIGGLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JIGGLY>(arg0, 6, b"JIGGLY", b"JIGGLYMOON", x"54686520426f756e636520746f20746865204d6f6f6e20426567696e73210a0a506c617966756c2e2050756666792e20426f726e20746f206a6967676c65207468726f75676820746865206368616f73", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigmgb5mfdbj2pceirsc2dwhprxwhdrpx4ob5tcut4yg54grtht7hy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JIGGLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JIGGLY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

