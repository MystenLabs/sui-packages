module 0x7932ba20a235ea8776b2ce283507767546e797ba46c176048423c2086f903f6e::srf {
    struct SRF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRF>(arg0, 6, b"Srf", b"Surfsui", b"Surfing the wave of Sui  meme coins", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeieptmbnloz6ubfso5djhxdgphyyuia5hviigsulesqzj6yoscyhwy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SRF>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

