module 0x3c5451d7b7c0ab16d95798b1587492d9fcc0b5f58463b1d1abc8c220f8aa68df::baseddev {
    struct BASEDDEV has drop {
        dummy_field: bool,
    }

    fun init(arg0: BASEDDEV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BASEDDEV>(arg0, 6, b"BASEDDEV", b"Based Dev", b"I'm full-time crypto now and will continue working hard. I won't ever sell any tokens that I make, only burn or give away.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dev_aa8e154580.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BASEDDEV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BASEDDEV>>(v1);
    }

    // decompiled from Move bytecode v6
}

