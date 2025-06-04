module 0xd90df4befb863b42c7c6ec3e6653b1d75bfc91724485ea53e31fa80c5cba2302::suipig {
    struct SUIPIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPIG>(arg0, 6, b"SUIPIG", b"Sui Pig", b"Peppa The Sui Pig", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeielrxpkm7mkwgtlzictumrk3btbrnqpsc6ayosjgw6lrl764jsepy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIPIG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

