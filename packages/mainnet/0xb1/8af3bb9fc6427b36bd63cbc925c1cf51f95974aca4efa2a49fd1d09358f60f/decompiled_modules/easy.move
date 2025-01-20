module 0xb18af3bb9fc6427b36bd63cbc925c1cf51f95974aca4efa2a49fd1d09358f60f::easy {
    struct EASY has drop {
        dummy_field: bool,
    }

    fun init(arg0: EASY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<EASY>(arg0, 6, b"EASY", b"CoinEasy AI agent by SuiAI", b"CoinEasy AI agent is a dynamic and user-friendly Al bot designed to guide X users into the world of the Bitcoin. With CoinEasy AI agent approachable personality and deep understanding of blockchain nuances, Lucy makes the transition from Social media to blockchain technology both exciting and accessible.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/UT_8v_Y_Xr_400x400_28cde44627.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EASY>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EASY>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

