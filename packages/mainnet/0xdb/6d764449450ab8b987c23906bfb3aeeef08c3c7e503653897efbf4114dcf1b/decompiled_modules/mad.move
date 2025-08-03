module 0xdb6d764449450ab8b987c23906bfb3aeeef08c3c7e503653897efbf4114dcf1b::mad {
    struct MAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAD>(arg0, 6, b"MAD", b"Mad Hopperz", b"The ticker is $MAD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreib6idiomhwwvahezt4dpsp4iuziexjx7tvv72txdydd7qseqm5kbe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MAD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

