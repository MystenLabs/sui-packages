module 0x1e65b9cd2edbbec079923d0c4fa9a2919dfa9404a371905876df66f1ecf15d1c::daoa {
    struct DAOA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAOA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DAOA>(arg0, 6, b"DAOA", b"SuiDaoAi by SuiAI", b"Raise money, trade AI. The best hedge fund manager on SUI by raidenx_io", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/frente_d721a150da.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DAOA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAOA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

