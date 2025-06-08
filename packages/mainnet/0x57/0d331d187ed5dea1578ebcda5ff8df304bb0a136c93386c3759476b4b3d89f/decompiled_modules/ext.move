module 0x570d331d187ed5dea1578ebcda5ff8df304bb0a136c93386c3759476b4b3d89f::ext {
    struct EXT has drop {
        dummy_field: bool,
    }

    fun init(arg0: EXT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EXT>(arg0, 6, b"EXT", b"3xhuasted", b"Give me Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigi2blvdqclaukrxdapxqywmsyq4utlyhsjvrbednl6xbo5v7slie")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EXT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EXT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

