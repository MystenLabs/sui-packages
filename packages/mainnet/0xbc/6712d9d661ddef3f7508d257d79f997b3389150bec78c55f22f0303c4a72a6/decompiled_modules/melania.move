module 0xbc6712d9d661ddef3f7508d257d79f997b3389150bec78c55f22f0303c4a72a6::melania {
    struct MELANIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MELANIA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MELANIA>(arg0, 6, b"MELANIA", b"MELANIA TRUMP by SuiAI", b"The Official Melania Meme is live on SUI!..You can buy $MELANIA now.  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Ghr1e_Is_Xo_A_Ehk_Sx_02e42a39c6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MELANIA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MELANIA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

