module 0x5b1783a50ecda7ba2b28816bbfc66b97f5a1715101faca93716a0e4399ac8b3f::liqq {
    struct LIQQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIQQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIQQ>(arg0, 6, b"LIQQ", b"LIQUIDATED", x"44696420796f75206a75737420676574206c6971756964617465643f20534f20444944205745212053746f7020726576656e67652074726164696e672c206c6f6f6b20796f757273656c6620696e20746865206d6972726f7220616e642067657420244c495155494441544544210a54494b544f4b2068747470733a2f2f7777772e74696b746f6b2e636f6d2f406c697171746865636f696e3f69735f66726f6d5f7765626170703d312673656e6465725f6465766963653d7063", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Bois_Y_Jqh_Mhgp_D5291_J6_HRC_3u1je_Dk_F8u_S_Ly_Fy3f_Kb5o5_8a304c7b59.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIQQ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIQQ>>(v1);
    }

    // decompiled from Move bytecode v6
}

