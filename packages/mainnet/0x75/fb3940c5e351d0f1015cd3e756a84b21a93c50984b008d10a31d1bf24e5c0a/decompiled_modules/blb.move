module 0x75fb3940c5e351d0f1015cd3e756a84b21a93c50984b008d10a31d1bf24e5c0a::blb {
    struct BLB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLB>(arg0, 6, b"BLB", b"BLBUL", b"OFFICIALL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Unknown_10_61a4c1a2fe.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLB>>(v1);
    }

    // decompiled from Move bytecode v6
}

