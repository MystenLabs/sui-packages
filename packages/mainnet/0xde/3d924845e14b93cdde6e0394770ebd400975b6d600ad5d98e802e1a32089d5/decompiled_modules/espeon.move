module 0xde3d924845e14b93cdde6e0394770ebd400975b6d600ad5d98e802e1a32089d5::espeon {
    struct ESPEON has drop {
        dummy_field: bool,
    }

    fun init(arg0: ESPEON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ESPEON>(arg0, 6, b"Espeon", b"Espeon Poke", b"good old reliable Machamp counter", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibc6wdldke2ylazcfx7uq2w4w7dol6x4eojmkv5a246gbtzk6qboi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ESPEON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ESPEON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

