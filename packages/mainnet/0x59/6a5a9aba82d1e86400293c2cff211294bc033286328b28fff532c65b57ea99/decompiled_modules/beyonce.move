module 0x596a5a9aba82d1e86400293c2cff211294bc033286328b28fff532c65b57ea99::beyonce {
    struct BEYONCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEYONCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEYONCE>(arg0, 9, b"BEYONCE", x"f09f91a9f09f8fbb4265796f6e6365", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BEYONCE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEYONCE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEYONCE>>(v1);
    }

    // decompiled from Move bytecode v6
}

