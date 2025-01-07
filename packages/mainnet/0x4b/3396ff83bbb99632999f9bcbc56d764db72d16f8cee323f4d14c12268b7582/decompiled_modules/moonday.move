module 0x4b3396ff83bbb99632999f9bcbc56d764db72d16f8cee323f4d14c12268b7582::moonday {
    struct MOONDAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONDAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONDAY>(arg0, 6, b"MOONDAY", b"moonDay", b"Something HUGE is coming to DeFi ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/V_Mt_c_J0_W_400x400_03872337fb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONDAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOONDAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

