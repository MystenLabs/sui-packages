module 0xfd6258658d2d5cc738c6cf3741ca56c0007e2354fda72ab4aeae7664d81df882::sui {
    struct SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI>(arg0, 6, b"SUI", b"Super Unstable Investment", b"Super Unstable Investment. The most degenerate memecoin on Sui. No utility, all vibes, instant regret.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihnu3x24saomuwig33tohtifrfj34ij5xe7qmlbp3xuvzbyijdlle")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

