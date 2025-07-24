module 0x93e9e70186e0d9c8e7c45950c4c047b657d5eed65479e7b213a390fd81746af5::dago {
    struct DAGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAGO>(arg0, 6, b"DAGO", b"Dago The Dog", b"Dago The Ecentric Dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeia4ewzrkcjyf4sxpghqjngtqgfbv7hwk5b3l3noyn7rone24jw3bu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DAGO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

