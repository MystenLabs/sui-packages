module 0x59524fe5cc4bcd2b856ab0ef893242d933d5c118f4a39ac2c84ca694abce23ad::melaniasui {
    struct MELANIASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MELANIASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MELANIASUI>(arg0, 6, b"MELANIASUI", b"MELANIA TRUMP ON $SUI by SuiAI", b"The REAL Melania Trump on $SUI. Ran by the SUI community! Other project got jeeted. Where are the TRUMP/MELANIA SUPPORTS?? Let's go brandon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Ghr1e_Is_Xo_A_Ehk_Sx_855eb598f5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MELANIASUI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MELANIASUI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

