module 0xce946e7d8060df083514df4a85bd7de43caf1f4c32d9f1b39abf2f2bab492e2c::dogeai {
    struct DOGEAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGEAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DOGEAI>(arg0, 6, b"DOGEAI", b"DogeAI by SuiAI", b"This is doge AI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/467839329_1597818071124708_1546149961532795658_n_1_0c7841889c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOGEAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGEAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

