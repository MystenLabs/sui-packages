module 0xf4b9f1a832a32ac365b52fead635b56178ae41c3563ba9ca31444aaa12ff72e7::sri {
    struct SRI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRI>(arg0, 6, b"SRI", b"SUIRRARI", b"https://x.com/suirraritoken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004224_78c700510c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SRI>>(v1);
    }

    // decompiled from Move bytecode v6
}

