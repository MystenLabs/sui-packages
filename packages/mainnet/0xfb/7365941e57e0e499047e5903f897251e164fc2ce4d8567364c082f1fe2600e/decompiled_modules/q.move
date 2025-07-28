module 0xfb7365941e57e0e499047e5903f897251e164fc2ce4d8567364c082f1fe2600e::q {
    struct Q has drop {
        dummy_field: bool,
    }

    fun init(arg0: Q, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<Q>(arg0, 6, b"Q", b"The Q", b"Stalker of Picard.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiadk76saofq4tbyg6cjlxxvav4hgfko7kjddbmhti3daru7havilq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<Q>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<Q>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

