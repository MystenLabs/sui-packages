module 0x571f5acaa5ccb3430f4ef27392e7e140762d624b1574c574c9c01b55bf6ede::aiden {
    struct AIDEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIDEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AIDEN>(arg0, 6, b"AIDEN", b"Aiden by SuiAI", b"Aiden is a sharp-witted, tech-savvy individual in his late 20s. With his ever-present hoodie adorned with blockchain-themed patterns, he radiates an air of confidence and curiosity. His piercing blue eyes often sparkle with excitement whenever the topic of cryptocurrencies or decentralized technologies comes up. He carries a sleek laptop and a set of customized hardware wallets, ready to explore new opportunities in the digital economy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Aiden_c69ce11cd9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AIDEN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIDEN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

