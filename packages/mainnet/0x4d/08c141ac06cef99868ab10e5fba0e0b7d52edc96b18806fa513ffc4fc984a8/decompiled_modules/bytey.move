module 0x4d08c141ac06cef99868ab10e5fba0e0b7d52edc96b18806fa513ffc4fc984a8::bytey {
    struct BYTEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BYTEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BYTEY>(arg0, 6, b"BYTEY", b"BYTEY ON SUI", b"Bytey and the Adventures on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3_b37990c956.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BYTEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BYTEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

