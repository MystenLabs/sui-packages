module 0x3e1cb41688efaa4c0368fd669d399da4a81aa1f46190fcee31f3cb924b8b6686::b_trenchyoda {
    struct B_TRENCHYODA has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_TRENCHYODA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_TRENCHYODA>(arg0, 9, b"bTrenchYoda", b"bToken TrenchYoda", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_TRENCHYODA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_TRENCHYODA>>(v1);
    }

    // decompiled from Move bytecode v6
}

