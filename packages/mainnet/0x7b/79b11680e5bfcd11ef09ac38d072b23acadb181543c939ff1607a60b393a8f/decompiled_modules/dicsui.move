module 0x7b79b11680e5bfcd11ef09ac38d072b23acadb181543c939ff1607a60b393a8f::dicsui {
    struct DICSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DICSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DICSUI>(arg0, 6, b"DicSui", b"Dick Butt On Sui", b"Dickbutt has officially arrived on Sui blockchain! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ge37gx_C_Xs_A_Aqsv_K_e287d93110.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DICSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DICSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

