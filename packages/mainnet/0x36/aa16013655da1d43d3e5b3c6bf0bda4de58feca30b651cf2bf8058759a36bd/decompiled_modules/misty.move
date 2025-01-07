module 0x36aa16013655da1d43d3e5b3c6bf0bda4de58feca30b651cf2bf8058759a36bd::misty {
    struct MISTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MISTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MISTY>(arg0, 6, b"MISTY", b"Misty", b"$MISTY is introducing a new and exciting element to the $SUI ecosystem, enhancing its value and appeal.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1730644239662_57e9b5937d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MISTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MISTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

