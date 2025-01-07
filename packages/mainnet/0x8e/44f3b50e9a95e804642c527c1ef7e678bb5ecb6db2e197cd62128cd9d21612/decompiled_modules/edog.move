module 0x8e44f3b50e9a95e804642c527c1ef7e678bb5ecb6db2e197cd62128cd9d21612::edog {
    struct EDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: EDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EDOG>(arg0, 9, b"EDOG", b"elondog", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<EDOG>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EDOG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

