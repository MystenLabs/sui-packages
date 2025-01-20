module 0x12f0da79164da5d180073975c7062496024a21bc44dd047e95ed7d25ad0a9315::melania {
    struct MELANIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MELANIA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MELANIA>(arg0, 6, b"MELANIA", b"Melania Meme by SuiAI", b"The only OFFICIAL Melania On SUI by SUIAI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Ghr9u6_WQAE_Gi_SJ_d564d908e9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MELANIA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MELANIA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

