module 0xbcd73eed4b679799c6ae7e386586d24036799906b43ae6cb4551a5a1c6cf3d9f::wisecoin {
    struct WISECOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WISECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WISECOIN>(arg0, 6, b"WiseCoin", b"WiseCoin on sui", b"Always learn and update your knowledge about the cryptocurrency market.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_1_72de275227.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WISECOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WISECOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

