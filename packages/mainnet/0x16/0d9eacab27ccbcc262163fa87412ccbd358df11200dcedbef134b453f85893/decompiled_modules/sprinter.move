module 0x160d9eacab27ccbcc262163fa87412ccbd358df11200dcedbef134b453f85893::sprinter {
    struct SPRINTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPRINTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPRINTER>(arg0, 6, b"SPRINTER", b"Suiet Printer", x"464f4d4f204d6173636f74206f6e200a405375696e6574776f726b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/s_S_Hbn_X_Ev_400x400_c4489dc2b0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPRINTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPRINTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

