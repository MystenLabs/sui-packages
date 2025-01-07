module 0xa4eceba982fd51a19ccbd728344381484ae680b6ed83ea007673e4b2f72bd54b::meowmoney {
    struct MEOWMONEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOWMONEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEOWMONEY>(arg0, 6, b"MeowMoney", b"Meow Money Bridge", b"The Paw-fect Pathway to Keep Your Financial Whiskers Hidden", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sin_t_A_12323asdasdtulo_1_087c2d7090.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOWMONEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEOWMONEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

