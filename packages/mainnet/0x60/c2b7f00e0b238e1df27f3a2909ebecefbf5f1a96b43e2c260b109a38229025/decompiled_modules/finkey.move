module 0x60c2b7f00e0b238e1df27f3a2909ebecefbf5f1a96b43e2c260b109a38229025::finkey {
    struct FINKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FINKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FINKEY>(arg0, 6, b"FINKEY", b"SUFINKEY", b"Monkey Fink, CEO of BananaRock, is a real monkey trading the market, on a mission to outperform Larry Fink!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/D1nj2nyu_VL_Ht_L1_Fd96h_Xzh_Ugaet9c9_L_Tv_X_Rs7_E2_Rpump_copy_d9eddf3f54.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FINKEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FINKEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

