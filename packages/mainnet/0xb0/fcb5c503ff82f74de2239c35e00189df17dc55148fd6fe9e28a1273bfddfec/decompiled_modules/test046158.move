module 0xb0fcb5c503ff82f74de2239c35e00189df17dc55148fd6fe9e28a1273bfddfec::test046158 {
    struct TEST046158 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST046158, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST046158>(arg0, 9, b"TEST046158", b"Test Token 046158", b"Test token deployed on mainnet at 2025-10-19T21:57:26.158Z", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST046158>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST046158>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

