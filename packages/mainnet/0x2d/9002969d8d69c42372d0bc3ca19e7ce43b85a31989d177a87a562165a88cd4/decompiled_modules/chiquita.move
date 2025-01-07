module 0x2d9002969d8d69c42372d0bc3ca19e7ce43b85a31989d177a87a562165a88cd4::chiquita {
    struct CHIQUITA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIQUITA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIQUITA>(arg0, 9, b"CHIQUITA", b"CHIQUITA DOG", b"Who doesnt love banana", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmUhfrbyqRFFcC51QZAkBTJSWhE16LgvM6MyyrMxHYEU5L?img-width=256&img-dpr=2&img-onerror=redirect")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CHIQUITA>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIQUITA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHIQUITA>>(v1);
    }

    // decompiled from Move bytecode v6
}

