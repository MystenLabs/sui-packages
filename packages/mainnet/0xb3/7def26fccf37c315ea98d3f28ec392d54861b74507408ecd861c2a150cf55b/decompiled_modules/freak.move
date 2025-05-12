module 0xb37def26fccf37c315ea98d3f28ec392d54861b74507408ecd861c2a150cf55b::freak {
    struct FREAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FREAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FREAK>(arg0, 6, b"FREAK", b"The true freak", b"Be freak", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidhsandjem72w7sfvqzgkwdx3vszybihqbl56j7dm5pygefvmr5em")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FREAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FREAK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

