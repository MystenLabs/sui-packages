module 0x7fd7b4f851d27e408b1c8fb8510d740ae77bf8f9ba9272778ccf84f10502d696::hpct {
    struct HPCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HPCT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HPCT>(arg0, 6, b"HPCT", b"HopCat", b"First cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CAT_e65a8c3736.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HPCT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HPCT>>(v1);
    }

    // decompiled from Move bytecode v6
}

