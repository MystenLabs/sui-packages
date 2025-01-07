module 0xa78b9e7e93c9018a40816ea9e6ce4d60175bd724ad0ee7a3d47df629b0d5c50f::sildenafil {
    struct SILDENAFIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SILDENAFIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SILDENAFIL>(arg0, 6, b"Sildenafil", b"viagra", b"Take this to get hard for Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qme_Ymh_Xsji3d35_PQ_2ot_En_NWK_7_CBN_Nhzyt_W_Pu7e_Q521_W3_Dq_ecf9cf7e69.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SILDENAFIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SILDENAFIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

