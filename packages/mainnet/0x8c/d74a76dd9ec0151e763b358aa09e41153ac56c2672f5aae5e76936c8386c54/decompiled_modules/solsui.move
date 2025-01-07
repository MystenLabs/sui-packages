module 0x8cd74a76dd9ec0151e763b358aa09e41153ac56c2672f5aae5e76936c8386c54::solsui {
    struct SOLSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOLSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOLSUI>(arg0, 6, b"SOLSUI", b"SOLANAsui", x"546869732070726f6a65637420546f20746865204d4f4f4ef09f9a80f09f9a80f09f9a80f09f92b0", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733090018245.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOLSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOLSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

