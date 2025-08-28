module 0xc742f6f87588796a0bc11fb9072a7529efe90e9ff6fcc8c81a5233a214e8a7d::Brair {
    struct BRAIR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRAIR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRAIR>(arg0, 9, b"BRAIR", b"Brair", b"hairy brain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/GzXGW5pXcAAohu7?format=jpg&name=medium")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BRAIR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRAIR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

