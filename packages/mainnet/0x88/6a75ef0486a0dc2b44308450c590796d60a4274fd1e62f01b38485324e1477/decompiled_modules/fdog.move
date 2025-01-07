module 0x886a75ef0486a0dc2b44308450c590796d60a4274fd1e62f01b38485324e1477::fdog {
    struct FDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FDOG>(arg0, 6, b"FDOG", b"FLYDOG", x"466c7920646f67206d656d6520696e20746865206d6f6f6e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000018226_af7065a1c6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

