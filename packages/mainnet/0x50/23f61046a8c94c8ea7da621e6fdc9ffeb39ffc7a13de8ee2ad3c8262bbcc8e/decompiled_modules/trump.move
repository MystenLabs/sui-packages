module 0x5023f61046a8c94c8ea7da621e6fdc9ffeb39ffc7a13de8ee2ad3c8262bbcc8e::trump {
    struct TRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP>(arg0, 9, b"TRUMP", b"TRUMP WIN", b"Trump is a president of USA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://eightlugmafia.myshopify.com/cdn/shop/products/ScreenShot2020-03-19at1.21.31AM_1200x1200.png?v=1647753258")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TRUMP>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

