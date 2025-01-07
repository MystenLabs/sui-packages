module 0x3c44be81d6bd386a1283c8b1c4840a8364b5c27505508598ad9c5729e9ec5269::swee {
    struct SWEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWEE>(arg0, 9, b"SWEE", b"Swee", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SWEE>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWEE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

