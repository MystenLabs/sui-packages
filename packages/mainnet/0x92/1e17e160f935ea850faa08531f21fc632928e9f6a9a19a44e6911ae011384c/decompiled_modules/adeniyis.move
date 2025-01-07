module 0x921e17e160f935ea850faa08531f21fc632928e9f6a9a19a44e6911ae011384c::adeniyis {
    struct ADENIYIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADENIYIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADENIYIS>(arg0, 6, b"Adeniyis", b"Adeniyi", b"Let us pay tribute to the great healer, Adeniyi.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000039238_7dd9057345.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADENIYIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ADENIYIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

