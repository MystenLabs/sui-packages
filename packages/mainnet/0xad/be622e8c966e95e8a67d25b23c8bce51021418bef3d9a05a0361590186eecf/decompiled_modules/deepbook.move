module 0xadbe622e8c966e95e8a67d25b23c8bce51021418bef3d9a05a0361590186eecf::deepbook {
    struct DEEPBOOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEEPBOOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEEPBOOK>(arg0, 6, b"DeepBook", b"Deep Book", x"546865207072656d69657220646563656e7472616c697a6564206c6971756964697479206c6179657220666f72206275696c646572732c20747261646572732c20616e64207468652062726f61646572204465466920636f6d6d756e6974792c206578636c75736976656c79206f6e205375694e6574776f726b0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qa_H_TJY_400x400_7988a931d8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEEPBOOK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEEPBOOK>>(v1);
    }

    // decompiled from Move bytecode v6
}

