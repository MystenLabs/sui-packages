module 0xe4772b143a6a1b093018c40f0eb2a1d3f4e112b3e14eb3b9bd88e25529833847::ponkesui {
    struct PONKESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PONKESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PONKESUI>(arg0, 6, b"PONKESUI", b"PONKE SUI", b"hi Im Ponke - https://t.me/ponketg $PONKE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PONKESUI_e859ee4019.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PONKESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PONKESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

