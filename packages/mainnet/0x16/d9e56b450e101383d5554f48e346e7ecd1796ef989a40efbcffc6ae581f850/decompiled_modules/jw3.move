module 0x16d9e56b450e101383d5554f48e346e7ecd1796ef989a40efbcffc6ae581f850::jw3 {
    struct JW3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: JW3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JW3>(arg0, 6, b"JW3", b"JW3ai", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JW3>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JW3>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

