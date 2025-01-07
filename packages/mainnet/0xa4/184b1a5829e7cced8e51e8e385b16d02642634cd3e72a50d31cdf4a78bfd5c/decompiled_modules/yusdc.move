module 0xa4184b1a5829e7cced8e51e8e385b16d02642634cd3e72a50d31cdf4a78bfd5c::yusdc {
    struct YUSDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUSDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUSDC>(arg0, 6, b"yUSDC", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YUSDC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUSDC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

