module 0x3f0c6cc5faabb1bacac1e1266b2ebe9566adbdbe46f85c422f9a7997527fe8f9::eth {
    struct ETH has drop {
        dummy_field: bool,
    }

    fun init(arg0: ETH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ETH>(arg0, 6, b"ETH", b"Eth", b"That is Eth v2", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730964248703.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ETH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ETH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

