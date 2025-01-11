module 0x3a4759f49910b21f058b565374e0d33b7c2e6719bba460a044a95ea0f74f1909::kolwaii {
    struct KOLWAII has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOLWAII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOLWAII>(arg0, 6, b"Kolwaii", b"kolwaii SUI", b"kolwaii SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/f880847a_e0ea_4aba_90ab_3cbab51672e4_c75de1e6e6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOLWAII>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOLWAII>>(v1);
    }

    // decompiled from Move bytecode v6
}

