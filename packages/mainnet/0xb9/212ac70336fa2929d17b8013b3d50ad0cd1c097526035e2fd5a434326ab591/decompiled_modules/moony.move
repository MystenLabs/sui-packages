module 0xb9212ac70336fa2929d17b8013b3d50ad0cd1c097526035e2fd5a434326ab591::moony {
    struct MOONY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONY>(arg0, 6, b"MOONY", b"Moonshot", b"Moonshot spreading the green gospel of memes while unearthing the juiciest opportunities in the market with AI soon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreih4r77e4qbwoxbi6qkrxuuekccn5remtudlkp5wnmjl7yyu3hvi7i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MOONY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

