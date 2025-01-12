module 0x775370fe583753c7c6e8403dc258710f304af97c2b7aa3e513ef4cc78a24de1e::suilez {
    struct SUILEZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILEZ, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUILEZ>(arg0, 6, b"SUILEZ", b"Sui1Ez AI by SuiAI", b"SUI network's first anime-based AI project.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/LHQ_Hmwy7_400x400_c1616c6ad9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUILEZ>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILEZ>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

