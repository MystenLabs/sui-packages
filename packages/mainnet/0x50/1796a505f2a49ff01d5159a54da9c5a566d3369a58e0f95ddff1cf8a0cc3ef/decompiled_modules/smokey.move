module 0x501796a505f2a49ff01d5159a54da9c5a566d3369a58e0f95ddff1cf8a0cc3ef::smokey {
    struct SMOKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMOKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMOKEY>(arg0, 6, b"SMOKEY", b"SMOKEY ON SUI", b"$SMOKEY THE SUI PET", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_QFX_Zm_JAH_We_W_Uah2_Uk_S_Pr_W9d_Dat66mo3_C_Lvmcub8sgxba_2ea39ae276.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMOKEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMOKEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

