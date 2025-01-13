module 0x53ee703062572c665ae8c738e250b97130be64d6e2dba4c7f875059f33a1efe8::cheva {
    struct CHEVA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEVA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CHEVA>(arg0, 6, b"CHEVA", b"Chevalanier sui by SuiAI", b"Chavelainer: The AI of Elegance and Innovation.Chavelainer is not just an AI agent; it's a symbol of refinement and cutting-edge intelligence. Designed with sophistication and boldness in mind, Chavelainer is your trusted ally in navigating the complexities of modern challenges. Whether you're crafting strategies,", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/cheva_6ca0f613a9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHEVA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEVA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

