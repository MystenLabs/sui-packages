module 0xbfb9db4b06c368f7bec7186c4fe596108cfff4c7667bd75d1b6f9e823b756753::croco {
    struct CROCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CROCO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CROCO>(arg0, 6, b"CROCO", b"CROCONAW", b"Croconaw is a Water Pokemon that evolves from Totodile. It is vulnerable to Grass and Electric attacks. Croconaw strongest attacks are Water Gun and Water", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidcb5d3ayyj3c75mz3rwo4j6jumh4iied3amx672lqk6h3browx4u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CROCO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CROCO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

