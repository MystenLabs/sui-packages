module 0x9db67b54e3f2f44edd2607ae20966af7455bc8ef8df5948f38f5c90dd954120e::spike {
    struct SPIKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPIKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPIKE>(arg0, 6, b"SPIKE", b"SpikeFurie", b"Spike could be your next big first. He's a fun-loving dinosaur trying to fit in as a kid in the '80s, straight from Matt Furie's imagination.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/RP_Xpr_WLP_400x400_d8dbf7f8a8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPIKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPIKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

