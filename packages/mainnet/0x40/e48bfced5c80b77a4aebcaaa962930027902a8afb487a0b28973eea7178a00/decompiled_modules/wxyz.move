module 0x40e48bfced5c80b77a4aebcaaa962930027902a8afb487a0b28973eea7178a00::wxyz {
    struct WXYZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: WXYZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<WXYZ>(arg0, 6, b"WXYZ", b"WXYZ XX Something Yield", b"WXYZ XX Something Yield", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WXYZ>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WXYZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCap<WXYZ>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

