module 0x98c1a9b6dbd2eb92c363716b023217d4b94b4aa7b03acfed03f0bb629b5f959c::boge {
    struct BOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOGE>(arg0, 6, b"BOGE", b"SUIBOGE", x"0a496e74726f647563696e6720426f67652c20746865206d6f73742053554920646f67206f6e2074686520626c6f636b636861696e207363656e65", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/t_A_N_Uwd_C_400x400_345e67b668.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

