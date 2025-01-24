module 0x5ba558d35351e8aab9e63b65314b73141d128bd95984016443a375a8b048432a::wgsb {
    struct WGSB has drop {
        dummy_field: bool,
    }

    fun init(arg0: WGSB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<WGSB>(arg0, 6, b"WGSB", b"weigeshabi by SuiAI", b"Crazy  SB, go fk himself.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/weigeshabi_5f7cbc90d9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WGSB>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WGSB>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

