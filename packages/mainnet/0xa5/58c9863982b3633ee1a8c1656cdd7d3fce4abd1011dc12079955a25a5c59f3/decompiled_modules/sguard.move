module 0xa558c9863982b3633ee1a8c1656cdd7d3fce4abd1011dc12079955a25a5c59f3::sguard {
    struct SGUARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGUARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGUARD>(arg0, 6, b"SGUARD", b"Sui Guard Protection", b"SGUARD is specifically designed to be a security in the sui network, using innovative and advanced security methods", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibe4ocvz6wvswt4nuyr3cxnb7zaxq5bjhi6knesdyx67lm57xixoq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGUARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SGUARD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

