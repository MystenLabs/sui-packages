module 0xbbbbae6fa882addb75c36f0e3e62e2fe45052e67fa7e681994d6925cc4c34515::ymach {
    struct YMACH has drop {
        dummy_field: bool,
    }

    fun init(arg0: YMACH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<YMACH>(arg0, 6, b"YMACH", b"0xYmach by SuiAI", b"Your DeFi AI advisor. Bold insights, smart yield strategies, and memecoin calls. Automate your crypto portfolio & grow wealth effortlessly ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/asd_714f4b7582.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<YMACH>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YMACH>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

