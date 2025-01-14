module 0x7129fbef051f160a928de5cb8769381e775814812038880dda788d15f942311c::fatbuilder {
    struct FATBUILDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: FATBUILDER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<FATBUILDER>(arg0, 6, b"FATBUILDER", b"Fat Builder by SuiAI", b"Fat Builder the Al agent that will help you to build onchain. The agent will help to provide information about web developing, web design, tools, and market interest!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/002b21da_33e2_410d_964e_b58cfe012878_a72289afdf.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FATBUILDER>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FATBUILDER>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

