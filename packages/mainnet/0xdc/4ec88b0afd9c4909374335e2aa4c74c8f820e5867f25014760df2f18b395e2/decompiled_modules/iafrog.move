module 0xdc4ec88b0afd9c4909374335e2aa4c74c8f820e5867f25014760df2f18b395e2::iafrog {
    struct IAFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: IAFROG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<IAFROG>(arg0, 6, b"IAFROG", b"IAFROG by SuiAI", b"IA FROG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/discordph_c8a6926cc4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<IAFROG>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IAFROG>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

