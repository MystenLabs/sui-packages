module 0xa461bb4b9a5258320f97f1871917512adc279548d9a527ad3882b7ee4e8011b8::cai {
    struct CAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAI>(arg0, 6, b"CAI", b"Just a Chill AI", b"Just an AI Chilln on Sui! B Bot B Bot!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Just_a_chill_AI_141e8881b1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

