module 0x8abc1b4bde94fe6dda8dd8ac2b0ec8ff62e8a9eff24be75104aebaf4946540c8::suidrop {
    struct SUIDROP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDROP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDROP>(arg0, 6, b"SUIDROP", b"SUIDROP TOKEN", b"SUIDROP  TOKEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_sui_logo_Large_2fc7b5b3be.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDROP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDROP>>(v1);
    }

    // decompiled from Move bytecode v6
}

