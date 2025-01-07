module 0x3a9d347f7cc77bfbbaf5d01c59e31f6c3c198da2b3a3d5d285f2249f85c08363::wd {
    struct WD has drop {
        dummy_field: bool,
    }

    fun init(arg0: WD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WD>(arg0, 6, b"WD", b"Water Drop", b"Water Water DROP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000013579_9c523b72e9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WD>>(v1);
    }

    // decompiled from Move bytecode v6
}

