module 0x8137cd892ec45fbdab42a465c200a9953987e83c0f3ffa43a68f18db577dd3db::sugmaz {
    struct SUGMAZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUGMAZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUGMAZ>(arg0, 6, b"SUGMAZ", b"Sui Sugmaz", b"$SUGMAZ - The only sack worth holding", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000047947_54a135ee93.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUGMAZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUGMAZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

