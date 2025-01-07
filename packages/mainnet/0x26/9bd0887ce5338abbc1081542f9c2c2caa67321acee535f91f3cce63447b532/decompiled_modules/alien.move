module 0x269bd0887ce5338abbc1081542f9c2c2caa67321acee535f91f3cce63447b532::alien {
    struct ALIEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALIEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALIEN>(arg0, 6, b"ALIEN", b"SUI ALIEN", b"Your Gateway to the Future of Wealth!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/file_W_Vn_Uqg_Ovgz_EZBFH_14lz9u_Kwb_dae4230c59_eaf40caf01.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALIEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALIEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

