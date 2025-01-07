module 0x756d9bbee323a017122904056a31d6c0d7ed31393b8d0da86e7686a9d9ee6ac6::npz {
    struct NPZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: NPZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NPZ>(arg0, 6, b"NPZ", b"NewProjectZone", x"506c61636520776865726520796f752063616e2066696e64206e65772070726f6a6563747320636f6d696e672075702e204d6f737420696e666f726d6174696f6e20636f6d652066726f6d204b4f4c7320616e64205643732e20426520666972737420746f2066696e64206f75742061626f7574207468656d2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/NPZ_TK_Bi_S9_U_Fa3_Ol5_B8c51_b6f4805aee.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NPZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NPZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

