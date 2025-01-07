module 0x93f52013ce6a776aa29000fe5d763a6b6fa9bcd049ab80b57f5da422ad6c547::ibot {
    struct IBOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: IBOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IBOT>(arg0, 6, b"Ibot", b"S.BOT", b"Less emotions, more profits.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3748_23019fb827.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IBOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IBOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

