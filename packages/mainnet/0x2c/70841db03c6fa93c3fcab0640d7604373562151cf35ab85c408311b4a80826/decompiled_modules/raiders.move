module 0x2c70841db03c6fa93c3fcab0640d7604373562151cf35ab85c408311b4a80826::raiders {
    struct RAIDERS has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAIDERS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAIDERS>(arg0, 6, b"RAIDERS", b"WE NEED RAIDERS", b"GMGM -> PLEASE RAIDERS, SHILLERS, CALLERS, VCs, ETC. JOIN. APPLY FOR JOB!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidrzswjmufwiaeidxcif5kjumzoptpgc3vqyyx4o3afncbyopzrqy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAIDERS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RAIDERS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

