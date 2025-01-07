module 0xa73ce74b7dc826b898749284325af2bf444d2b2b599af16a4d7c89cc78c2e08a::blk {
    struct BLK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLK>(arg0, 6, b"BLK", b"BLANK", b"NAME CAN ONLY BE BLANK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_03_215717_bd8023a22b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLK>>(v1);
    }

    // decompiled from Move bytecode v6
}

