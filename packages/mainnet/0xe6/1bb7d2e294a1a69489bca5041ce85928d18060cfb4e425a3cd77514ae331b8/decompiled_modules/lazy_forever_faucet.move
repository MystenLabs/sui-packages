module 0xe61bb7d2e294a1a69489bca5041ce85928d18060cfb4e425a3cd77514ae331b8::lazy_forever_faucet {
    struct LAZY_FOREVER_FAUCET has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<LAZY_FOREVER_FAUCET>, arg1: 0x2::coin::Coin<LAZY_FOREVER_FAUCET>) {
        0x2::coin::burn<LAZY_FOREVER_FAUCET>(arg0, arg1);
    }

    fun init(arg0: LAZY_FOREVER_FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAZY_FOREVER_FAUCET>(arg0, 6, b"LAZY_FOREVER_FAUCET", b"lazy_forever", b"lazy_forever's faucet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://blog.lazyforever.top/img/favicon.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAZY_FOREVER_FAUCET>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAZY_FOREVER_FAUCET>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<LAZY_FOREVER_FAUCET>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LAZY_FOREVER_FAUCET>(arg0, 1000000, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

