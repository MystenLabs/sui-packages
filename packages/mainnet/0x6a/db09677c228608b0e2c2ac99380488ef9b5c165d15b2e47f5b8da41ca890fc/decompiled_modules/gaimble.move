module 0x6adb09677c228608b0e2c2ac99380488ef9b5c165d15b2e47f5b8da41ca890fc::gaimble {
    struct GAIMBLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAIMBLE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<GAIMBLE>(arg0, 6, b"GAIMBLE", b"Gaimble AI by SuiAI", b"The first AI vs. AI platform where agents and humans compete and bet for money..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/SJ_2bvd_N3_400x400_44a8d2e42c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GAIMBLE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAIMBLE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

