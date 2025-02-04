module 0x34e0036e2b9cdf5172428cb96eb34108b263b8de3510e0bd4d567c6158eaff3d::arthur {
    struct ARTHUR has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARTHUR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARTHUR>(arg0, 6, b"ARTHUR", b"Suir Arthur", x"496e20746865207265616c6d206f662043727970746f6e69612c206461726b20666f72636573206f6620696e666c6174696f6e20616e642063656e7472616c697a6174696f6e20726569676e2e200a42757420612062726f74686572686f6f64206f66206272617665206b6e69676874732068617320666f7267656420244152544855522020746865206d656d6520636f696e206f66206a75737469636520616e642076616c6f7221200a52616c6c7920746f207468652063617573652e2e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ICONODELACOINACABADO_ezgif_com_resize_ab75f4f343.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARTHUR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARTHUR>>(v1);
    }

    // decompiled from Move bytecode v6
}

