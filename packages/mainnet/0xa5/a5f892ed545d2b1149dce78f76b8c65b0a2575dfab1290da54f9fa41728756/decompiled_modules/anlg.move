module 0xa5a5f892ed545d2b1149dce78f76b8c65b0a2575dfab1290da54f9fa41728756::anlg {
    struct ANLG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANLG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANLG>(arg0, 6, b"ANLG", b"Analog", b"Rewind to the warm, tangible feel of 80s cassette tapes! This coin celebrates the era of mixtapes and raw sound. Experience the nostalgic hum of classic tech, now on a modern, decentralized network. Get ready to press play on the past, in the future.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeie5i46rd6enuv7a5z26fxrmnntaefcuyoru6z5wpozbyy5sxtmqb4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANLG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ANLG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

