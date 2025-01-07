module 0x35f67159f8e5920d1b88ac3c833dbc37af7e14178c57643b5b0a2f6f067ba3e1::medusa {
    struct MEDUSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEDUSA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEDUSA>(arg0, 6, b"MEDUSA", b"BrokenEmoAi", b"im like an echo of your feelings", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/XZW_9y_TMC_400x400_131484353d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEDUSA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEDUSA>>(v1);
    }

    // decompiled from Move bytecode v6
}

