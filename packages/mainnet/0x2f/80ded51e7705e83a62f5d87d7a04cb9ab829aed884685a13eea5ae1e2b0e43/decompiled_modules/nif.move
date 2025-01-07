module 0x2f80ded51e7705e83a62f5d87d7a04cb9ab829aed884685a13eea5ae1e2b0e43::nif {
    struct NIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIF>(arg0, 6, b"NIF", b"NIF the sad cat", b"I am ok", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9231_17030a3a2d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

