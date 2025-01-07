module 0xb3b2e0e15e14b5f93e7d6c4da1c6c695f533635df94fdc79bf860798fe5841de::suirvey {
    struct SUIRVEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRVEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRVEY>(arg0, 6, b"SUIRVEY", b"Sui Survey", x"0a546865206f6e6c7920706f6c6c2074686174206d6174746572732e20546865207265616c206465636973696f6e206d616b657273206172652074686520646567656e732e20596f757220766f74652c20796f7572206d656d652c20796f75722063686f69636521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ukbsanur_R62_BJ_7o_V_Lfm_WYA_a0ffd218df.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRVEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRVEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

