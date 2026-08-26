module 0x117e6f31d838ee6eb6ca011c854d3174787bdf97b836fe074f6b6376cd9c6ea9::sama {
    struct SAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAMA>(arg0, 9, b"SAMA", b"SAMA", b"SAM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.irys.xyz/Kd-72FJMSXcVhKngJYqug9S_dcurfWt-oqCvW7k_98g")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SAMA>>(0x2::coin::mint<SAMA>(&mut v2, 1000000000000000000, arg1), @0x2819acd7f5163cfb3eb7cd06b2d312244a78d6ffd56b829c67c28c0d97d29f37);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SAMA>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAMA>>(v1);
    }

    // decompiled from Move bytecode v7
}

