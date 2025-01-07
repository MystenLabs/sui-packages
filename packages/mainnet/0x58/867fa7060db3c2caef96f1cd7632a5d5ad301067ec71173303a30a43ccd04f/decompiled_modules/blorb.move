module 0x58867fa7060db3c2caef96f1cd7632a5d5ad301067ec71173303a30a43ccd04f::blorb {
    struct BLORB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLORB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLORB>(arg0, 6, b"BLORB", b"I am BLORB", b"My ugliness is not synonym of weakness. Blobo is here to make memecoins great again. Launched zero taxes, LP BURNT, $BLOBO is a coin for the people, forever. Fueled by pure memetic power, let $BLOBO show you the way.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Pesg17y_Yc_R1t_Fo_L9_S3_F5cz_J7nwa4sb_Pt8c_GV_5_TZDK_Gfs_7f854c1479.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLORB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLORB>>(v1);
    }

    // decompiled from Move bytecode v6
}

