module 0xda189810eaba537d7f4a7b31c46fa0a976e95b1f4a23d4ddd1623f8dcbdb3fad::lcn {
    struct LCN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LCN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LCN>(arg0, 9, b"LCN", b"Learn Coin", b"For Learning Purpose", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://thumbs.dreamstime.com/b/open-book-isolated-white-16094903.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LCN>(&mut v2, 5000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LCN>>(v2, @0xf5418b294936620de8388a9920a9429099b363ab840575a4c6f459b22c37d834);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LCN>>(v1);
    }

    // decompiled from Move bytecode v6
}

