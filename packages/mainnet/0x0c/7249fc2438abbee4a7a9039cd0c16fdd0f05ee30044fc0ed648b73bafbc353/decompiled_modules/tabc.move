module 0xc7249fc2438abbee4a7a9039cd0c16fdd0f05ee30044fc0ed648b73bafbc353::tabc {
    struct TABC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TABC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TABC>(arg0, 6, b"TABC", b"TESTABC", b"TEST", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Picture1_4021f8e75c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TABC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TABC>>(v1);
    }

    // decompiled from Move bytecode v6
}

