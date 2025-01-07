module 0x5cbdee2fd723556ec0cdbaff2f0b23f5e06cf7149cf1c2787879794fe59015ca::big {
    struct BIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIG>(arg0, 6, b"BIG", b"B.I.G", b"This is BIG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BIGSUI_7a6fbbfb29.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

