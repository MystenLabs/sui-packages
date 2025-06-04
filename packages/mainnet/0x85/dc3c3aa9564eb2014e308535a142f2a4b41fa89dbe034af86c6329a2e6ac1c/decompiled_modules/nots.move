module 0x85dc3c3aa9564eb2014e308535a142f2a4b41fa89dbe034af86c6329a2e6ac1c::nots {
    struct NOTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOTS>(arg0, 6, b"NOTS", b"notsui", x"6d65206e6f74207375690a6d65206a757374206d656d65", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreia27popchiu3xbf3gysquuefc5whlo6ic3pve7lteiud7y3hkk43m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NOTS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

