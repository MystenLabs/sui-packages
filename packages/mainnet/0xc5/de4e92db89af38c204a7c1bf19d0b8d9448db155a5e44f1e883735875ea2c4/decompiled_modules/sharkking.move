module 0xc5de4e92db89af38c204a7c1bf19d0b8d9448db155a5e44f1e883735875ea2c4::sharkking {
    struct SHARKKING has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARKKING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHARKKING>(arg0, 6, b"SharkKing", b"Shark king", x"24536861726b204b696e67206f6e2024537569204c697665206f6e204d6f766550756d7020537461727420536861726b2074696d65736861726b20697320746865206b696e67206f6620746865207365610a4f6666696369616c2067726f757068747470733a2f2f742e6d652f537569536861726b436f696e20200a537461727420536861726b2074696d65", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Image_1729436810117_1e76b0ebdf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHARKKING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHARKKING>>(v1);
    }

    // decompiled from Move bytecode v6
}

