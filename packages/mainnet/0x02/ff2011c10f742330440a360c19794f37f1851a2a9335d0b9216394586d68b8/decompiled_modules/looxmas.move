module 0x2ff2011c10f742330440a360c19794f37f1851a2a9335d0b9216394586d68b8::looxmas {
    struct LOOXMAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOOXMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOOXMAS>(arg0, 6, b"lOOxMAS", b"100x for Christmas", b"Were on a mission to spread joy this season by turning everyones Christmas into a financial celebration! This coin is designed to be the best gift under the tree for all investors looking for massive potential.  LETS 100X together", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Xxoj_ASZCL_Bwuod8jhu_AXDHQDM_37o_C28_Fz_Z1s_R9_J_Znb6_J_2018f660aa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOOXMAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOOXMAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

