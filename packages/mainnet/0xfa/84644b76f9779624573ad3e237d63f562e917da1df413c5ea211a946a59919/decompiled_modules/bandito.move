module 0xfa84644b76f9779624573ad3e237d63f562e917da1df413c5ea211a946a59919::bandito {
    struct BANDITO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BANDITO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BANDITO>(arg0, 6, b"BANDITO", b"The Banditos", b"EL BANDITO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/AFTBGK_79_Yytfmvn_QS_Ua26svc5aofm_Jt_Tb_Wrrg9b4pump_16c3f09b87.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BANDITO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BANDITO>>(v1);
    }

    // decompiled from Move bytecode v6
}

