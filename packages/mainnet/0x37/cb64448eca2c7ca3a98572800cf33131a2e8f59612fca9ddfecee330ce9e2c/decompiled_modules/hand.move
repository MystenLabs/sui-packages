module 0x37cb64448eca2c7ca3a98572800cf33131a2e8f59612fca9ddfecee330ce9e2c::hand {
    struct HAND has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAND, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<HAND>(arg0, 6, b"HAND", b"Hand Agent by SuiAI", b"Listen, give a hand, I'm here, and you?..Hand advisor automated by #Kosmos", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/hand2_add6092b23.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HAND>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAND>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

