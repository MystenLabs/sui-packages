module 0x484c2d47e67fc0029565272e582ec028b74e0e6149d1958f21f83bf46f64ba5::screamm {
    struct SCREAMM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCREAMM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCREAMM>(arg0, 6, b"SCREAMM", b"SCREAM", b"JUST SCREAMMMMMMMMM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibm235fx2hzeccn7qjvyasbxpmvhohhpknr3byld2ytkzt5bkgkqy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCREAMM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SCREAMM>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

