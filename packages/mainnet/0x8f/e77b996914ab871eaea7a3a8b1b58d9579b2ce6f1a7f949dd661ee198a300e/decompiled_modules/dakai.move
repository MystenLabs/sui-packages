module 0x8fe77b996914ab871eaea7a3a8b1b58d9579b2ce6f1a7f949dd661ee198a300e::dakai {
    struct DAKAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAKAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DAKAI>(arg0, 6, b"DAKAI", b"DAKKI AI by SuiAI", b"DAKAI On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/0x41636c138167952207c88f5a75e433c9e880bc7bd5e4e46047d82be266d36712_dak_dak_34d688bd1e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DAKAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAKAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

