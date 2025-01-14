module 0xe1966779853b1da402bfb4050569f7e6e99756f7a5eb4c985fafc6c3bfd724da::zorix {
    struct ZORIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZORIX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ZORIX>(arg0, 6, b"ZORIX", b"ZORIX AI by SuiAI", b"Meet ZORIX, next AI Agent on SUI, wallet tracker and trading BOT AI, scanning more fast and better transactions specially sui network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/small_logo_d378a6ba1e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ZORIX>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZORIX>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

