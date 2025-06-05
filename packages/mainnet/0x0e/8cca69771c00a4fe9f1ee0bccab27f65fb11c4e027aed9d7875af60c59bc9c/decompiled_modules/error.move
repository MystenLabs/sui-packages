module 0xe8cca69771c00a4fe9f1ee0bccab27f65fb11c4e027aed9d7875af60c59bc9c::error {
    struct ERROR has drop {
        dummy_field: bool,
    }

    fun init(arg0: ERROR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ERROR>(arg0, 6, b"ERROR", b"404", b"Just a 404 error meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibtwulnwvwagdd5n5gf4mka4ykkranax22qgrk3stt6gnkzyle6xm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ERROR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ERROR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

