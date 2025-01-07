module 0x12ce00d4f09ba7e18183e291eb0a4d470f64e6e88854c0cfcf3c04ad7ab1519d::poptart {
    struct POPTART has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPTART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPTART>(arg0, 9, b"POPTART", b"Sui Poptart", b"just a Poptart", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmPtDXhcrgnAsQ7RjcgqJKLrEgPjR5yuhWVNc8PYhy8gJk?img-width=256&img-dpr=2&img-onerror=redirect")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<POPTART>(&mut v2, 50000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPTART>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPTART>>(v1);
    }

    // decompiled from Move bytecode v6
}

