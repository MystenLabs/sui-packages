module 0x4ba1007c868b2aabbc297fc9ff91f62e2280c0f61249e6c75a4eb95d1304f56::MEOW {
    struct MEOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEOW>(arg0, 6, b"MEOW", b"Meow", b"meow meow meow meow..... meow meow meow meow meow", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/Qmds5MuAPTV4wbNu1QXtaugZVh7XLAQjZrvyVo6MXeTiDA")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEOW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

