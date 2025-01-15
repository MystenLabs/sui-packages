module 0x23704799c2a7326be9629603d3c6798f3818a75089e4b4881310a56c9cfc9bab::hand {
    struct HAND has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAND, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<HAND>(arg0, 6, b"HAND", b"Hand Agent by SuiAI", b"Listen, give a hand, I'm here, and you?..Hand advisor automated by #Kosmos", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/hand2_add6092b23_98c98cfa55.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HAND>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAND>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

