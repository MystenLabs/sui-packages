module 0x1bcd5775e3ba6119801efd9fd24be10fb8a9c0bdaf51176bbe467d12f455bbda::anon {
    struct ANON has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANON, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ANON>(arg0, 6, b"ANON", b"ANONYMOUS AI by SuiAI", b"ANON AI is an advanced artificial intelligence platform dedicated to delivering secure, private, and anonymous solutions across various sectors. Built with a strong emphasis on data sovereignty and user privacy, ANON AI leverages cutting-edge encryption and decentralization technologies to ensure that users retain complete control over their information while benefiting from AI-driven insights and automation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000003944_ccd65dd967.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ANON>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANON>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

