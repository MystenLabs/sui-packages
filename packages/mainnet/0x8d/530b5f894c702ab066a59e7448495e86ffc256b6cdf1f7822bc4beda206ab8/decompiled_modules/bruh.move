module 0x8d530b5f894c702ab066a59e7448495e86ffc256b6cdf1f7822bc4beda206ab8::bruh {
    struct BRUH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRUH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRUH>(arg0, 6, b"BRUH", b"Bruh", b"Bruh.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bruh_ebf708d2f4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRUH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRUH>>(v1);
    }

    // decompiled from Move bytecode v6
}

