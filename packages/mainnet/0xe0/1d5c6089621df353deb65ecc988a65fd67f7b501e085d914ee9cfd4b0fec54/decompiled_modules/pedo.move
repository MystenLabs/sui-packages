module 0xe01d5c6089621df353deb65ecc988a65fd67f7b501e085d914ee9cfd4b0fec54::pedo {
    struct PEDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEDO>(arg0, 6, b"PEDO", b"Trumpedo", b"Elon announces, Trumpedo is real!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidz3nyfkzizaseplfr3qigzim7okbv67mezdrm4vlvxfma7hyqwfq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEDO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PEDO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

