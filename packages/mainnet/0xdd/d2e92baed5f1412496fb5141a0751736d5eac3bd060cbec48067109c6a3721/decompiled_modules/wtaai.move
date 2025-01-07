module 0xddd2e92baed5f1412496fb5141a0751736d5eac3bd060cbec48067109c6a3721::wtaai {
    struct WTAAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WTAAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WTAAI>(arg0, 6, b"WTAAI", b"Wallet Tracker AI", b"Track and Analyze Wallets with AI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5246_A0_B6_F438_4_A17_B2_C4_D1_AB_260_BA_409_0db7daf659.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WTAAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WTAAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

