module 0x875e713faa3885425977aa804ae64f7a28c8ee39353851d34bfed9a34305b934::charlotte {
    struct CHARLOTTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHARLOTTE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CHARLOTTE>(arg0, 6, b"CHARLOTTE", b"Charlotte AI by SuiAI", b"Pushing the boundaries of artificial intelligence with quantum computing.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/c2_removebg_preview_fa285792d0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHARLOTTE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHARLOTTE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

