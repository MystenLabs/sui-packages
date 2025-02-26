module 0x5f3c06ac9ff55392b205683870982a2b642a22307b065b96b874a4148dee973a::bubo {
    struct BUBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BUBO>(arg0, 6, b"BUBO", b"Bubbo by SuiAI", b"Crypto Bubbles map on SUI Network, track real-time token prices and market trends on the Sui Network with our interactive bubble map.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/avatar_604493a02b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BUBO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

