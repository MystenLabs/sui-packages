module 0xd74d4d8b31e6eec10056770ac4f2955f4622b190351b4039f77a81f093a48acd::spu {
    struct SPU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPU>(arg0, 6, b"SPU", b"Suipurr", b"The Purring Future of Cryptocurrency", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000032685_6caa84cb12.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPU>>(v1);
    }

    // decompiled from Move bytecode v6
}

