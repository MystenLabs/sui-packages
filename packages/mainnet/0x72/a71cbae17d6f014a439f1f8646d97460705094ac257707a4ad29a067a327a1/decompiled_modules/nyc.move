module 0x72a71cbae17d6f014a439f1f8646d97460705094ac257707a4ad29a067a327a1::nyc {
    struct NYC has drop {
        dummy_field: bool,
    }

    fun init(arg0: NYC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NYC>(arg0, 6, b"NYC", b"Nyan cat", b"One of World's most famous cats, Nyan cat.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Rkus7mdew8_Bj_Ni_P_Cdx_V_Luzt_N4e2_Mr_GG_4p_WLG_7_Kq_Shj_KB_8d642aa252.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NYC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NYC>>(v1);
    }

    // decompiled from Move bytecode v6
}

