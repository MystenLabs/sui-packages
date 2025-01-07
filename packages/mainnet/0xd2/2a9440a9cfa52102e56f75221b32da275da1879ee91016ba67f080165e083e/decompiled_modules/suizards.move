module 0xd22a9440a9cfa52102e56f75221b32da275da1879ee91016ba67f080165e083e::suizards {
    struct SUIZARDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIZARDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIZARDS>(arg0, 6, b"SUIZARDS", b"SUI WIZARDS", b"The magic begins.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/n5kkjkyz_N31i4_NRD_Mjc_K_Cyb_V_Qc_c04cabe5ca.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIZARDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIZARDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

