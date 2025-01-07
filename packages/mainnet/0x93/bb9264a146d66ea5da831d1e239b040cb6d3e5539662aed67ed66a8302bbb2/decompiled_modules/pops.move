module 0x93bb9264a146d66ea5da831d1e239b040cb6d3e5539662aed67ed66a8302bbb2::pops {
    struct POPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPS>(arg0, 6, b"POPS", b"POPShark", b"pop pop pop pop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_09_043145_b6f2caf420.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

