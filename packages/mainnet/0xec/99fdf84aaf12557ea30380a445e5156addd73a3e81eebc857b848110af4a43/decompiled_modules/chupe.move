module 0xec99fdf84aaf12557ea30380a445e5156addd73a3e81eebc857b848110af4a43::chupe {
    struct CHUPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHUPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHUPE>(arg0, 6, b"CHUPE", b"pepechui", b"PEPE SE MAMO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaisi4rhioqxsimdee3nmx26wgd66vwnklhukdxrqmyleldye52ie")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHUPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHUPE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

