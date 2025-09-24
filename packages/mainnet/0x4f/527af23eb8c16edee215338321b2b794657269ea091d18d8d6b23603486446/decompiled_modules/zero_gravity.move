module 0x4f527af23eb8c16edee215338321b2b794657269ea091d18d8d6b23603486446::zero_gravity {
    struct ZERO_GRAVITY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZERO_GRAVITY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZERO_GRAVITY>(arg0, 9, b"0G", b"0G", b"ZO Virtual Coin for Zero Gravity (0G)", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZERO_GRAVITY>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ZERO_GRAVITY>>(v0);
    }

    // decompiled from Move bytecode v6
}

