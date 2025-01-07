module 0x77b96b756147d627e2e7af69a6def2cefb5da36abb01f73d0c99c31b16943ab::crooge {
    struct CROOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CROOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CROOGE>(arg0, 6, b"CROOGE", b"ScroogeSui", b"The richest duck in history...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/asdad_6591d842b3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CROOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CROOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

