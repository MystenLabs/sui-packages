module 0xf74d1bac195c83ad0c73b761a19b78cfcc106cc22cb91049b24c42a90f5ecfb6::triton {
    struct TRITON has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRITON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRITON>(arg0, 9, b"TRITON", b"Triton", b"Nereus Triton vault coin: a stablecoin + Bitcoin basket.", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRITON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRITON>>(v1);
    }

    // decompiled from Move bytecode v7
}

