module 0x4f106200c44d8eed5ebce05c92e95b607ceefcabb106ea27fe25fd7530d552b5::suigre {
    struct SUIGRE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGRE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGRE>(arg0, 6, b"SUIGRE", b"SUIGRE LEGENDARY POKEMON", b"Suigre the legendary water type Pokemon who controls all the seas and oceans.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihnvnvaxp7p3vwwsw74bqrdikmmpyq7y6urzuwhetuu4gsedq5s54")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGRE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIGRE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

