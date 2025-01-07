module 0x4ae376467d42825de2dc00a7d1ab0d2c258ac37e051f3c93c2c0afa5887c02e4::deep {
    struct DEEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEEP>(arg0, 9, b"DEEP", b"DEEPv2 (bridge asset: deepv2.com)", b"Complete it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://imagedelivery.net/cBNDGgkrsEA-b_ixIp9SkQ/DEEP_BlueBackground.png/public")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DEEP>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEEP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEEP>>(v1);
    }

    // decompiled from Move bytecode v6
}

