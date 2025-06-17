module 0x634f6f4a9b53a978d29f720524b718d0d35c4eaffc8903455c54f40cfe21317b::jabber {
    struct JABBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: JABBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JABBER>(arg0, 6, b"Jabber", b"Jabber Jaw", b"The Jaw On Sui Blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibuikj4bp6vt5dmxthshhfpbvxk7pn5xnuw372bef3vkzv2nqbzr4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JABBER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JABBER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

