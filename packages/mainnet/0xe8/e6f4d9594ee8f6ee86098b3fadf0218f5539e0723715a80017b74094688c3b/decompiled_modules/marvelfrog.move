module 0xe8e6f4d9594ee8f6ee86098b3fadf0218f5539e0723715a80017b74094688c3b::marvelfrog {
    struct MARVELFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARVELFROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARVELFROG>(arg0, 6, b"MarvelFrog", b"Crazyfroh", b"No twitter no tg just a token niggas", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/918642_EC_5_B7_F_47_C7_937_C_30_FD_1_D7_CD_18_D_bcd0d2c719.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARVELFROG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARVELFROG>>(v1);
    }

    // decompiled from Move bytecode v6
}

