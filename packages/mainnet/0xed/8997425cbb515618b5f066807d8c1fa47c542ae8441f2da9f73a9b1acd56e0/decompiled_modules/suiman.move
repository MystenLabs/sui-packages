module 0xed8997425cbb515618b5f066807d8c1fa47c542ae8441f2da9f73a9b1acd56e0::suiman {
    struct SUIMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SUIMAN>(arg0, 6, b"SMAN", b"Suiman", b"Suiman", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/N_N_D_D_N_D_N_D_d1b423d435.png")), false, arg1);
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMAN>>(v0, v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SUIMAN>>(v1, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMAN>>(v2);
    }

    // decompiled from Move bytecode v6
}

