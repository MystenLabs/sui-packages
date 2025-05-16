module 0xddfbef711e83b1b5f080b707cc57d9a7294d0f52bd049b8ea12774c84a6cb191::pikainu {
    struct PIKAINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIKAINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIKAINU>(arg0, 6, b"PIKAINU", b"PIKACHUINU SUI", b"PikachuInu Launchpad on moonbags.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieytx2gockqxh354zwny3m3ptjwqmtacuks4x6vbh3cotjvkon5aq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIKAINU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PIKAINU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

