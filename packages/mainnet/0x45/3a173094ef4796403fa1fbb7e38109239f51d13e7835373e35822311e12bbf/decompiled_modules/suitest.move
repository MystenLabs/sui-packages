module 0x453a173094ef4796403fa1fbb7e38109239f51d13e7835373e35822311e12bbf::suitest {
    struct SUITEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITEST>(arg0, 6, b"suiTEST", b"TEST", b"Literally just testing.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/test_button_1_ed6489ee2c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITEST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITEST>>(v1);
    }

    // decompiled from Move bytecode v6
}

