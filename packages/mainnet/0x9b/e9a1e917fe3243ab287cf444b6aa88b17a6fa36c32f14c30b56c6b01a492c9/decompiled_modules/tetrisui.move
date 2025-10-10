module 0x9be9a1e917fe3243ab287cf444b6aa88b17a6fa36c32f14c30b56c6b01a492c9::tetrisui {
    struct TETRISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TETRISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TETRISUI>(arg0, 6, b"TETRISUI", b"TETRIS", b"Join In Tetris", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1759503151_2165298_4_B67_CB_9_A_4_F5_D_4_F92_9_BB_5_EB_3_D05729_FCD_6f9cd64da9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TETRISUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TETRISUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

