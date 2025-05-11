module 0x5a8a80ec8c71617f149cd90b0be9df029c745361c9394d573b5af4bf8a9d6d42::sfn {
    struct SFN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFN>(arg0, 6, b"SFN", b"Sui Funny", b"New Sui Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibftkekx57h4li5uzd6b567bijkkefwuxsld3ny4t3kbo4dyewwoq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SFN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

