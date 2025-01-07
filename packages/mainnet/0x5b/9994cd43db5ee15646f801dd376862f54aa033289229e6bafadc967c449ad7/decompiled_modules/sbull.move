module 0x5b9994cd43db5ee15646f801dd376862f54aa033289229e6bafadc967c449ad7::sbull {
    struct SBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBULL>(arg0, 6, b"SBULL", b"SUI BULL", b"The biggest mogger & bull run mascot of SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_13_17_53_31_ca1d60ca01.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

