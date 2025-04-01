module 0x8c4aaf5dc8fcc3c5c113c18a8dfbcdde3ea5163218501abe9e9b0d60a67d4e37::chike {
    struct CHIKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIKE>(arg0, 6, b"CHIKE", b"Chike", b"Eat the chike", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000053034_854bb8bdff.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHIKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

