module 0x1aec005dbf53d1bdb8f31b63704c34d34dea445bd723b67bc052b53465f6f83::fox {
    struct FOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOX>(arg0, 6, b"FOX", b"Foxy", b"Sui Foxy , all new concept . The minimalism is our home.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigfclciixtt3ibpubnm4agke46rdqd7cesgm3nffaicg4geuabzlm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FOX>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

