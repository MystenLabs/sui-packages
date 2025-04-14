module 0x7064db017ee5902732e703c9851a9a2ee3163c75f84279760f06212354eb62de::y {
    struct Y has drop {
        dummy_field: bool,
    }

    fun init(arg0: Y, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<Y>(arg0, 6, b"Y", b"YramidOnSui", b"Yramid on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000057737_75293fd811.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<Y>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<Y>>(v1);
    }

    // decompiled from Move bytecode v6
}

