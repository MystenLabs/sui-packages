module 0x73b43acd46b744ef76c039c62b0fe66d5a99c2fcc1f7b9b7b44b30310574db81::dogi {
    struct DOGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGI>(arg0, 6, b"DOGI", b"DOGI Token", b"DOGI Token is the king", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://beige-abstract-pig-256.mypinata.cloud/ipfs/bafybeibxoqyrauo3po2milbl457qswcpzgdoju275mujji45tndpeej3ri")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOGI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

