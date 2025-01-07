module 0x25e3a8f0733d2475c7f32457f4f34a27ac769f2dbc65d861ef9247171a32f465::suitato {
    struct SUITATO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITATO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITATO>(arg0, 6, b"SUITATO", b"SuitatoOnSui", x"0a245355495441544f2c2074686520706f7461746f20696e20612073756974206f6e205355492c2069732074686520756c74696d617465206d656d65206c6567656e642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000384_9ac2f5a1c7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITATO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITATO>>(v1);
    }

    // decompiled from Move bytecode v6
}

