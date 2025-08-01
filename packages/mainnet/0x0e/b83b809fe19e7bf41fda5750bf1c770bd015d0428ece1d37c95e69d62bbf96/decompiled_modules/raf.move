module 0xeb83b809fe19e7bf41fda5750bf1c770bd015d0428ece1d37c95e69d62bbf96::raf {
    struct RAF has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAF>(arg0, 6, b"RAF", b"SUI RAFFLE", b"Raffle Rewards Daily", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibpjxthw5ewxepodla2veslbncnj7bd2hjx5zn3ljgfld2daiu4mi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RAF>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

