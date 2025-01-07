module 0x714eb9a1303dfbc81bfc99d6c8c828cb212e82ec7474976c3cebb33dd467f089::andogi {
    struct ANDOGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANDOGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANDOGI>(arg0, 9, b"ANDOGI", b"Angel DOGI", b"From 0 to 10 million with $ANGELDOGI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://media.tenor.com/yxpzqmRsvi4AAAAi/angel-dog.gif")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ANDOGI>(&mut v2, 500000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANDOGI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANDOGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

