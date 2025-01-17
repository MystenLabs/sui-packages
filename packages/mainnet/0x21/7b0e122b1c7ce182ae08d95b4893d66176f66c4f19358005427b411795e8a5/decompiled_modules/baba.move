module 0x217b0e122b1c7ce182ae08d95b4893d66176f66c4f19358005427b411795e8a5::baba {
    struct BABA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BABA>(arg0, 6, b"BABA", b"baba by SuiAI", b"baab", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/pepe_28f5bebc40.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BABA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

