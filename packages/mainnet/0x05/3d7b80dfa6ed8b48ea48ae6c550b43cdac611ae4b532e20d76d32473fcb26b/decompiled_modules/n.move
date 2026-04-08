module 0x53d7b80dfa6ed8b48ea48ae6c550b43cdac611ae4b532e20d76d32473fcb26b::n {
    struct N has drop {
        dummy_field: bool,
    }

    fun init(arg0: N, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<N>(arg0, 9, b"N", b"nioCoin", b"Governance token for the nioCoin ecosystem. First token on nioCoin factory. 0-fee DLMM pool.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aggregator.walrus.space/v1/blobs/Q6PxX1tKS3KhUsjqhC2vKQtA2qGkY35uI1oREx7NIXs")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<N>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<N>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

