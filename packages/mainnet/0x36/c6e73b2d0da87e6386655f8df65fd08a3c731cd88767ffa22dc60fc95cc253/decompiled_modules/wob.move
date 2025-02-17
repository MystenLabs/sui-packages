module 0x36c6e73b2d0da87e6386655f8df65fd08a3c731cd88767ffa22dc60fc95cc253::wob {
    struct WOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOB>(arg0, 6, b"WOB", b"Wobcoin", b"just wob ok", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000065518_11d71e24cc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

