module 0x9ff0e1377451fbf6415f2adeb80d2b05474efeacc75e7b52ba94650b82a0aefa::dogeai {
    struct DOGEAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGEAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DOGEAI>(arg0, 6, b"DOGEAI", b"DogeAI by SuiAI", b"Doge but AI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/8056a3e6_5d72_4b43_9a48_c6c1d189d509_366f4c4ee6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOGEAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGEAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

