module 0x81990b345c0d74dddd226ca452f08601448854aef305501588ccb45fe9cb6aba::shower {
    struct SHOWER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHOWER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHOWER>(arg0, 6, b"SHOWER", b"SUI SHOWER", x"4974c2b4732074696d6520746f206861766520612073686f77657221", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigqp4vc6wvcch2sanpfgzbh4fflar7f43vasow3awft55pmhynfi4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHOWER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SHOWER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

