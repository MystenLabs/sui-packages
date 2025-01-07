module 0x71896639883803e927835456fbb7b99089f4f50e2dccb7a6a05e13b0259315f4::aaadrop {
    struct AAADROP has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAADROP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAADROP>(arg0, 6, b"AAADROP", b"aaaDroplet", b" ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/droplet_9319cff759.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAADROP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAADROP>>(v1);
    }

    // decompiled from Move bytecode v6
}

