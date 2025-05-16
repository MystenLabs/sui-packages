module 0x49d901ccafabe3685477839ba630343c9d35c377ebf0b0d3cc2505ac547eeb6f::evofrog {
    struct EVOFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVOFROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EVOFROG>(arg0, 6, b"EVOFROG", b"EVOFROG SUI", b"EvoFrog $EVF - Evolve to the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiayewkt56frjtvp6r2j3tyes4bdzsryniteol3ws6mjvgnt7oshwi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVOFROG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<EVOFROG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

