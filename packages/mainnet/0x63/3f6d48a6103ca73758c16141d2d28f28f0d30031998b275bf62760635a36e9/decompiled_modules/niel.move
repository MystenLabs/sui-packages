module 0x633f6d48a6103ca73758c16141d2d28f28f0d30031998b275bf62760635a36e9::niel {
    struct NIEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIEL>(arg0, 6, b"NIEL", b"Niel Armstrong Sui", b"NEIL - Inspired by Neil Armstrong who first landed on the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001577_9695b519ec.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NIEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

