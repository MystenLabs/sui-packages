module 0x19a743204460b3eab5d22742bd9ad85da0ef66e13510c4d07fbbda996b4be0f1::sui50000 {
    struct SUI50000 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI50000, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI50000>(arg0, 6, b"Sui50000", b"0-50,000 Sui challenge", b"Lets see how fast we can run this coin to 50,000 Sui ($100,000mc)!! Dont forget to take profits when we hit 100k!! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2309_80eda3c0ad.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI50000>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI50000>>(v1);
    }

    // decompiled from Move bytecode v6
}

