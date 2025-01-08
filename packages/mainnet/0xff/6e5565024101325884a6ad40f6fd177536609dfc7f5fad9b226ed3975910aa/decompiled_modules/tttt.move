module 0xff6e5565024101325884a6ad40f6fd177536609dfc7f5fad9b226ed3975910aa::tttt {
    struct TTTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTTT>(arg0, 6, b"TTTT", b"TE", b"adadasda", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mg_5421666965.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TTTT>>(v1);
    }

    // decompiled from Move bytecode v6
}

