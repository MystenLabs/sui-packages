module 0x9819784019a2dbeca96895621d7a145df08f38ff80eb95eb3de32b251bf5e4fd::eggy {
    struct EGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGGY>(arg0, 6, b"Eggy", b"Egg", b"Egg the most egg in egg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreig7oqsvkt4le5uks6pcc7x645vmj5rrsmsnkffu4nwgrs3kwvzpgi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EGGY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

