module 0x65d1fb7b250e9b9348f9e74fd1143c2078c99774aec252e15238bf20d6364d2c::oak {
    struct OAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: OAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OAK>(arg0, 9, b"OAK", b"OAK", b"Wise Oak", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://play-lh.googleusercontent.com/n1mHYu6ORHM6HYPzTwRVSmxDGW91sfRn3lPrguSS2YxFbUPSwQzTGcWmo3Lx8IFzjMw=w240-h480-rw")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<OAK>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OAK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OAK>>(v1);
    }

    // decompiled from Move bytecode v6
}

