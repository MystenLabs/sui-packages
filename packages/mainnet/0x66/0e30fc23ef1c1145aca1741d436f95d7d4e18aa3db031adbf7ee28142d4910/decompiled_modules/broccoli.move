module 0x660e30fc23ef1c1145aca1741d436f95d7d4e18aa3db031adbf7ee28142d4910::broccoli {
    struct BROCCOLI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BROCCOLI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BROCCOLI>(arg0, 6, b"BROCCOLI", b"Broccoli by SuiAI", b"A CZ's Dog story", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Gjrh_Qy_R_Xo_A_Ao_SUX_8195b1e6d9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BROCCOLI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BROCCOLI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

