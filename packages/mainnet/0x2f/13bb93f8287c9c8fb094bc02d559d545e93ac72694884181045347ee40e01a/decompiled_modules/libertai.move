module 0x2f13bb93f8287c9c8fb094bc02d559d545e93ac72694884181045347ee40e01a::libertai {
    struct LIBERTAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIBERTAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<LIBERTAI>(arg0, 6, b"LIBERTAI", b"LibertAi by SuiAI", b"Confidential AI for blockchain apps. Powered by $LTAI.. Unlock AI privacy today.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/W_Ti_S_JU_400x400_48b7d7656b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LIBERTAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIBERTAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

