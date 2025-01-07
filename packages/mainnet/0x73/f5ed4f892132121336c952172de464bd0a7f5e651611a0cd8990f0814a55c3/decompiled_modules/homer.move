module 0x73f5ed4f892132121336c952172de464bd0a7f5e651611a0cd8990f0814a55c3::homer {
    struct HOMER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOMER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOMER>(arg0, 6, b"HOMER", b"HOMER SIMPSON", b"the simpsooooonsss", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/96633009_d1818000_1318_11eb_9f1d_7f914f4ccb16_c27a160596.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOMER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOMER>>(v1);
    }

    // decompiled from Move bytecode v6
}

