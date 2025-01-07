module 0xdd98c13381abf2f4d3fd013e0fd7c4aa2cec66be3eeb7fb701bcfae72251b94b::jepe {
    struct JEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JEPE>(arg0, 6, b"Jepe", b"JEPE", x"746865206d6f7374206d656d6561626c65206a656c6c7966697368206f6e2074686520696e7465726e65740a0a207c20687474703a2f2f6a6570657375692e636f6d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730953039112.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JEPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JEPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

