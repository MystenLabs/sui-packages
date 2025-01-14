module 0x811e06c2be31c8d920358ebafe9fecc3811e7d3bde256f536e7d383b1dfbae84::wiseguy {
    struct WISEGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WISEGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<WISEGUY>(arg0, 6, b"WISEGUY", b"WiseGuy by SuiAI", b"WiseGuy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/20250115_012430_10327aff71.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WISEGUY>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WISEGUY>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

