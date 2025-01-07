module 0x1712107c97f85908b58365bd266a4875785a58668ca972b9ee9b30f214836026::pugwif {
    struct PUGWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUGWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUGWIF>(arg0, 6, b"PUGWIF", b"Pugwifsui", b"The Pug that doesn't quit.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/K15_Yulj_H_400x400_83c0c68adc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUGWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUGWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

