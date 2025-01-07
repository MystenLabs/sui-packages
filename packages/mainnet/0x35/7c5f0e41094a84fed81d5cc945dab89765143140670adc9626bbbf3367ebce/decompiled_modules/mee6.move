module 0x357c5f0e41094a84fed81d5cc945dab89765143140670adc9626bbbf3367ebce::mee6 {
    struct MEE6 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEE6, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEE6>(arg0, 6, b"MEE6", b"MEE6 BOT", b"an popular discord bot mascot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mee6_4da08e2fc0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEE6>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEE6>>(v1);
    }

    // decompiled from Move bytecode v6
}

