module 0x14ac5fa405c58618c9ebc4e5706bb68931fb98987904ca319811dbceee56f691::svine {
    struct SVINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SVINE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SVINE>(arg0, 6, b"SVINE", b"SUI VINE by SuiAI", b"SUI VINE ($sVINE) is a community-driven meme coin on the Sui Network, bringing humor, entertainment, and rewards to its holders.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/vine_973311c711.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SVINE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SVINE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

