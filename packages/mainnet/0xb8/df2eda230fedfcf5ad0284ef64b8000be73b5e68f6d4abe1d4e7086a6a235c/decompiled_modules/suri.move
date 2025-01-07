module 0xb8df2eda230fedfcf5ad0284ef64b8000be73b5e68f6d4abe1d4e7086a6a235c::suri {
    struct SURI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SURI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SURI>(arg0, 6, b"SURI", b"SURI SUI", b"SURI Sui based meme coin with the sole purpose of bringing good vibes!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731002604158.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SURI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SURI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

