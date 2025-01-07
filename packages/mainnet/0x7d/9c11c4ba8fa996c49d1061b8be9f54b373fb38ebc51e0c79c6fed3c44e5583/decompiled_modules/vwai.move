module 0x7d9c11c4ba8fa996c49d1061b8be9f54b373fb38ebc51e0c79c6fed3c44e5583::vwai {
    struct VWAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: VWAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VWAI>(arg0, 6, b"VWAI", b"Virtual World AI", b"Virtual World Artificial Intelligence", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/JV0rYwx.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<VWAI>(&mut v2, 500000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VWAI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VWAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

