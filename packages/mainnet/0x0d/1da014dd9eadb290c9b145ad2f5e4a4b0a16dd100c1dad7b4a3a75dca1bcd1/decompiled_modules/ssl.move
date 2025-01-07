module 0xd1da014dd9eadb290c9b145ad2f5e4a4b0a16dd100c1dad7b4a3a75dca1bcd1::ssl {
    struct SSL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSL>(arg0, 6, b"SSL", b"Spinning Sea Lion", b"Sea Lion spinning on SUI waves", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/otter_spin_c98cf56e2a.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSL>>(v1);
    }

    // decompiled from Move bytecode v6
}

