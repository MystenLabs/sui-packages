module 0x3894395207509b687ddbf360b0f5c790cadd1f4954a9bb0f773710e15e149bdf::suirek {
    struct SUIREK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIREK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIREK>(arg0, 6, b"SUIREK", b"SUIREK on SUI", b"$Suirek rides the waves, conquering the ocean with Suis logo and green candles by his side.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3e4e8489_10ae_4156_bd09_738eb38d0ced_a9cb2a8cc6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIREK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIREK>>(v1);
    }

    // decompiled from Move bytecode v6
}

