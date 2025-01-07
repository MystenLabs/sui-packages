module 0x60f5cceff99c5940e8b4caa4b8b4e9e85a06188fb6c060d74de80ed08dfa410d::sol {
    struct SOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOL>(arg0, 9, b"SOL", b"Foreign token represent SOLANA", b"Foreign token represent SOLANA", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

