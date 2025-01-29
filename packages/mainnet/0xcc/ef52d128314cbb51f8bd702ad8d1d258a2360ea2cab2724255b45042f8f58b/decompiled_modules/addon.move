module 0xccef52d128314cbb51f8bd702ad8d1d258a2360ea2cab2724255b45042f8f58b::addon {
    struct ADDON has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADDON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADDON>(arg0, 6, b"AddOn", b"AddOn AI", x"4d6f6e6574697a6520796f7572204169204167656e7473202f20536f6369616c7320616e64204561726e205061737369766520496e636f6d652e204465706c6f79204169204164766572746973656d656e74204167656e74732e20416363657373204d756c7469706c6520416920546f6f6c732e2042726f7567687420746f20796f7520627920244164644f6e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1738120232495.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ADDON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADDON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

