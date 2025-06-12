module 0xb9849ff864470d8356f3868db34b23e1a7054d44c968e1fdfc6524222dce9f2a::sf {
    struct SF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SF>(arg0, 6, b"SF", b"dsfsg", b"gfetre", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigzlbjpo6ieidxopgpmzgqu5armvwjd6wccijatr4ubh6tsipobhe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SF>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

