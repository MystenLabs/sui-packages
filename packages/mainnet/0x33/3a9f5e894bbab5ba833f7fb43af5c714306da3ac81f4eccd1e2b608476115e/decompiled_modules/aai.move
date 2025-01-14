module 0x333a9f5e894bbab5ba833f7fb43af5c714306da3ac81f4eccd1e2b608476115e::aai {
    struct AAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AAI>(arg0, 6, b"AAI", b"AiOnSui  by SuiAI", b"AiOnSui is Your All-in-One Crypto Companion! Elevate your crypto experience with cutting-edge technology, seamless management, and strategic insights", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/jh_dabeb0c949.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

