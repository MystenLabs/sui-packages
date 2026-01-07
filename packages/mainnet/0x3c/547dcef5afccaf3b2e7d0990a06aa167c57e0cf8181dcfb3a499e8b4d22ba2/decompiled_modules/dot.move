module 0x3c547dcef5afccaf3b2e7d0990a06aa167c57e0cf8181dcfb3a499e8b4d22ba2::dot {
    struct DOT has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DOT>, arg1: 0x2::coin::Coin<DOT>) {
        0x2::coin::burn<DOT>(arg0, arg1);
    }

    fun init(arg0: DOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOT>(arg0, 9, b"DOT", b"DOT", b"Polkadot token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static.oklink.com/cdn/web3/currency/token/large/501-AmuwaD2VdjAgWWAxMvpksz4GWpMHAupVLnyTtSBqSrZx-107/type=default_90_0?v=1765911278605&x-oss-process=image/format,webp/resize,w_80,h_80,type_6/ignore-error,1")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOT>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DOT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DOT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

