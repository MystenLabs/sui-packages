module 0x88f9785ab8bf41502d6b54378023ec8e3cc2ef5e642902d8d6b1844398b403fb::train {
    struct TRAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRAIN>(arg0, 6, b"TRAIN", b"The Rain", b"The heavy rain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihs3mgy4z2lz7udvjq33ezljzr7u6ghmf63mvbpypavnyxog4ic54")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRAIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TRAIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

