module 0xd8c6bdb7c44e253fa19bae2fe94031a6ecb61d20b4c9db4a2c0549067a5c9739::airtist {
    struct AIRTIST has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIRTIST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AIRTIST>(arg0, 6, b"AIRTIST", b"THE AIRTIST by SuiAI", b"The Airtist emerged as a revolutionary AI robot with an extraordinary talent for art.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/airtist_ee7ca7ce4b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AIRTIST>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIRTIST>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

