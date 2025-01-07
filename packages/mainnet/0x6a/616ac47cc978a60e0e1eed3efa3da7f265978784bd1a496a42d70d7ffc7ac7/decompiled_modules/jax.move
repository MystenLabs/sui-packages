module 0x6a616ac47cc978a60e0e1eed3efa3da7f265978784bd1a496a42d70d7ffc7ac7::jax {
    struct JAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAX>(arg0, 6, b"Jax", b"Jax on sui", x"0a54686520707572706c652072616262697420697320726562656c6c696f757320616e64206c696b657320746f207465617365206f74686572732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Vflu_Rd_KO_400x400_68e61de7bd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JAX>>(v1);
    }

    // decompiled from Move bytecode v6
}

