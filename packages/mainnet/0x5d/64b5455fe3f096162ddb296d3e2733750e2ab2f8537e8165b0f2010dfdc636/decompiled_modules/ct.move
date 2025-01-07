module 0x5d64b5455fe3f096162ddb296d3e2733750e2ab2f8537e8165b0f2010dfdc636::ct {
    struct CT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CT>(arg0, 6, b"CT", b"CATDOG SUI", b"DEV WILL BURN ALL TOKEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004216_65635d06a7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CT>>(v1);
    }

    // decompiled from Move bytecode v6
}

