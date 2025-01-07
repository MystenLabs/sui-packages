module 0x508f648798e068f5a6245fef06cd402c7678582220e7c2687493030f86478f2d::salope {
    struct SALOPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SALOPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SALOPE>(arg0, 9, b"SALOPE", b"Salope", b"Official token of Salope.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SALOPE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SALOPE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SALOPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

