module 0xad09aac0664a7f7d9d09076adc1f4bf2b49f44e23ac90de1ce8bfb659b191d32::random {
    struct RANDOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: RANDOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RANDOM>(arg0, 6, b"RANDOM", b"Random", b"$RANDOM It does nothing but generate the most random image you can imagine. Pure chaos, zero purpose.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_7f4852489b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RANDOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RANDOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

