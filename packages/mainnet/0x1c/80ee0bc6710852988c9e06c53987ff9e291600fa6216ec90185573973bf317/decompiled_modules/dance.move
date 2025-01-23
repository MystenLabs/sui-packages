module 0x1c80ee0bc6710852988c9e06c53987ff9e291600fa6216ec90185573973bf317::dance {
    struct DANCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DANCE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DANCE>(arg0, 6, b"DANCE", b"Trump Official Dance moves by SuiAI", b"Dance for your gains, if you stop you drop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/official_dance_moves_82d4d62a5d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DANCE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DANCE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

