module 0x37d92b72d8bec3d0b8c1d8141209a0c08c91c013975c917e44b602cfc1d84e28::nopuggy {
    struct NOPUGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOPUGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOPUGGY>(arg0, 6, b"NOPUGGY", b"NO PUGGYDOG", b"NO PUGGY! SHIT TEAM :D", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibgbqwkspft2jkytzeamrkjagl5zpprugvpxhjvpwyvtasnvscfsa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOPUGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NOPUGGY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

