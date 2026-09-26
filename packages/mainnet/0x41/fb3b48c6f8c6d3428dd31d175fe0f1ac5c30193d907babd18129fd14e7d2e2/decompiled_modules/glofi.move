module 0x41fb3b48c6f8c6d3428dd31d175fe0f1ac5c30193d907babd18129fd14e7d2e2::glofi {
    struct GLOFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLOFI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"-";
        let v1 = if (0x1::vector::length<u8>(&v0) < 2) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"-"))
        };
        let (v2, v3) = 0x2::coin::create_currency<GLOFI>(arg0, 9, b"GLOFI", b"gold lofi", b"", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GLOFI>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLOFI>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<GLOFI>>(0x2::coin::mint<GLOFI>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

