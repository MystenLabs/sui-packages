module 0xcd54ca86137324f354b72dd9336aad990f767c05f342d4392e8b7f93f5928779::mew2 {
    struct MEW2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEW2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEW2>(arg0, 6, b"MEW2", b"MewTwo", b"Building the first pokemon TCG game on the Sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibh7rj6h4burltzqg2hva4a2duca3u72e6yqyvypilnjuiqjq4gre")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEW2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MEW2>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

