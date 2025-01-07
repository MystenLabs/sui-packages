module 0xeda73983ac8e9fac6dd83e4282d0b50895b6f957850e69d5b0a0576ec7e6d6ba::naughty {
    struct NAUGHTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAUGHTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAUGHTY>(arg0, 9, b"naughty", b"naughty2", b"really naughty 2", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.svgrepo.com/show/535118/accessibility.svg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NAUGHTY>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAUGHTY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NAUGHTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

