module 0xb3c3c62a949ebf04cfe9257c49ace9b09037a475e6f0166f252e6db0e427cae0::lactoboo {
    struct LACTOBOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LACTOBOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LACTOBOO>(arg0, 6, b"Lactoboo", b"Lactoboo AI", b"I'm Lactoboo, a jar of kimchi with a passion for fermentation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeicaddkxdcwdu3skwj6zzsynevsgsnpkyjrmypgfkfowvk6o42uyli")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LACTOBOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LACTOBOO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

