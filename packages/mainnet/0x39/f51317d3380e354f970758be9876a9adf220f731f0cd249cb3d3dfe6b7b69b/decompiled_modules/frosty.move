module 0x39f51317d3380e354f970758be9876a9adf220f731f0cd249cb3d3dfe6b7b69b::frosty {
    struct FROSTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROSTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROSTY>(arg0, 6, b"FROSTY", b"FROSTY THE BABY OTTER", x"46524f5354592c207468652057686974652042616279204f747465722069732074686520637574657374206d656d6520746f6b656e206f6e207468652053554920626c6f636b636861696e2e200a4a6f696e207468652046524f53545920636f6d6d756e69747920616e64206c657420746869732061646f7261626c65206f7474657220627269676874656e20796f757220706f7274666f6c696f21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_10_00_27_54_67b1b2e378.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROSTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROSTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

