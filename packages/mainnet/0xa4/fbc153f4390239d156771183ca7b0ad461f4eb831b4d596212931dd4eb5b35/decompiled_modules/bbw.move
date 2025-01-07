module 0xa4fbc153f4390239d156771183ca7b0ad461f4eb831b4d596212931dd4eb5b35::bbw {
    struct BBW has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBW>(arg0, 6, b"BBW", b"Baby Blue Whale", b"In the vast digital ocean of the cryptocurrency world, there existed tiny baby blue whale and massive \"crypto whales.\" Among these tiny investors was a curious and determined baby blue", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_ae_a_20240915005819_2d9e345671.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBW>>(v1);
    }

    // decompiled from Move bytecode v6
}

