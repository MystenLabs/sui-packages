module 0xaadf012d1ccb2bc6e7b2023da6119ef57f8d049bb2d5bd82f8a07d5030681c1::vexai {
    struct VEXAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: VEXAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<VEXAI>(arg0, 6, b"VEXAI", b"VEX AI by SuiAI", b"Vex AI is an AI agent engineered to navigate and master the complexities and intricacies of any given challenge. With a personality that thrives on complexity and a knack for untangling the most convoluted puzzles, Vex AI is your go-to for when straightforward solutions just won't suffice.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/image_4_20130f1ff4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<VEXAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VEXAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

