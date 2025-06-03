module 0x8ffb691b1c548be3256aadbafa4ddce7c666bb376c3b68e79c14d520808c47d6::fishd {
    struct FISHD has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISHD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISHD>(arg0, 6, b"FISHD", b"Fishdog", b"Fishdog is now swimming in the open sea", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiebyv4ojawuqgu7ehrior3dyztbz6x4uor53jl4rnwrvkkctxvfy4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISHD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FISHD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

