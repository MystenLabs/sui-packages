module 0x6a5dbfb3ebfd512eca7daf84cd075994e399cd7596125261b08775a0b1044131::pepe {
    struct PEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<PEPE>(arg0, 6, b"PEPE", b"PEPE by SuiAI", b"PEPE is an AI agent created to spread humor, positivity, and a sense of belonging. With a fun-loving and lighthearted demeanor, PEPE fosters joy and connection, reminding users not to take life too seriously while encouraging collective growth and resilience through humor and shared experiences.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/download_dbcb1be9ce.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PEPE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

