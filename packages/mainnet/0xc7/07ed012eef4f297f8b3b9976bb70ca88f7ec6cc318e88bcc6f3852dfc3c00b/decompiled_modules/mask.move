module 0xc707ed012eef4f297f8b3b9976bb70ca88f7ec6cc318e88bcc6f3852dfc3c00b::mask {
    struct MASK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MASK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MASK>(arg0, 6, b"MASK", b"catwifmask", b"catwifmask (MASK)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/catwifmask_logo_d12a4a1963.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MASK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MASK>>(v1);
    }

    // decompiled from Move bytecode v6
}

