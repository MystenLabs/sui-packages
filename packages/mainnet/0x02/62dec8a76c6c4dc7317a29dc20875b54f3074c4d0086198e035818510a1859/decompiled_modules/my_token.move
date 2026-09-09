module 0x262dec8a76c6c4dc7317a29dc20875b54f3074c4d0086198e035818510a1859::my_token {
    struct MY_TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MY_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MY_TOKEN>(arg0, 9, b"ALIEN", b"ALIENSS", b"Token Pasokan Tetap 1x Mint", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static.vecteezy.com/system/resources/thumbnails/017/764/201/small/bird-freedom-fly-animal-line-art-linear-simple-abstract-minimalist-circle-border-logo-design-vector.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<MY_TOKEN>>(0x2::coin::mint<MY_TOKEN>(&mut v2, 100000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MY_TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MY_TOKEN>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}

