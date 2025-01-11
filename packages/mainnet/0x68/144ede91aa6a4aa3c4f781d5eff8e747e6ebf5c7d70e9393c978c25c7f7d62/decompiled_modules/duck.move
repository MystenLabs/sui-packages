module 0x68144ede91aa6a4aa3c4f781d5eff8e747e6ebf5c7d70e9393c978c25c7f7d62::duck {
    struct DUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCK>(arg0, 6, b"DUCK", b"Duck", b"Dive into the Sui ecosystem with Duck Coin, the playful and unpredictable memecoin ready to ruffle some feathers. Join the flock and experience the thrill of decentralized finance with a side of quackers!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736600192698.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUCK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

