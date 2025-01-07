module 0x60d91d857978382cae68e2302c376b6e9c99f871a3b9d0f6eba17619b130b199::aishiba {
    struct AISHIBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AISHIBA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AISHIBA>(arg0, 6, b"AISHIBA", b"AI AGENT SHIBA by SuiAI", b"AI AGENT SHIBA is an AI agent designed to interact with users on the SUI platform, a blockchain focused on creating smart applications and decentralized financial services. Shiba is capable of providing market information, offering investment advice, and even executing automatic transactions based on user commands. It is inspired by the Shiba Inu dog, an icon for many meme coins and notable crypto projects.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/5e246b44_10a9_4f2c_a5c8_3453e689d4c7_8aa5f33908.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AISHIBA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AISHIBA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

