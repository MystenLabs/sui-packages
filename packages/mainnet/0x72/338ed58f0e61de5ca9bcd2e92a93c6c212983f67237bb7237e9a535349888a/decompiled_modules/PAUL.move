module 0x72338ed58f0e61de5ca9bcd2e92a93c6c212983f67237bb7237e9a535349888a::PAUL {
    struct PAUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAUL>(arg0, 6, b"PAUL", b"Paul American", b"THE Paul American family reality TV show ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/QmY5UvdXyLKEXXtxqmhdzFoAzT8jMuL5QYAcCqmPGuay6V")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAUL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAUL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

