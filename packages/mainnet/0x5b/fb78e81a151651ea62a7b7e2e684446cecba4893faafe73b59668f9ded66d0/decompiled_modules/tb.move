module 0x5bfb78e81a151651ea62a7b7e2e684446cecba4893faafe73b59668f9ded66d0::tb {
    struct TB has drop {
        dummy_field: bool,
    }

    fun init(arg0: TB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TB>(arg0, 9, b"TB", b"TeraByte", b"TeraByte Token", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TB>>(v1);
        0x2::coin::mint_and_transfer<TB>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TB>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

