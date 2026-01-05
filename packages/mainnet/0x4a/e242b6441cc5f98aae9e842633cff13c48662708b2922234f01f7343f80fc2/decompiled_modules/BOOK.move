module 0x4ae242b6441cc5f98aae9e842633cff13c48662708b2922234f01f7343f80fc2::BOOK {
    struct BOOK has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BOOK>, arg1: 0x2::coin::Coin<BOOK>) {
        0x2::coin::burn<BOOK>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BOOK>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 < 10000000000000000000 - 0x2::coin::total_supply<BOOK>(arg0), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<BOOK>>(0x2::coin::mint<BOOK>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: BOOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOK>(arg0, 9, b"BOOKTEST", b"TBookTEST", b"TEST The TBook Token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://walrus-main-aggregator.4everland.org/v1/blobs/2SqOzKBNbZ_DS5-IvlpJHwTHgDnVhNhxAJg2Jl3hhBA")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOOK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

