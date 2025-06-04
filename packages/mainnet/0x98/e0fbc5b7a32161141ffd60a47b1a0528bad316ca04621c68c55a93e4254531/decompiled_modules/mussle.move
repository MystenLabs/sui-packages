module 0x98e0fbc5b7a32161141ffd60a47b1a0528bad316ca04621c68c55a93e4254531::mussle {
    struct MUSSLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUSSLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUSSLE>(arg0, 6, b"MUSSLE", b"Sui Mussle", b"Lf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigbb7ydnvi5xbquszrb2ocqjywzg5cd4sk7czfuvbzxixq4jpqknq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUSSLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MUSSLE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

