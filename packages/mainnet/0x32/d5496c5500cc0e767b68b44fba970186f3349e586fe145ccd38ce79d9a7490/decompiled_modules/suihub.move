module 0x32d5496c5500cc0e767b68b44fba970186f3349e586fe145ccd38ce79d9a7490::suihub {
    struct SUIHUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIHUB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUIHUB>(arg0, 6, b"SUIHUB", b"SUI HUB by SuiAI", b"#SUIHUB is the first concept of adult photography in the form of NFTs on the #SUI blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/suihub1_4379ea6e7e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIHUB>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIHUB>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

