module 0xcab5fe68944c53bbbc894c41140b8a859e1a047e5681b8958ceb4551687da36a::sagemove {
    struct SAGEMOVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAGEMOVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAGEMOVE>(arg0, 6, b"SageMove", b"Sage", b"up up up up up up up up up", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/btc1_9a0cf403ab.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAGEMOVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAGEMOVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

