module 0x7f1f19ad93529d77f784999e518f3af6783fb7c917a8e61f29ea38fc3fb28144::doodie {
    struct DOODIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOODIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOODIE>(arg0, 6, b"DOODIE", b"DOODIEMAN ON SUI", b"FARTCOIN 2.0", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifv5qbhfj55h4ppkwgwyslqc3sdhhwxzb5dbwywzf5cw3nzg4gd4a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOODIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOODIE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

