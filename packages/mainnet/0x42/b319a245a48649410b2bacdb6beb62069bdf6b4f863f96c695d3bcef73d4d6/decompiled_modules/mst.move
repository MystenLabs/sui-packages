module 0x42b319a245a48649410b2bacdb6beb62069bdf6b4f863f96c695d3bcef73d4d6::mst {
    struct MST has drop {
        dummy_field: bool,
    }

    fun init(arg0: MST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MST>(arg0, 6, b"MST", b"MOONBARK TST", b"Moonbarak - the blinged-out king on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreid5zdjo2jbt3sdb7vb5lu43nvmtfwx4vp53zr23f7e3j5vkpbpkyy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MST>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

