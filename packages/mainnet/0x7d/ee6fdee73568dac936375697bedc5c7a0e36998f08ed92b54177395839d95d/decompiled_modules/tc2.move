module 0x7dee6fdee73568dac936375697bedc5c7a0e36998f08ed92b54177395839d95d::tc2 {
    struct TC2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TC2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TC2>(arg0, 6, b"TC2", b"SAM Test 2", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TC2>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TC2>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

