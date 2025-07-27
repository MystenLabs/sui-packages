module 0x7f726289256ae6de8c8835ba4a409f3c360514bfc54a588a9d32780c32ccfe05::pokemon {
    struct POKEMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: POKEMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POKEMON>(arg0, 6, b"POKEMON", b"POKEMON NINJA", b"commonly believed to be designed from Ryujin, a dragon who resides in the ocean floor. But it did get designed with features from beluga whales, plesiosaurs and birds.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiblejyqh5nk5i4zkluojezu73ceuenrqvhbg2mn4uenmxe3qb73fa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POKEMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POKEMON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

