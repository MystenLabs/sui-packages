module 0xe5da7193d9852b4313f34a9207e27fa6c10eadee407436aafeaeb5072a89ed71::mds {
    struct MDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MDS>(arg0, 6, b"MDS", b"MEDUSA", b"10000000000", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Fosp9yo_XQ_Bdx8_Yqy_UR_Ze_P_Yzgp_Cnxp9_Xsfn_Qq69_D_Rvv_U4_d0f86de0c3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

