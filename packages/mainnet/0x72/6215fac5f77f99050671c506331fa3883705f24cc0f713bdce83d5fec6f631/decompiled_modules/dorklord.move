module 0x726215fac5f77f99050671c506331fa3883705f24cc0f713bdce83d5fec6f631::dorklord {
    struct DORKLORD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DORKLORD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DORKLORD>(arg0, 6, b"DORKLORD", b"DORKLORD  SuI", x"5072657061726520796f757273656c662c20796f756e67205061646177616e2c20666f7220746865206d6f73742065706963206d656d65636f696e20696e2074686520245355492067616c6178793a20444f524b4c4f524421200a0a4d617920746865204d656d6573206265207769746820796f752121", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DOKRLOR_f495e9774a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DORKLORD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DORKLORD>>(v1);
    }

    // decompiled from Move bytecode v6
}

