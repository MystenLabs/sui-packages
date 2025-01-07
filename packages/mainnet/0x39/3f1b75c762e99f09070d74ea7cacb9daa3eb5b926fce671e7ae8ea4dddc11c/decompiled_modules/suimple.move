module 0x393f1b75c762e99f09070d74ea7cacb9daa3eb5b926fce671e7ae8ea4dddc11c::suimple {
    struct SUIMPLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMPLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMPLE>(arg0, 6, b"Suimple", b"Suimple Coin", b"Suimple Coin is created based on the Suimple Coin currency that is currently viral on the Telegram Mini App, we create Simple Coin in the SUI Ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_02_213013_b7d1f63eff.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMPLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMPLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

