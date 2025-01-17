module 0xeb88da6028db46b9265026fc44dea29386911ef1f22dc3f54209199afa389c42::revox {
    struct REVOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: REVOX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<REVOX>(arg0, 6, b"REVOX", b"REVOX AI by SuiAI", b"REVOX AI DPrompt uses advanced on-chain AI models to generate time-sensitive answers in smart contracts.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/k_U1r_Xhm5_400x400_a6577372be.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<REVOX>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REVOX>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

