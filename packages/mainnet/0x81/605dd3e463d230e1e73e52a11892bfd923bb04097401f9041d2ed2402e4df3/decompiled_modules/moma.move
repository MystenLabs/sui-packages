module 0x81605dd3e463d230e1e73e52a11892bfd923bb04097401f9041d2ed2402e4df3::moma {
    struct MOMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOMA>(arg0, 6, b"MoMa", b"Money Maker", b"Money Maker!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/AEB_6_B914_604_A_4_BF_7_867_B_EC_0986260_C10_4110f35c26.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

