module 0x291fc9c5e4e7a19ad89f007c039bbbe5927cd4fa860499c0aac32ec3a75f4fdb::dwogi {
    struct DWOGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DWOGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DWOGI>(arg0, 6, b"DWOGI", b"DWOGI SUI", b"AT FIRST, THE EXPERIENCE WAS WILD AND CRAZY, WITH COLORS AND SHAPES DANCING IN HER VISION", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieoal7ermjjxcx2232c7tdpsrg544ioryojtm6dnt6gqb7dwsly3m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DWOGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DWOGI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

