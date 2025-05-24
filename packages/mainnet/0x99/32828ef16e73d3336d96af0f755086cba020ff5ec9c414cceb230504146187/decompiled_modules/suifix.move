module 0x9932828ef16e73d3336d96af0f755086cba020ff5ec9c414cceb230504146187::suifix {
    struct SUIFIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFIX>(arg0, 6, b"SUIFIX", b"SuiFix", b"SUI will be fixed and become higher", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000073481_88a6bd3ec9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFIX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFIX>>(v1);
    }

    // decompiled from Move bytecode v6
}

