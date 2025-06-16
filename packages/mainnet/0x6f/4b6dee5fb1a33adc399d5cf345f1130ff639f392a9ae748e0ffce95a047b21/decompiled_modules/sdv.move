module 0x6f4b6dee5fb1a33adc399d5cf345f1130ff639f392a9ae748e0ffce95a047b21::sdv {
    struct SDV has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDV>(arg0, 6, b"SDV", b"sdvc", b"sdfsf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreid4wxlxm3uurxwpotggngjv2nnvwypzf7hg7n5wgjdpanpcpmac4m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SDV>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

