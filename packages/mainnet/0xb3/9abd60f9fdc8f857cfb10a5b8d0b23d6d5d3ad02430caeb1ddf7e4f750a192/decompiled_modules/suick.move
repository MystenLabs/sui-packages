module 0xb39abd60f9fdc8f857cfb10a5b8d0b23d6d5d3ad02430caeb1ddf7e4f750a192::suick {
    struct SUICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICK>(arg0, 6, b"SUICK", b"Suick", b"You must be sick if you think Sui will make it this cycle", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suick_5bb4f5d9ff.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICK>>(v1);
    }

    // decompiled from Move bytecode v6
}

