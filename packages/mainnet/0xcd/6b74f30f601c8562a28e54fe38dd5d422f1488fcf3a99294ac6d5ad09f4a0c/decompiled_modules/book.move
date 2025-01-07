module 0xcd6b74f30f601c8562a28e54fe38dd5d422f1488fcf3a99294ac6d5ad09f4a0c::book {
    struct BOOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOK>(arg0, 6, b"BOOK", b"Book Of Sui", b"Unlock the mysteries of the Sui blockchain with the Book of Sui. Each page holds the secrets of the decentralized world, waiting to be explored.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Book_Of_Sui_cf4b6bb5e5.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOOK>>(v1);
    }

    // decompiled from Move bytecode v6
}

