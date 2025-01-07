module 0x49ae1e9f0824a5e4a958855068adc4e5df72e24883198e7aa1e3c280037b3e7b::syyanic {
    struct SYYANIC has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SYYANIC>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SYYANIC>>(0x2::coin::mint<SYYANIC>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SYYANIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SYYANIC>(arg0, 6, b"SYYANIC", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SYYANIC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SYYANIC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

