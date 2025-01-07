module 0xc0ca237b9355bf5611bb9dea03e0ab1e18049f146367a03c6e556a8bdc660068::osp {
    struct OSP has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSP>(arg0, 6, b"OSP", b"ONE SUI PIECE", x"546865206a6f75726e6579206f6620746865206d616e2077697468206120686174206f6e205355492068617320626567616e2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Dise_A_o_sin_t_A_tulo_29_5ea807cfd3_f0954012dc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OSP>>(v1);
    }

    // decompiled from Move bytecode v6
}

