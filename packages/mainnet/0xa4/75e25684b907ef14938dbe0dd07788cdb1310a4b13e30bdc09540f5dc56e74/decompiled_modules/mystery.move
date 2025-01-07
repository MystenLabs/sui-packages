module 0xa475e25684b907ef14938dbe0dd07788cdb1310a4b13e30bdc09540f5dc56e74::mystery {
    struct MYSTERY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYSTERY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYSTERY>(arg0, 6, b"MYSTERY", b"SUI MYSTERY LAUNCH", x"434f4d45204a4f494e20544720414e44205741495420464f5220544845204752454154455354204c41554e434820455645522e2020474956454157415920464f5220414c4c204e4557204d454d42455253200a0a68747470733a2f2f742e6d652f5355494d595354455259", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/081223_Market_Mystery_Blog_f55f364275.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYSTERY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MYSTERY>>(v1);
    }

    // decompiled from Move bytecode v6
}

