module 0x638421f1553ce97898344d0aeb72b7b3c24fee927ca8e1d98aeb8a3cd806028c::agent {
    struct AGENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGENT>(arg0, 6, b"AGENT", b"MatrixOracle ", b"Matrix Oracle: The 1st AI agent crafting evolving, user-shaped stories for a personalized, immersive experience built on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736963690728.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AGENT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGENT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

