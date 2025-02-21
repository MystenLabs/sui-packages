module 0x6511052d2f1404934e0d877709949bcda7c1d451d1218a4b2643ca2f3fa93991::scallop_ns {
    struct SCALLOP_NS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCALLOP_NS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCALLOP_NS>(arg0, 6, b"sNS", b"sNS", b"Scallop interest-bearing token for NS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://3vhaecwgpni3lhtpvmwylermast5evx5e7x46x3hw534olzdqq7q.arweave.net/3U4CCsZ7UbWeb6sthZIsBKfSVv0n789fZ7d3xy8jhD8")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCALLOP_NS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCALLOP_NS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

