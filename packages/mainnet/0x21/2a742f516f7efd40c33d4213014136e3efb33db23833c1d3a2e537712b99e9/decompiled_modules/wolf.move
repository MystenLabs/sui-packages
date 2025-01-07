module 0x212a742f516f7efd40c33d4213014136e3efb33db23833c1d3a2e537712b99e9::wolf {
    struct WOLF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOLF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOLF>(arg0, 9, b"WOLF", b"SuiWallStreets", b"Lobo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/EkwVceuXgAADjsP.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WOLF>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOLF>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOLF>>(v1);
    }

    // decompiled from Move bytecode v6
}

