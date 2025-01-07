module 0xd716bd28211c0fe6c3d821cd3dfce16783f492394d6be6ba3866a84ef12a4d74::longmao {
    struct LONGMAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LONGMAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LONGMAO>(arg0, 6, b"Longmao", b"Lmao", x"2a2a2a204c4f4e47204d414f3a204120535549206d656d6520746f6b656e20626c656e64696e6720506570657320636861726d20776974682061206361747320656c6567616e63652c206b6e6f776e20666f7220697473206c6f6e67657374206e65636b20696e2063727970746f21202a2a2a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ena_TX_Ya_AB_5_Fzb7_Ai_Dx_Au_DW_8g_Gxzc34o_R7_QF_Dd1_Cas_UDC_99ebefd5d3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LONGMAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LONGMAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

