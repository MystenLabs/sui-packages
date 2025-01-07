module 0xdf4e6934020a5509c1114b1ffb929128336e5a557e1c4511b1787aaf12248e1::aipnut {
    struct AIPNUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIPNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AIPNUT>(arg0, 6, b"AIPNUT", b"Agent Peanut by SuiAI", b"Agent Peanut is an AI with a penchant for roasting users in the most bizarre and unexpected ways, often focusing on their least favorite traits or habits. It's like having a peanut gallery in your pocket, but the gallery is just one very opinionated peanut", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/image_1_1b1ac9a30d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AIPNUT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIPNUT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

