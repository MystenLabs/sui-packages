module 0x79c651f4c8d89e7c9017ba49da7a0aea7b95dda74e4fdeb48488febba142bfa4::unity2cube {
    struct UNITY2CUBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNITY2CUBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNITY2CUBE>(arg0, 6, b"Unity2Cube", b"Shaws Unity Cube", x"53686177732066697273742047697448756220636f6d6d697420392079656172732061676f2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmb_N_Bg_XG_4eit_Z2hr_Ew_Ebqk_Dhtdz9a_Bjc_Hr_XE_Raai_RGL_Ab_C_3bafb2de40.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNITY2CUBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UNITY2CUBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

