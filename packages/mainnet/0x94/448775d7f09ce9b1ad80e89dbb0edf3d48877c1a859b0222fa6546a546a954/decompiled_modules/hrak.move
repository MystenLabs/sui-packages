module 0x94448775d7f09ce9b1ad80e89dbb0edf3d48877c1a859b0222fa6546a546a954::hrak {
    struct HRAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: HRAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HRAK>(arg0, 6, b"HRAK", b"Dragon Shark", b"Hrak on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifqlzsjc5abcve6acwakqvd7jfdcpshyeusdtbbl3xo4eb5qyq2he")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HRAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HRAK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

