module 0xca9cd41e15a8dc052612871088edf66cee715e671d49c0adddf944400e002c71::quant {
    struct QUANT has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUANT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUANT>(arg0, 6, b"Quant", b"Gen Z Quant", b"A Viral Kid", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_QM_2jhqy_G689v2f_C1_Het1p1f_JVB_Mp_S_Dn_Mkq4tvnc_Yfyi_V_042d49d04f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUANT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QUANT>>(v1);
    }

    // decompiled from Move bytecode v6
}

