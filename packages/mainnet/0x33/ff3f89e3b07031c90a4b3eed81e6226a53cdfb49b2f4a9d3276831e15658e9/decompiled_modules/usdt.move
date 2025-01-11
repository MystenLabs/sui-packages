module 0x33ff3f89e3b07031c90a4b3eed81e6226a53cdfb49b2f4a9d3276831e15658e9::usdt {
    struct USDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDT>(arg0, 9, b"USDT", b"USDT", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/rOJgza62cEbRdFkeLQNtMmZSNXBIQt0-dj8CFQOIqDY")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<USDT>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDT>>(v2, @0x414cfcc81d3ee9226ab0a179a291d008b4e096b2d4ceee66953859c2d4c12a43);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USDT>>(v1);
    }

    // decompiled from Move bytecode v6
}

