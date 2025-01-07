module 0xade406d84a8c52737f7c927826159b1a5f1f5d558557ad8df2ccddd4bf7f9a52::srabbit {
    struct SRABBIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRABBIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRABBIT>(arg0, 6, b"SRABBIT", b"HOPPY RABBIT", x"484f5050592049532052414242495420444547454e0a0a24484f5050590a0a4e657720583a2068747470733a2f2f782e636f6d2f486f7070794f6e5375695f580a54656c653a20742e6d652f486f7070796f6e7375690a576562736974653a20436f6d696e6720736f6f6e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/99210_FD_5_5_A84_4633_B1_A2_9_BC_0_C557961_E_da7d747e4f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRABBIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SRABBIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

