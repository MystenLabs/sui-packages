module 0xce54e07d2e6caf4288cc516aec3511c19f8757eb30740f0e2aeeb5075279253d::deep {
    struct DEEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEEP>(arg0, 6, b"DEEP", b"DeepBook Protocol on Sui", x"546865207072656d69657220646563656e7472616c697a6564206c6971756964697479206c6179657220666f72206275696c646572732c20747261646572732c20616e64207468652062726f61646572204465466920636f6d6d756e6974792c206578636c75736976656c79206f6e200a405375694e6574776f726b0a2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/deepbook_6663d5386b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEEP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEEP>>(v1);
    }

    // decompiled from Move bytecode v6
}

