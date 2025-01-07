module 0x3d0cd0fd665bc8010a98e94fa1ab7471551e39e22a86c620005a68f368f657e0::ponkie {
    struct PONKIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PONKIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PONKIE>(arg0, 9, b"PONKIE", b"PONKIE", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PONKIE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PONKIE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PONKIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

