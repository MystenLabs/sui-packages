module 0xa569c97f7eb913aca1d9677573aebca58a5dce72e90ec05add4681be31e5b2cc::socksdog {
    struct SOCKSDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOCKSDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOCKSDOG>(arg0, 6, b"Socksdog", b"socks dog on sui", x"546865206d6f737420756e6971756520646f67206f6e207375690a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/socks_6e2719f7a1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOCKSDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOCKSDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

