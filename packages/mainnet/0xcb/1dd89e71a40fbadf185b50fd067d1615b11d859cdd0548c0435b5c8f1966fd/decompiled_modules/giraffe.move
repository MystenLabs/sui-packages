module 0xcb1dd89e71a40fbadf185b50fd067d1615b11d859cdd0548c0435b5c8f1966fd::giraffe {
    struct GIRAFFE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIRAFFE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIRAFFE>(arg0, 9, b"GIRAFFE", x"f09fa69247495241464645", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GIRAFFE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIRAFFE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GIRAFFE>>(v1);
    }

    // decompiled from Move bytecode v6
}

