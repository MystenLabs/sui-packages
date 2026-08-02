module 0x6c9a61cfff6754cdf34ca17da1d4f30a4c2d8d900b3a049e1f0183f61c961c0c::DeepV2 {
    struct DEEPV2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEEPV2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEEPV2>(arg0, 9, b"DEEP", b"DeepV2", b"DEEP (deepv2.net)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://deepv2.net")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DEEPV2>(&mut v2, 1000 * 0x1::u64::pow(10, 9), 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEEPV2>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEEPV2>>(v1);
    }

    // decompiled from Move bytecode v6
}

