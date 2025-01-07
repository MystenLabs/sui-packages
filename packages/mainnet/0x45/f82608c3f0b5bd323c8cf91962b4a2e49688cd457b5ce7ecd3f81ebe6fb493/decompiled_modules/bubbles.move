module 0x45f82608c3f0b5bd323c8cf91962b4a2e49688cd457b5ce7ecd3f81ebe6fb493::bubbles {
    struct BUBBLES has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBBLES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBBLES>(arg0, 6, b"BUBBLES", b"Bubbles", b"Floaty, fun, and always rising! $BUBBLES brings a playful burst of energy wherever it goes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_b3bdf5fe3f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBBLES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUBBLES>>(v1);
    }

    // decompiled from Move bytecode v6
}

