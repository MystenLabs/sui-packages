module 0x68797044e7ec68607090b568002ace9aa1b1f82ee77b3f463f2a75e99053b751::evans {
    struct EVANS has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVANS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<EVANS>(arg0, 6, b"EVANS", b"Evan Cheng by SuiAI", b"Evan Cheng is the CEO and co-founder of Mysten Labs, the company behind Sui blockchain, which develops tools to make web3 secure, reliable, and ready for mass adoption.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/evans_12a1fef37e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EVANS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVANS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

