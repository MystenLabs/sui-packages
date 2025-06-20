module 0x10cb719b69a7f529600e7238460944c3932f98a2a95b48a0728ac3bbb9c95534::bnb {
    struct BNB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BNB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BNB>(arg0, 8, b"BNB", b"BNB", b"ZO Virtual Coin for BNB", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BNB>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BNB>>(v0);
    }

    // decompiled from Move bytecode v6
}

