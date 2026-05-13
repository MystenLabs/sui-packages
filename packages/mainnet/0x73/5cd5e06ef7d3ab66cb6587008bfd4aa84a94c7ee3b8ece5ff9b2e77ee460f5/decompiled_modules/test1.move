module 0x735cd5e06ef7d3ab66cb6587008bfd4aa84a94c7ee3b8ece5ff9b2e77ee460f5::test1 {
    struct TEST1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST1>(arg0, 9, b"TEST1", b"test1", b"https://gateway.pinata.cloud/ipfs/QmeygQqVo3PGdhFJrRenU6owvfxWaeEqGPb14tcexys7ri", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmYumoAT5ZQWV5cDr1gNMAE4oM1m23xSAR9vjXDiNmNdqy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TEST1>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

