module 0xdb758094ef87954a125a74a91e7c8c820d5394aed736f84c8b5e841a803cc27::walls {
    struct WALLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALLS>(arg0, 6, b"WALLS", b"Wall sui Boys", b"Wall street wolfs is live", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000027953_387985b420.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WALLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

