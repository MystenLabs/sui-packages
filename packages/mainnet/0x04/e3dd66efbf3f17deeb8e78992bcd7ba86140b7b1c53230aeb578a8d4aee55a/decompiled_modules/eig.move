module 0x4e3dd66efbf3f17deeb8e78992bcd7ba86140b7b1c53230aeb578a8d4aee55a::eig {
    struct EIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: EIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EIG>(arg0, 8, b"EIG", b"EIG", b"eig coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EIG>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<EIG>>(v0);
    }

    // decompiled from Move bytecode v6
}

