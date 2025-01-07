module 0x3fbde0be9d7925f59e681161ac92a213d13d169f15f90951be2b5eada815fa15::bubo {
    struct BUBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBO>(arg0, 6, b"Bubo", b"SuiBubo", b"STRONG COMMUNITY! WE WILL FIGHT TO MAKE THIS COIN THE TOP #1 SPOT ON CHARTS. DON'T MISS OUT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ownership_d1b303d881.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

