module 0x1847bc8f317fea27c424c5679411f63620fb07959406e0ba0bf0fa1bc56f4c73::scb2 {
    struct SCB2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCB2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCB2>(arg0, 6, b"SCB2", b"Sacabam Loyalist", b"LETS SACABAM GREAT AND NO.1 AGAIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifalbc4a4ooaemj532tw3z5oy2yzmqnuorslgjebqvvjt73pbbaqq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCB2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SCB2>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

