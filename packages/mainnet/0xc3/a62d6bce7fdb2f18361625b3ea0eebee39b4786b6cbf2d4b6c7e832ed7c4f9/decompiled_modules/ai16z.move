module 0xc3a62d6bce7fdb2f18361625b3ea0eebee39b4786b6cbf2d4b6c7e832ed7c4f9::ai16z {
    struct AI16Z has drop {
        dummy_field: bool,
    }

    fun init(arg0: AI16Z, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AI16Z>(arg0, 6, b"Ai16z", b"Ai16z on sui", b"First ai16z on sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_27_10_50_40_fbab78c756.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AI16Z>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AI16Z>>(v1);
    }

    // decompiled from Move bytecode v6
}

