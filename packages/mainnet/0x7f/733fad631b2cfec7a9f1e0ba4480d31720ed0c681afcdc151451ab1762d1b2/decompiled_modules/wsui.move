module 0x7f733fad631b2cfec7a9f1e0ba4480d31720ed0c681afcdc151451ab1762d1b2::wsui {
    struct WSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WSUI>(arg0, 6, b"WSUI", b"Windows SUI", b"Windows SUI Official", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bdogbg_c0da3baed9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

