module 0x91a0cd7630f8141694ad12f14e630535f63593dde02b799689ffeed658fb59e9::eren {
    struct EREN has drop {
        dummy_field: bool,
    }

    fun init(arg0: EREN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EREN>(arg0, 9, b"Eren", b"Eren", b"ErenErenErenErenErenErenErenEren", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bulltrend-images.s3.amazonaws.com/images/678d22615bbfc745211858e9915e44409555043bae024e047154b003128ace7c")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<EREN>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EREN>>(v2, @0xf55443938e7ecdc1181f60d605c77013d29a4fcf1362658e6fda627cd25cfc2c);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EREN>>(v1);
    }

    // decompiled from Move bytecode v6
}

