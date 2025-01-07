module 0x5f43cdf569fd05cd80efa8f89e5629c9afb059b42530161736186554f86deb5a::socks {
    struct SOCKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOCKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOCKS>(arg0, 9, b"SOCKS", b"SOCKS", b"SOCKS is underwear", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tiemart.com/cdn/shop/files/red-and-white-striped-socks_e2b44dda-c5a7-443a-a4ee-6f5b5d5dc857_1200x1200.jpg?v=1689284459")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SOCKS>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOCKS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOCKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

