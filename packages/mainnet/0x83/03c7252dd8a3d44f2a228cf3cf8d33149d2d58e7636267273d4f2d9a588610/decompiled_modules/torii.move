module 0x8303c7252dd8a3d44f2a228cf3cf8d33149d2d58e7636267273d4f2d9a588610::torii {
    struct TORII has drop {
        dummy_field: bool,
    }

    fun init(arg0: TORII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TORII>(arg0, 6, b"Torii", b"Torii Gate", b"Your entry to spiritually free", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieiekueygmqbwubqmyozsamxn2lkezwrg4u2cjqm3shhjkfmil5ii")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TORII>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TORII>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

