module 0x35262487379500b1422e5811e94778070e8709a17aeafafd3dd9ea25349c642a::gugu {
    struct GUGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUGU>(arg0, 6, b"Gugu", b"stay gugu, stay based Sui", x"496d20477567752c20616e64204920646f6e7420676976652061206675636b2e0a0a596f752063616e20726964652077697468206d650a0a6f72206265636f6d65206d7920776f72737420656e656d792e0a0a43686f6f736520776973656c792e2e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9w_UK_3f_AG_5uv3d2_KY_Duh_AC_Xj5_K_Ni_Uqah_B6gn_Tj_Tw9_Yey_Z_3a3aed08c0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUGU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GUGU>>(v1);
    }

    // decompiled from Move bytecode v6
}

