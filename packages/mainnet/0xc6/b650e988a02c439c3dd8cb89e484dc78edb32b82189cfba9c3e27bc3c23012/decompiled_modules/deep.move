module 0xc6b650e988a02c439c3dd8cb89e484dc78edb32b82189cfba9c3e27bc3c23012::deep {
    struct DEEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEEP>(arg0, 6, b"DEEP", b"DeepBook Meme on Sui", x"546865207072656d69657220646563656e7472616c697a6564206c6971756964697479206c61796572206d656d6520666f7220646567656e732c20747261646572732c20616e64207468652062726f61646572204465466920636f6d6d756e6974792c206578636c75736976656c79206f6e20537569204e6574776f726b0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ads_Ae_z_tasar_Ae_m_1_18d8419115.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEEP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEEP>>(v1);
    }

    // decompiled from Move bytecode v6
}

