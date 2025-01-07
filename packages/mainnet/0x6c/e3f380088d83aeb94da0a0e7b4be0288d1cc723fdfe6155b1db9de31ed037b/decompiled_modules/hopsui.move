module 0x6ce3f380088d83aeb94da0a0e7b4be0288d1cc723fdfe6155b1db9de31ed037b::hopsui {
    struct HOPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPSUI>(arg0, 6, b"HopSui", b"Hop Sui", x"486f702073756920697320746865206f6666696369616c2066616365206f66207468652053756920636861696e2c206272696e67696e67206368617269736d6120616e64207374796c6520746f207468650a626c6f636b636861696e20776f726c642e20416c7761797320726561647920666f7220616476656e747572652c20486f7020737569206973206865726520746f20677569646520796f750a7468726f7567682074686520657665722d65766f6c76696e67206a6f75726e6579206f6620746865205375692065636f73797374656d21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sin_t_A_tul2asdasdasd13123213o_1_85cbfff9ce.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

