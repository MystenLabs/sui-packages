module 0x16eb307a9c76b71360592fc726d65328d6c29c7ee129b85c96ed364986b465c4::b_emanabio {
    struct B_EMANABIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_EMANABIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_EMANABIO>(arg0, 9, b"bEMANABIO", b"bToken EMANABIO", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_EMANABIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_EMANABIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

