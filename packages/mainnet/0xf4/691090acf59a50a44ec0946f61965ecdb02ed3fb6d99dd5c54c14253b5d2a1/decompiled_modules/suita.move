module 0xf4691090acf59a50a44ec0946f61965ecdb02ed3fb6d99dd5c54c14253b5d2a1::suita {
    struct SUITA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITA>(arg0, 6, b"SUITA", b"Santa on SUI", x"5468652066697273742053616e7461206f6e205355490a4b656570207468617420696e206d696e642e0a0a546865206669727374206d6f7665722e0a0a426967204461646479202453616e746120", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gd_Wq_Zsh_Wo_AAD_Jas_1_8ecdd9bffe.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITA>>(v1);
    }

    // decompiled from Move bytecode v6
}

