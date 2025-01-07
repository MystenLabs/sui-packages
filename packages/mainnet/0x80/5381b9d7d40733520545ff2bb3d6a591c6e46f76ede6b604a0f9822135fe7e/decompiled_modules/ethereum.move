module 0x805381b9d7d40733520545ff2bb3d6a591c6e46f76ede6b604a0f9822135fe7e::ethereum {
    struct ETHEREUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ETHEREUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ETHEREUM>(arg0, 9, b"ETHEREUM", b"ESUITHSUIREUSUIM", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.cointelegraph.com/cdn-cgi/image/format=auto,onerror=redirect,quality=90,width=1434/https://s3.cointelegraph.com/uploads/2020-11/bff521af-a6ac-47b8-b2f0-360ad80712ad.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ETHEREUM>(&mut v2, 55555555000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ETHEREUM>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ETHEREUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

