module 0xba1c5400818cfff9d9ebdafaced09e9d0215497ebc73d45aefcb345fc0a65d27::anai {
    struct ANAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ANAI>(arg0, 6, b"ANAI", b"ANAS AI by SuiAI", b"Chatbot on x giving new pigment updates", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/WIN_20250101_21_32_28_Pro_f7a9dae427.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ANAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

