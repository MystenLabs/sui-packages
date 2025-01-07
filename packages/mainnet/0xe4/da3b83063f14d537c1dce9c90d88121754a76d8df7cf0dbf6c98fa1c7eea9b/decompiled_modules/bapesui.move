module 0xe4da3b83063f14d537c1dce9c90d88121754a76d8df7cf0dbf6c98fa1c7eea9b::bapesui {
    struct BAPESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAPESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAPESUI>(arg0, 6, b"BAPESUI", b"BRAZILIAN APE SUI", b"NEYMAR JR'S SUI MEMECOIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/d30e58f5_20b0_463f_8008_e503218febfd_5b26f7dd52.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAPESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAPESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

