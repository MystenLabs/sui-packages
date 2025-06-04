module 0xb35023ea731fc2cfd79e0e6984337e7acf97363efefc0bce19ee5f038e6ad3b9::sgc {
    struct SGC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGC>(arg0, 6, b"SGC", b"Sui goat Croc", b"Suigoats", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreia6qg72tqayqkrzwhskdu2yn3mka4lxpeubs26jnyjiohnyd6ksf4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SGC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

