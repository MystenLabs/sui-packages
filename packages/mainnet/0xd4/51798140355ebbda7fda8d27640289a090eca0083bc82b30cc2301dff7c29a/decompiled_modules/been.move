module 0xd451798140355ebbda7fda8d27640289a090eca0083bc82b30cc2301dff7c29a::been {
    struct BEEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEEN>(arg0, 6, b"BEEN", b"Sui Been", b"Just A Blue Been On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicl5qfpwyystaexqnaakewrafd7tm43h374bquk4chduvjn5akvfq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BEEN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

