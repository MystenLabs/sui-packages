module 0x20bbd2694f120dab535d8f71a3f3474d445efbe85b247d39b603ac40aa5752b2::sbet {
    struct SBET has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBET>(arg0, 6, b"SBET", b"SuiDotBet", b"$SBET meme coin on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000217_e0a1b0cc69.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBET>>(v1);
    }

    // decompiled from Move bytecode v6
}

