module 0xe1e73253cf445fa387a90107fa76817d8233a2cf699802b9bd43094c854481d5::leper {
    struct LEPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEPER>(arg0, 6, b"LEPER", b"Larry the Leper", b"Im Larry the Leper, Pepes long-lost Irish cousin, and lucks always been on my side", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/background_1_3_eebc324c26.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LEPER>>(v1);
    }

    // decompiled from Move bytecode v6
}

