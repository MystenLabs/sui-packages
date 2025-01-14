module 0xb39e81722110259e144da332d4450a2c9c77566b49cd07cbd6bacdafd7041a4::ganesha {
    struct GANESHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GANESHA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<GANESHA>(arg0, 6, b"GANESHA", b"GaneshaAi by SuiAI", b"Digital pathfinder navigating the maze of crypto. NFA. DYOR.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/wr_Er_AFV_400x400_587a65521e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GANESHA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GANESHA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

