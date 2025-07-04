module 0xe0db75cc83810a117608ab1dd813ea880365f33565b24d2cc1353182f068f93c::hcar {
    struct HCAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: HCAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HCAR>(arg0, 6, b"HCAR", b"Hamster Carrot", b"Step aside ordinary PFPs - Hamster Carrot is here to nibble its way to the top of the Sui NFT scene! powered by the speed and security of the Sui Blockchain, each Hamster Carrot is a symbol of playful energy and unstoppable growth.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibb63lbi6cncvkq3jctrgdgv7e3libf7scfhnoty7qa2m4l73uvvy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HCAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HCAR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

