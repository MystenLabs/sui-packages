module 0xad4c0d23901ec3aa5afa32fe5881eb2a9db38f280eb806623a77f26f989ee801::suieet {
    struct SUIEET has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIEET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIEET>(arg0, 6, b"SUIEET", b"SUI SWEET", b"The Sweetest Meme on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibssccgowjx4666lyykvbnfczyo7mphgkwrowgfkphmmdgvxrtj6y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIEET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIEET>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

