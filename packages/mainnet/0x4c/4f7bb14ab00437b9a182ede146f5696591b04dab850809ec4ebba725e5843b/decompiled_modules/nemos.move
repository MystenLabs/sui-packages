module 0x4c4f7bb14ab00437b9a182ede146f5696591b04dab850809ec4ebba725e5843b::nemos {
    struct NEMOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEMOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEMOS>(arg0, 6, b"NEMOS", b"NEMOS SUI", b"NEMOS IS MEME TOKEN OFFICIAL FROM SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiazgyhvtj52eiulbu2pxiotdk3rsoffwfqbk2ggk6og7ie342cixm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEMOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NEMOS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

