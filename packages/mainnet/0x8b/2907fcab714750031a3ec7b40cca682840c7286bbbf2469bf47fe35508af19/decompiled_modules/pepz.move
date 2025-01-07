module 0x8b2907fcab714750031a3ec7b40cca682840c7286bbbf2469bf47fe35508af19::pepz {
    struct PEPZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPZ>(arg0, 6, b"PEPZ", b"Pepe's on a trip", b"When Pepe's on a trip but forgot where the destination was", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Crypto_memes_f269bce667_53c00f34d7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

