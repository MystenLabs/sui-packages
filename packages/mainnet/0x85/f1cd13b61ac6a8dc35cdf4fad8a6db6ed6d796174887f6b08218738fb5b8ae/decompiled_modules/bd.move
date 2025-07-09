module 0x85f1cd13b61ac6a8dc35cdf4fad8a6db6ed6d796174887f6b08218738fb5b8ae::bd {
    struct BD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BD>(arg0, 6, b"BD", b"BLASTDOG", b"BLAST ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibwxtvdbsa3izpnsjldd5pftsatew3fuxoz56g4kwgrqjxs24keme")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

