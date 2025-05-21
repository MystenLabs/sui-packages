module 0x5de616049082aa7d516917009b4799cc869ded580360eeb12bb3188e6e86be5::skate {
    struct SKATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKATE>(arg0, 6, b"SKATE", b"Sui Skate", b"The first skate coin on sui network!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicg6iisxaurex7jeg2h7tgbujjoe352dt4mwxke6ak2bywjv2v35i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKATE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SKATE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

