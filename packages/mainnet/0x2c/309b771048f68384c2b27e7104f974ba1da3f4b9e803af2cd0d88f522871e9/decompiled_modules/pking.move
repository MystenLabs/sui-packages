module 0x2c309b771048f68384c2b27e7104f974ba1da3f4b9e803af2cd0d88f522871e9::pking {
    struct PKING has drop {
        dummy_field: bool,
    }

    fun init(arg0: PKING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PKING>(arg0, 6, b"PKING", b"King Penguin", b"$PKING is ready to take over Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreib6qco5xj7sislyf7quf5mqqfqvqeztfxtdqjr7ouutep2uzu2xde")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PKING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PKING>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

