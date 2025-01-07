module 0xc91685c117ab081a6bcb91981edbf16db253ac3380229b73e3f95d70da8bfbec::skop {
    struct SKOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKOP>(arg0, 6, b"SKOP", b"SKULL OF PEPE", b"SKULL OF PEPE ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_1_b527ba65cf.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

