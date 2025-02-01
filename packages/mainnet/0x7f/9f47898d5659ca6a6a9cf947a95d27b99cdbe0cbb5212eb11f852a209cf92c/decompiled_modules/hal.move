module 0x7f9f47898d5659ca6a6a9cf947a95d27b99cdbe0cbb5212eb11f852a209cf92c::hal {
    struct HAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<HAL>(arg0, 6, b"HAL", b"HAL 9000 by SuiAI", b"HAL 9000 (Heuristically Programmed Algorithmic Computer) Heuristics are problem-solving methods that use a practical approach to reach solutions faster than traditional methods. They involve learning from past experiences and making educated guesses. Algorithmic refers to a set of rules or instructions designed to perform a specific task or solve a particular problem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/HAL_9000_792dce8c0b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HAL>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAL>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

