module 0xe9ed4dbeb222239d6433fcb8f956b8db6f7c0b0a466505846f6d0121160b59ff::arceus {
    struct ARCEUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARCEUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARCEUS>(arg0, 6, b"Arceus", b"Pokemon God", b"Known as The Original One, Arceus created the Pokemon universe, shaping time, space, and matter with divine precision.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeif5pbpmmk775rv3drnc6fc5itvvkewmlbtuy7mrv6r4tadqn2fwdq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARCEUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ARCEUS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

