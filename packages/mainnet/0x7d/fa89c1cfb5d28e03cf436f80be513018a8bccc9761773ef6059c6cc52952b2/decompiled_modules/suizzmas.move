module 0x7dfa89c1cfb5d28e03cf436f80be513018a8bccc9761773ef6059c6cc52952b2::suizzmas {
    struct SUIZZMAS has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIZZMAS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIZZMAS>>(0x2::coin::mint<SUIZZMAS>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SUIZZMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIZZMAS>(arg0, 6, b"SUIZZMAS", b"SUIZZMAS", b"we wish you a merry Suizzmas and a happy new year!", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIZZMAS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIZZMAS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

