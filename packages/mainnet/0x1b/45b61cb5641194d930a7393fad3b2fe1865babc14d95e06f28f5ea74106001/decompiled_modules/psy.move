module 0x1b45b61cb5641194d930a7393fad3b2fe1865babc14d95e06f28f5ea74106001::psy {
    struct PSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSY>(arg0, 6, b"PSY", b"Psyduck into the PokeVerse", x"50535920205468652047656e65736973204d656d6520506f6b656d6f6e204a7573742045766f6c7665642e0a426f726e20696e206368616f732e20466f7267656420696e20636f6e667573696f6e2e204261636b20746f207265636c61696d2074686520636861696e2e0a0a204f6e6520746f6b656e2e204f6e65206d656d652e204f6e6520506f6b6556657273652e0a204465666c6174696f6e6172792e20436173696e6f2d706f77657265642e2053746f72792d64726976656e2e0a0a506c61792e205374616b652e20417363656e642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibjcu2senl6xosofh7hzbrqgdbwwcmzpbt7bhv2lwoaaja7qfxrem")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PSY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

