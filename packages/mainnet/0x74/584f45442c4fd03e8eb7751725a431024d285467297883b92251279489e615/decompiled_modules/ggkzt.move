module 0x74584f45442c4fd03e8eb7751725a431024d285467297883b92251279489e615::ggkzt {
    struct GGKZT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GGKZT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<GGKZT>(arg0, 6, b"GGKZT", b"coreykooo by SuiAI", b"ha", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/9464a1aa6effe666c1864fe8149e2114_e65d51a127.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GGKZT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GGKZT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

