module 0xe61bb7d2e294a1a69489bca5041ce85928d18060cfb4e425a3cd77514ae331b8::lazy_forever_coin {
    struct LAZY_FOREVER_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<LAZY_FOREVER_COIN>, arg1: 0x2::coin::Coin<LAZY_FOREVER_COIN>) {
        0x2::coin::burn<LAZY_FOREVER_COIN>(arg0, arg1);
    }

    fun init(arg0: LAZY_FOREVER_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAZY_FOREVER_COIN>(arg0, 6, b"LAZY_FOREVER_COIN", b"lazy_forever", b"lazy_forever's coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://blog.lazyforever.top/img/favicon.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAZY_FOREVER_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAZY_FOREVER_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<LAZY_FOREVER_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LAZY_FOREVER_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

