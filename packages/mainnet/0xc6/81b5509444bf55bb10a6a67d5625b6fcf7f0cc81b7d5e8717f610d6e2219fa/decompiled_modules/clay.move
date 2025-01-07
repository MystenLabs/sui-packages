module 0xc681b5509444bf55bb10a6a67d5625b6fcf7f0cc81b7d5e8717f610d6e2219fa::clay {
    struct CLAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLAY>(arg0, 6, b"Clay", b"Clay Dog", b"Sui's cutest Clay Dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/clay_dog_a5c4b81730.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

