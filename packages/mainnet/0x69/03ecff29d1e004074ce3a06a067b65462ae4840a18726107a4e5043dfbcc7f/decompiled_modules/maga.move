module 0x6903ecff29d1e004074ce3a06a067b65462ae4840a18726107a4e5043dfbcc7f::maga {
    struct MAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGA>(arg0, 6, b"MAGA", b"SuiMAGA", x"54686520666972737420204d414741205472756d70206f6e20537569206e6574776f726b0a426f726e20746f206d616b65206d656d65636f696e20677265617420616761696e20616e64206272696e6720796f752066696e616e6369616c2066726565646f6d21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_03_06_22_48_38b2f174d7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

