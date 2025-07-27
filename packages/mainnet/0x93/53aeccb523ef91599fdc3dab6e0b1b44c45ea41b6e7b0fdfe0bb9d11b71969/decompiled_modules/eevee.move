module 0x9353aeccb523ef91599fdc3dab6e0b1b44c45ea41b6e7b0fdfe0bb9d11b71969::eevee {
    struct EEVEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EEVEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EEVEE>(arg0, 6, b"Eevee", b"Eevee On Sui", b"Eevee sui will find its evolution on sui chain!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigsaxfsy2sol3slmawt7afqlz2m6ww4nvoctghsnjb6rhaorho2hm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EEVEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EEVEE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

