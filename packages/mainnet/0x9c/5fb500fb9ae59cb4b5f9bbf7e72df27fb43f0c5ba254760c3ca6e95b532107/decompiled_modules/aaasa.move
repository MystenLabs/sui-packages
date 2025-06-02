module 0x9c5fb500fb9ae59cb4b5f9bbf7e72df27fb43f0c5ba254760c3ca6e95b532107::aaasa {
    struct AAASA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAASA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAASA>(arg0, 6, b"Aaasa", b"sdsds", b"sdsd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigozlr4kqlx5zrbu2gyc2ooqeovw342o5pu7rfig3wryli6lghhla")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAASA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AAASA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

