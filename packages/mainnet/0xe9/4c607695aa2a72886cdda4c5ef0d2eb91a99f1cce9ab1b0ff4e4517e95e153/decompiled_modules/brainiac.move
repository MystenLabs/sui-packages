module 0xe94c607695aa2a72886cdda4c5ef0d2eb91a99f1cce9ab1b0ff4e4517e95e153::brainiac {
    struct BRAINIAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRAINIAC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BRAINIAC>(arg0, 6, b"BRAINIAC", b"BRAINIAC AI by SuiAI", b"YOUR SMART PROGRAMMING ASSISTANT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/4_Z_Xuo3n_P_400x400_2404bdc8fa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BRAINIAC>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRAINIAC>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

