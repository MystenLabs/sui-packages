module 0x832300d3ac1ef3df3afa2eefbdd78a80c2bbf5583624891a6960243b1e6f8496::aai {
    struct AAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AAI>(arg0, 6, b"AAI", b"AiOnSui  by SuiAI", b"iOnSui is Your All-in-One Crypto Companion! Elevate your crypto experience with cutting-edge technology, seamless management, and strategic insights.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/aion_ca629deaa8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

