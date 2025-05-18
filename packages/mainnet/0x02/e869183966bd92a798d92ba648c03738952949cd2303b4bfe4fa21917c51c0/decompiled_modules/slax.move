module 0x2e869183966bd92a798d92ba648c03738952949cd2303b4bfe4fa21917c51c0::slax {
    struct SLAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLAX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLAX>(arg0, 6, b"Slax", b"Snorlax", b"The biggest Pokemon on SUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreif67ms6263ah3qb5sjt43mafmjtxlz547ig7uya37u3fpmuikt2hm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLAX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SLAX>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

