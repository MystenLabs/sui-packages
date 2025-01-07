module 0x714f7e4ed9fd37ffeaa691f4749aff40518f96ad1c83ec8bbe7db4ac0812073b::whale {
    struct WHALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHALE>(arg0, 6, b"WHALE", b"WILLY THE WHALE ON SUI", b"A colossal trader of the Sui sea. Tired of watching small fish get fried, he's breaching the surface to make a splash in the big pool. Join his pod and ride the wave to crypto glory", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/logo_twitter_fb1321988e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHALE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHALE>>(v1);
    }

    // decompiled from Move bytecode v6
}

