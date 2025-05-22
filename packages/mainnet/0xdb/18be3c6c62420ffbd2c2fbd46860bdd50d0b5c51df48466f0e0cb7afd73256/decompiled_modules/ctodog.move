module 0xdb18be3c6c62420ffbd2c2fbd46860bdd50d0b5c51df48466f0e0cb7afd73256::ctodog {
    struct CTODOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTODOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTODOG>(arg0, 6, b"CTODOG", b"DOG CTO Token", b"This is a new CTO in moonbags", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibxoqyrauo3po2milbl457qswcpzgdoju275mujji45tndpeej3ri")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTODOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CTODOG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

