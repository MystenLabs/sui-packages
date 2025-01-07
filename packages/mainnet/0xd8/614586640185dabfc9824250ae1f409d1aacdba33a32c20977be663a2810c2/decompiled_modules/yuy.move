module 0xd8614586640185dabfc9824250ae1f409d1aacdba33a32c20977be663a2810c2::yuy {
    struct YUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUY>(arg0, 9, b"YUY", b"YuYu", b"WORD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.shutterstock.com/image-vector/eagle-vector-illustration-art-usa-600nw-2318187367.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<YUY>(&mut v2, 500000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YUY>>(v1);
    }

    // decompiled from Move bytecode v6
}

