module 0x8e247878de7f558ae2119fea12e35e32ef9966549422d549cdbeea973a7b2729::grage {
    struct GRAGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRAGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRAGE>(arg0, 6, b"GRAGE", b"Grage", b"Green candle coming soon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000051431_9cd873ef52.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRAGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRAGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

