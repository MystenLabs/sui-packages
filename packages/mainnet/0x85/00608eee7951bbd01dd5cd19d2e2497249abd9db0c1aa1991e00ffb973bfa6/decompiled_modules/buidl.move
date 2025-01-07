module 0x8500608eee7951bbd01dd5cd19d2e2497249abd9db0c1aa1991e00ffb973bfa6::buidl {
    struct BUIDL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUIDL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUIDL>(arg0, 6, b"BUIDL", b"$BUIDL", b"The \"BUIDL\" community is known for its long-term HODLing strategy, believing in the future of cryptocurrencies and what they HODL.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3410_cf7a39be78.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUIDL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUIDL>>(v1);
    }

    // decompiled from Move bytecode v6
}

