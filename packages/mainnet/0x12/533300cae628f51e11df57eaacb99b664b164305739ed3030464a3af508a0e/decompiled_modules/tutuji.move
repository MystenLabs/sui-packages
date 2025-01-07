module 0x12533300cae628f51e11df57eaacb99b664b164305739ed3030464a3af508a0e::tutuji {
    struct TUTUJI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUTUJI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUTUJI>(arg0, 9, b"TUTUJI", b"TUTUIJ", b"THAT WORM THAT THIS YOU DO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e64f3cd1-d7d3-46e4-ba35-0eaa4ceac199.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUTUJI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TUTUJI>>(v1);
    }

    // decompiled from Move bytecode v6
}

