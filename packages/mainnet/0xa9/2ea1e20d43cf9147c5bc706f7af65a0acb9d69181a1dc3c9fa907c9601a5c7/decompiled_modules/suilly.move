module 0xa92ea1e20d43cf9147c5bc706f7af65a0acb9d69181a1dc3c9fa907c9601a5c7::suilly {
    struct SUILLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILLY>(arg0, 6, b"SUILLY", b"Free Suilly", b"Suilly is the official mascot of the SUI network, an orca that dominates the blockchain seas and guarantees its holders a bright future with many profits.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_12_162015619_1a870144a9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

