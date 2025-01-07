module 0xc0bcd31fa88b663fa6e91992ff7303046b3c7148be70eb7a703d43291d720acc::flip {
    struct FLIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLIP>(arg0, 9, b"FLIP", b"Chainflip", b"swap.chainflip.io", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://imgur.com/a/SJ34Tj5")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FLIP>(&mut v2, 90000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLIP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

