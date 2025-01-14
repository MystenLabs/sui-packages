module 0x7c1c95970c5e2b800f4eb689cbb83a1d76ebec911d3ffc3598052dbe3156f10e::sauceai {
    struct SAUCEAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAUCEAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SAUCEAI>(arg0, 6, b"SAUCEAI", b"SuiSauceAi by SuiAI", b"Sui $Sauce is capturing the palate of the entire space.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/s_M_Rbcz_DE_400x400_e611f4c85d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SAUCEAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAUCEAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

