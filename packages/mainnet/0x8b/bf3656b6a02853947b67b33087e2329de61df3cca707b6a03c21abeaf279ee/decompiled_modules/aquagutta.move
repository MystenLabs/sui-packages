module 0x8bbf3656b6a02853947b67b33087e2329de61df3cca707b6a03c21abeaf279ee::aquagutta {
    struct AQUAGUTTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AQUAGUTTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AQUAGUTTA>(arg0, 6, b"AQUAGUTTA", b"aqua gutta", b"a drop of water from the mighty SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeic2n3mw6ng2g2xgapfma4wm5tu4dngjduv6jza2wotogxqgwou7vq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AQUAGUTTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AQUAGUTTA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

