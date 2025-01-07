module 0xd6091f2bb87f8f6703405149fb510a69bd65f151dd6f919698900467afeacd40::suiiiii {
    struct SUIIIII has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIIIII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIIIII>(arg0, 6, b"SUIIIII", b"Here pig", x"546861742064616d6e20706967212043276d657265212043276d6f6e206e6f772120576f6f6f20706967205375757575696949494949210a0a0a2057696c6c206c61756e636820747769747465722c20616e64206576656e7475616c6c792077656273697465206f6e6365207765206869742074686520626f6e64696e672063757276652e2020436f6d6d756e6974792070726f6a6563742e202049206f6e6c7920686176652032352053554920696e746f20746869732e20204966204920646f6e27742063617463682074686973207069672c206d79207769666520697320676f696e6620746f206b696c6c206d652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000050409_6079a59a6e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIIIII>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIIIII>>(v1);
    }

    // decompiled from Move bytecode v6
}

