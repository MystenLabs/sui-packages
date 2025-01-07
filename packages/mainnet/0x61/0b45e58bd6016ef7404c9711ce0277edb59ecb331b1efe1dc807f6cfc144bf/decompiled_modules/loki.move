module 0x610b45e58bd6016ef7404c9711ce0277edb59ecb331b1efe1dc807f6cfc144bf::loki {
    struct LOKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOKI>(arg0, 6, b"LOKI", b"LokiCatOnSui", b"$LOKI- Welcome to the world of crypto kitties on the Sui Network! Our project embodies the rising trend of Cat-themed cryptocurrencies within the crypto world. Were not just any cat coin; were the cutest one yet, set to launch and flourish on the Sui Network. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001649_229c49c093.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

